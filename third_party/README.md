# Third-party reproducibility

Large historical Digilent projects are not vendored into this repository.

Run:

~~~bash
make legacy-ip
~~~

This performs a sparse checkout of **Digilent/ZYBO** pinned to:

`834fd71ed0349b8be6594a75f63a5f0c1f6ba615`

Only the Original ZYBO reference material required for the HDMI/audio legacy backends is checked out. Lab 09 copies the pinned `Projects/hdmi_out` tree into its build directory before invoking Digilent's exported Vivado Tcl.

The checkout remains governed by the upstream repository's licenses. It is intentionally ignored by Git.

The sparse checkout contains three full-board legacy references:

- Projects/dma — official SSM2603 + AXI DMA audio design;
- Projects/hdmi_out — official Original-ZYBO HDMI source design;
- Projects/hdmi_in — official Original-ZYBO HDMI sink design.

Modern-native labs remain independent of these trees; these are explicit compatibility baselines.
