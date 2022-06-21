#ifndef SRC_DEFINES_H_
#define SRC_DEFINES_H_

/***************************** Include Files *********************************/
#include "xparameters.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xgpio_l.h"
#ifdef XPAR_UARTNS550_0_BASEADDR
#include "xuartns550_l.h"
#endif

/************************** Constant Definitions *****************************/

// UART
#ifdef XPAR_UARTNS550_0_BASEADDR
  #define UART_BASEADDR              XPAR_UARTNS550_0_BASEADDR
  #define UART_DEVICE_ID             XPAR_UARTNS550_0_DEVICE_ID
  #define UART_CLOCK_HZ              XPAR_XUARTNS550_CLOCK_HZ
  #ifdef SIMULATION_MODE
    #define UART_BAUDRATE            (UART_CLOCK_HZ /16)
  #else
    #define UART_BAUDRATE            9600
  #endif
#endif
#ifdef XPAR_UARTLITE_0_BASEADDR
  #define UART_BASEADDR              XPAR_UARTLITE_0_BASEADDR
  #define UART_DEVICE_ID             XPAR_UARTLITE_0_DEVICE_ID
  #define UART_BAUDRATE              XPAR_UARTLITE_0_BAUDRATE
#endif


// GPIO
#define GPIO_BASEADDR              XPAR_GPIO_0_BASEADDR
#define GPIO_DEVICE_ID             XPAR_GPIO_0_DEVICE_ID
//#define LED_CHANNEL                1 // Channel 1: LEDs[0:3]
//#define CTRL_CHANNEL               2 // Channel 2: Inputs[0:1], Output[2:3]


// AXI Software Reset
//#define SW_RESET_BASEADDR          XPAR_DTI_AXI_SW_RESET_0_BASEADDR

/************************ Type Definition *************************************/
typedef   u8    bool;
#define   true    1
#define   false   0

/************************ Variable Definition *********************************/
//extern XGpio gpioIns;
extern int TOTAL_FAIL;

/************************ Function prototype **********************************/
void setupUart();
void setupGpio();

void iPrint(const char8 *char1, ...); // print in both SIM and REAL mode
void sPrint(const char8 *char1, ...); // print in SIM mode but do not print in REAL mode
void rPrint(const char8 *char1, ...); // print in REAL mode but do not print in SIM mode


#endif /* SRC_DEFINES_H_ */
