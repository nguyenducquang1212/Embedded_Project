#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "driver/uart.h"
#include "driver/ledc.h"
#include <esp_http_server.h>

#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "sdkconfig.h"
#include "nvs_flash.h"
#include "lwip/err.h"
#include "lwip/sys.h"

static const char *TAG = "embedded_project";

#define GPIO_SERVO 13
#define GPIO_INPUT 12
#define UART_TX GPIO_NUM_17
#define UART_RX GPIO_NUM_16

#define GPIO_INPUT_PIN_SEL (1ULL << GPIO_INPUT)
#define ESP_WIFI_SSID "Embedded"
#define ESP_WIFI_PASS "12345678"

const uint8_t index_html_start[] asm(" _binary_index_html_start");
const uint8_t index_html_end[] asm(" _binary_index_html_end");
volatile uint16_t speed_t;
char speed_s[6];

void uart_config(void)
{
    uart_config_t uart_config = {
        .baud_rate = 9600,
        .data_bits = UART_DATA_8_BITS,
        .parity = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
        .source_clk = UART_SCLK_APB,

    };
    uart_param_config(UART_NUM_1, &uart_config);
    uart_set_pin(UART_NUM_1, UART_TX, UART_RX, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
    uart_driver_install(UART_NUM_1, 256, 0, 0, NULL, 0);
    printf("UART driver installed\n");
}

void pwm_config(void)
{
    ledc_timer_config_t ledc_timer = {
        .duty_resolution = LEDC_TIMER_10_BIT, // resolution of PWM duty
        .freq_hz = 50,                        // frequency of PWM signal
        .speed_mode = LEDC_LOW_SPEED_MODE,    // timer mode
        .timer_num = LEDC_TIMER_1,            // timer index
        .clk_cfg = LEDC_AUTO_CLK,             // Auto select the source clock
    };
    ledc_timer_config(&ledc_timer);

    ledc_channel_config_t ledc_channel = {
        .channel = LEDC_CHANNEL_0,
        .duty = 0,
        .gpio_num = GPIO_SERVO,
        .speed_mode = LEDC_LOW_SPEED_MODE,
        .hpoint = 0,
        .timer_sel = LEDC_TIMER_1,
    };
    ledc_channel_config(&ledc_channel);
}

void _gpio_config(void)
{
    gpio_config_t io_conf;
    io_conf.intr_type = GPIO_PIN_INTR_ANYEDGE;
    io_conf.mode = GPIO_MODE_INPUT;
    io_conf.pin_bit_mask = GPIO_INPUT_PIN_SEL;
    io_conf.pull_down_en = GPIO_PULLDOWN_DISABLE;
    io_conf.pull_up_en = GPIO_PULLUP_ENABLE;
    gpio_config(&io_conf);
}

static esp_err_t main_handler(httpd_req_t *req)
{
    httpd_resp_set_type(req, "text/html");
    httpd_resp_send(req, (const char *)index_html_start, index_html_end - index_html_start);
    return ESP_OK;
}

static esp_err_t get_speed_handler(httpd_req_t *req)
{

    httpd_resp_send(req, speed_s, sizeof(speed_s));
    return ESP_OK;
}

static const httpd_uri_t get_speed = {
    .uri = "/get_speed",
    .method = HTTP_GET,
    .handler = get_speed_handler,
    .user_ctx = NULL};

static const httpd_uri_t mainn =
    {
        .uri = "/",
        .method = HTTP_GET,
        .handler = main_handler,
        .user_ctx = NULL};
void start_web_server(void)
{
    httpd_config_t config = HTTPD_DEFAULT_CONFIG();
    httpd_handle_t server = NULL;
    ESP_ERROR_CHECK(httpd_start(&server, &config));
    ESP_LOGI(TAG, "Server started");
    httpd_register_uri_handler(server, &get_speed);
    httpd_register_uri_handler(server, &mainn);
}

static void wifi_event_handler(void *arg, esp_event_base_t event_base,
                               int32_t event_id, void *event_data)
{
    if (event_id == WIFI_EVENT_AP_STACONNECTED)
    {
        wifi_event_ap_staconnected_t *event = (wifi_event_ap_staconnected_t *)event_data;
        ESP_LOGI(TAG, "station " MACSTR " join, AID=%d",
                 MAC2STR(event->mac), event->aid);
    }
    else if (event_id == WIFI_EVENT_AP_STADISCONNECTED)
    {
        wifi_event_ap_stadisconnected_t *event = (wifi_event_ap_stadisconnected_t *)event_data;
        ESP_LOGI(TAG, "station " MACSTR " leave, AID=%d",
                 MAC2STR(event->mac), event->aid);
    }
}

void wifi_init_softap(void)
{
    ESP_ERROR_CHECK(esp_netif_init());
    ESP_ERROR_CHECK(esp_event_loop_create_default());
    esp_netif_create_default_wifi_ap();

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));

    ESP_ERROR_CHECK(esp_event_handler_instance_register(WIFI_EVENT,
                                                        ESP_EVENT_ANY_ID,
                                                        &wifi_event_handler,
                                                        NULL,
                                                        NULL));

    wifi_config_t wifi_config = {
        .ap = {
            .ssid = ESP_WIFI_SSID,
            .ssid_len = strlen(ESP_WIFI_SSID),
            .channel = 1,
            .password = ESP_WIFI_PASS,
            .max_connection = 3,
            .authmode = WIFI_AUTH_WPA_WPA2_PSK,
            // .pmf_cfg = {
            //         .required = false,
            // },
        },
    };

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_AP));
    ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_AP, &wifi_config));
    ESP_ERROR_CHECK(esp_wifi_start());

    ESP_LOGI(TAG, "wifi_init_softap finished.");
}

