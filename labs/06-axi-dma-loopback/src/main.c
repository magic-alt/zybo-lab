#include "xaxidma.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xparameters.h"

#define DMA_DEVICE_ID XPAR_AXIDMA_0_DEVICE_ID
#define WORDS 256

static u32 tx[WORDS] __attribute__((aligned(64)));
static u32 rx[WORDS] __attribute__((aligned(64)));

int main(void)
{
    XAxiDma dma;
    XAxiDma_Config *cfg = XAxiDma_LookupConfig(DMA_DEVICE_ID);
    if (!cfg) return XST_FAILURE;

    if (XAxiDma_CfgInitialize(&dma, cfg) != XST_SUCCESS)
        return XST_FAILURE;

    if (XAxiDma_HasSg(&dma)) {
        xil_printf("This lab expects simple mode\r\n");
        return XST_FAILURE;
    }

    for (unsigned i = 0; i < WORDS; ++i) {
        tx[i] = 0xA5000000u ^ i;
        rx[i] = 0;
    }

    Xil_DCacheFlushRange((UINTPTR)tx, sizeof(tx));
    Xil_DCacheFlushRange((UINTPTR)rx, sizeof(rx));

    int s = XAxiDma_SimpleTransfer(&dma, (UINTPTR)rx, sizeof(rx),
                                   XAXIDMA_DEVICE_TO_DMA);
    if (s != XST_SUCCESS) return XST_FAILURE;

    s = XAxiDma_SimpleTransfer(&dma, (UINTPTR)tx, sizeof(tx),
                               XAXIDMA_DMA_TO_DEVICE);
    if (s != XST_SUCCESS) return XST_FAILURE;

    while (XAxiDma_Busy(&dma, XAXIDMA_DMA_TO_DEVICE)) {}
    while (XAxiDma_Busy(&dma, XAXIDMA_DEVICE_TO_DMA)) {}

    Xil_DCacheInvalidateRange((UINTPTR)rx, sizeof(rx));

    for (unsigned i = 0; i < WORDS; ++i) {
        if (rx[i] != tx[i]) {
            xil_printf("Mismatch %u: tx=%08lx rx=%08lx\r\n",
                       i, (unsigned long)tx[i], (unsigned long)rx[i]);
            return XST_FAILURE;
        }
    }

    xil_printf("PASS Lab06 AXI DMA loopback\r\n");
    return XST_SUCCESS;
}
