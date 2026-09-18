#include "xgpio.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"

#define GPIO_DEVICE_ID XPAR_AXI_GPIO_0_DEVICE_ID
#define GIC_DEVICE_ID  XPAR_SCUGIC_SINGLE_DEVICE_ID
#define GPIO_IRPT_ID XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR

static XGpio gpio;
static XScuGic gic;
static volatile u32 pending = 0;
static volatile u32 last_buttons = 0;

static void gpio_isr(void *ref)
{
    XGpio *g = (XGpio *)ref;
    u32 status = XGpio_InterruptGetStatus(g);

    if (status & XGPIO_IR_CH1_MASK) {
        last_buttons = XGpio_DiscreteRead(g, 1);
        pending = 1;
    }

    XGpio_InterruptClear(g, status);
}

static int init_interrupts(void)
{
    XScuGic_Config *cfg = XScuGic_LookupConfig(GIC_DEVICE_ID);
    if (!cfg) return XST_FAILURE;

    int s = XScuGic_CfgInitialize(&gic, cfg, cfg->CpuBaseAddress);
    if (s != XST_SUCCESS) return s;

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(
        XIL_EXCEPTION_ID_INT,
        (Xil_ExceptionHandler)XScuGic_InterruptHandler,
        &gic);

    s = XScuGic_Connect(&gic, GPIO_IRPT_ID,
                        (Xil_InterruptHandler)gpio_isr, &gpio);
    if (s != XST_SUCCESS) return s;

    XScuGic_Enable(&gic, GPIO_IRPT_ID);
    Xil_ExceptionEnable();
    return XST_SUCCESS;
}

int main(void)
{
    if (XGpio_Initialize(&gpio, GPIO_DEVICE_ID) != XST_SUCCESS)
        return XST_FAILURE;

    XGpio_SetDataDirection(&gpio, 1, 0xF);
    XGpio_InterruptClear(&gpio, XGPIO_IR_CH1_MASK);
    XGpio_InterruptEnable(&gpio, XGPIO_IR_CH1_MASK);
    XGpio_InterruptGlobalEnable(&gpio);

    if (init_interrupts() != XST_SUCCESS)
        return XST_FAILURE;

    xil_printf("Lab05 ready\r\n");

    while (1) {
        if (pending) {
            u32 v = last_buttons;
            pending = 0;
            xil_printf("buttons = 0x%lx\r\n", (unsigned long)v);
        }
        usleep(1000);
    }
}