static void uart_task(void *pvParameters)
{
    uint8_t rx_buffer[128];

    for (;;)
    {
        // speed_t++;
        // sprintf(speed_s, "%d", speed_t);

        int rx_length = uart_read_bytes(UART_NUM_1, rx_buffer, sizeof(rx_buffer), 20 / portTICK_RATE_MS);
        if (rx_length > 0)
        {
            printf("%d bytes received\n", rx_length);
            printf("%x\n", rx_buffer[1]);
            printf("%x\n", rx_buffer[0]);
            speed_t = rx_buffer[1];
            speed_t <<= 4;
            speed_t |= (rx_buffer[0] >> 4);
            printf("speed %x\n", speed_t);
            printf("speed %d\n", speed_t);
            memset(speed_s, 0, 6);
            sprintf(speed_s, "%d", speed_t);
        }
        // for (size_t i = 0; i < rx_length; i++)
        // {
        //     printf("%x", rx_buffer[i]);
        // }

        vTaskDelay(10 / portTICK_RATE_MS);
    }
}

static void gpio_task(void *pvParameters)
{
    for (;;)
    {
        if (gpio_get_level(GPIO_INPUT) == 0)
        {
            ledc_set_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_0, 51);
            printf("0\n");
        }
        else
        {
            ledc_set_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_0, 102);
            printf("1\n");
        }
        ledc_update_duty(LEDC_LOW_SPEED_MODE, LEDC_CHANNEL_0);
        vTaskDelay(100 / portTICK_RATE_MS);
    }
}

void app_main(void)
{

    uart_config();
    pwm_config();
    _gpio_config();

    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND)
    {
        ESP_ERROR_CHECK(nvs_flash_erase());
        ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK(ret);

    ESP_LOGI(TAG, "ESP_WIFI_MODE_AP");
    wifi_init_softap();
    start_web_server();
    xTaskCreate(uart_task, "uart_task", 2048, NULL, 5, NULL);
    xTaskCreate(gpio_task, "gpio_task", 1024, NULL, 5, NULL);
}
