#include "define.h"


/************************** Variable Definitions *****************************/
//XGpio gpioIns;
int TOTAL_FAIL = 0;

/*************************** Function Definitions *****************************/
// Set the baud rate and number of stop bits
void setupUart() {
	XUartNs550_SetBaud(UART_BASEADDR, UART_CLOCK_HZ, UART_BAUDRATE);
	XUartNs550_SetLineControlReg(UART_BASEADDR, XUN_LCR_8_DATA_BITS);
}
// Setup GPIO driver
//void setupGpio() {
//	// Initialize the GPIO driver so that it's ready to use,
//	int status = XGpio_Initialize(&gpioIns, GPIO_DEVICE_ID);
//	if (status != XST_SUCCESS) {
//		return;
//	}

// Print information
void iPrint(const char8 *char1, ...) {
	xil_printf(char1);
}

// Print information
void sPrint(const char8 *char1, ...) {
#ifdef SIMULATION_MODE
	xil_printf(char1);
#endif
}

// Print information
void rPrint(const char8 *char1, ...) {
#ifndef SIMULATION_MODE
	xil_printf(char1);
#endif
}

