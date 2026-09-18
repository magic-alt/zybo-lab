#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"

#define GPIO_DEVICE_ID XPAR_AXI_GPIO_0_DEVICE_ID

int main(void)
{
    XGpio gpio;
    int status = XGpio_Initialize(&gpio, GPIO_DEVICE_ID);
    if (status != XST_SUCCESS) {
        xil_printf("XGpio_Initialize failed\r\n");
        return XST_FAILURE;
    }

    XGpio_SetDataDirection(&gpio, 1, 0x0);

    for (unsigned value = 0;; value = (value + 1) & 0xF) {
        XGpio_DiscreteWrite(&gpio, 1, value);
        xil_printf("LED = 0x%x\r\n", value);
        usleep(250000);
    }
}
