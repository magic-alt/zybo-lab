#include "xil_printf.h"
#include "sleep.h"

int main(void)
{
    xil_printf("\r\nzybo-lab Lab03: PS UART\r\n");
    xil_printf("Target: original Digilent ZYBO / Zynq-7010\r\n");

    unsigned count = 0;
    while (1) {
        xil_printf("heartbeat %u\r\n", count++);
        sleep(1);
    }

    return 0;
}
