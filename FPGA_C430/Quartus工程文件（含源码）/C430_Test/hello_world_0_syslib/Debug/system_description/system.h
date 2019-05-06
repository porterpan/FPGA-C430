/* system.h
 *
 * Machine generated for a CPU named "cpu" as defined in:
 * E:\C430_Test\NIOSTOP.ptf
 *
 * Generated: 2013-09-29 00:55:11.545
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "NIOSTOP"
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEIVE"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN_BASE 0x00001918
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_PRESENT
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT_BASE 0x00001918
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_PRESENT
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDERR_BASE 0x00001918
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_PRESENT
#define ALT_CPU_FREQ 100000000
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_BIG_ENDIAN 0
#define NIOS2_INTERRUPT_CONTROLLER_ID 0

#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x04000020
#define NIOS2_RESET_ADDR 0x00000000
#define NIOS2_BREAK_ADDR 0x00001020

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SPI

/*
 * sysid configuration
 *
 */

#define SYSID_NAME "/dev/sysid"
#define SYSID_TYPE "altera_avalon_sysid"
#define SYSID_BASE 0x00001910
#define SYSID_SPAN 8
#define SYSID_ID 0u
#define SYSID_TIMESTAMP 1380386782u
#define SYSID_REGENERATE_VALUES 0
#define ALT_MODULE_CLASS_sysid altera_avalon_sysid

/*
 * sdram configuration
 *
 */

#define SDRAM_NAME "/dev/sdram"
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_BASE 0x04000000
#define SDRAM_SPAN 33554432
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_ADDR_WIDTH 13
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SDRAM_COL_WIDTH 9
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_CAS_LATENCY 3
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_AC 5.5
#define SDRAM_T_WR 14.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_SHARED_DATA 0
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_IS_INITIALIZED 1
#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller

/*
 * epcs configuration
 *
 */

#define EPCS_NAME "/dev/epcs"
#define EPCS_TYPE "altera_avalon_epcs_flash_controller"
#define EPCS_BASE 0x00000000
#define EPCS_SPAN 2048
#define EPCS_IRQ 0
#define EPCS_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_DATABITS 8
#define EPCS_TARGETCLOCK 20
#define EPCS_CLOCKUNITS "MHz"
#define EPCS_CLOCKMULT 1000000
#define EPCS_NUMSLAVES 1
#define EPCS_ISMASTER 1
#define EPCS_CLOCKPOLARITY 0
#define EPCS_CLOCKPHASE 0
#define EPCS_LSBFIRST 0
#define EPCS_EXTRADELAY 0
#define EPCS_TARGETSSDELAY 100
#define EPCS_DELAYUNITS "us"
#define EPCS_DELAYMULT "1e-006"
#define EPCS_PREFIX "epcs_"
#define EPCS_REGISTER_OFFSET 0x400
#define EPCS_IGNORE_LEGACY_CHECK 1
#define EPCS_USE_ASMI_ATOM 0
#define EPCS_CLOCKUNIT "kHz"
#define EPCS_DELAYUNIT "us"
#define EPCS_DISABLEAVALONFLOWCONTROL 0
#define EPCS_INSERT_SYNC 0
#define EPCS_SYNC_REG_DEPTH 2
#define ALT_MODULE_CLASS_epcs altera_avalon_epcs_flash_controller

/*
 * jtag_uart configuration
 *
 */

#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_BASE 0x00001918
#define JTAG_UART_SPAN 8
#define JTAG_UART_IRQ 1
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_ALLOW_LEGACY_SIGNALS 1
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_READ_CHAR_STREAM ""
#define JTAG_UART_SHOWASCII 1
#define JTAG_UART_RELATIVEPATH 1
#define JTAG_UART_READ_LE 0
#define JTAG_UART_WRITE_LE 0
#define JTAG_UART_ALTERA_SHOW_UNRELEASED_JTAG_UART_FEATURES 1
#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart

/*
 * pio_led configuration
 *
 */

#define PIO_LED_NAME "/dev/pio_led"
#define PIO_LED_TYPE "altera_avalon_pio"
#define PIO_LED_BASE 0x00001820
#define PIO_LED_SPAN 16
#define PIO_LED_DO_TEST_BENCH_WIRING 0
#define PIO_LED_DRIVEN_SIM_VALUE 0
#define PIO_LED_HAS_TRI 0
#define PIO_LED_HAS_OUT 1
#define PIO_LED_HAS_IN 0
#define PIO_LED_CAPTURE 0
#define PIO_LED_DATA_WIDTH 4
#define PIO_LED_RESET_VALUE 0
#define PIO_LED_EDGE_TYPE "NONE"
#define PIO_LED_IRQ_TYPE "NONE"
#define PIO_LED_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LED_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LED_FREQ 100000000
#define ALT_MODULE_CLASS_pio_led altera_avalon_pio

/*
 * LAN configuration
 *
 */

#define LAN_NAME "/dev/LAN"
#define LAN_TYPE "altera_avalon_spi"
#define LAN_BASE 0x00001800
#define LAN_SPAN 32
#define LAN_IRQ 2
#define LAN_IRQ_INTERRUPT_CONTROLLER_ID 0
#define LAN_DATABITS 8
#define LAN_DATAWIDTH 16
#define LAN_TARGETCLOCK 10000000
#define LAN_CLOCKUNITS "Hz"
#define LAN_CLOCKMULT 1
#define LAN_NUMSLAVES 1
#define LAN_ISMASTER 1
#define LAN_ALLOW_LEGACY_SIGNALS 1
#define LAN_CLOCKPOLARITY 0
#define LAN_CLOCKPHASE 0
#define LAN_LSBFIRST 0
#define LAN_EXTRADELAY 0
#define LAN_INSERT_SYNC 0
#define LAN_SYNC_REG_DEPTH 2
#define LAN_DISABLEAVALONFLOWCONTROL 0
#define LAN_TARGETSSDELAY 0.0
#define LAN_DELAYUNITS "ns"
#define LAN_DELAYMULT "1e-009"
#define LAN_PREFIX "spi_"
#define LAN_CLOCKUNIT "kHz"
#define LAN_DELAYUNIT "us"
#define ALT_MODULE_CLASS_LAN altera_avalon_spi

/*
 * LAN_CS configuration
 *
 */

#define LAN_CS_NAME "/dev/LAN_CS"
#define LAN_CS_TYPE "altera_avalon_pio"
#define LAN_CS_BASE 0x00001830
#define LAN_CS_SPAN 16
#define LAN_CS_DO_TEST_BENCH_WIRING 0
#define LAN_CS_DRIVEN_SIM_VALUE 0
#define LAN_CS_HAS_TRI 0
#define LAN_CS_HAS_OUT 1
#define LAN_CS_HAS_IN 0
#define LAN_CS_CAPTURE 0
#define LAN_CS_DATA_WIDTH 1
#define LAN_CS_RESET_VALUE 0
#define LAN_CS_EDGE_TYPE "NONE"
#define LAN_CS_IRQ_TYPE "NONE"
#define LAN_CS_BIT_CLEARING_EDGE_REGISTER 0
#define LAN_CS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LAN_CS_FREQ 100000000
#define ALT_MODULE_CLASS_LAN_CS altera_avalon_pio

/*
 * LAN_nINT configuration
 *
 */

#define LAN_NINT_NAME "/dev/LAN_nINT"
#define LAN_NINT_TYPE "altera_avalon_pio"
#define LAN_NINT_BASE 0x00001840
#define LAN_NINT_SPAN 16
#define LAN_NINT_IRQ ALT_IRQ_NOT_CONNECTED
#define LAN_NINT_IRQ_INTERRUPT_CONTROLLER_ID 0
#define LAN_NINT_DO_TEST_BENCH_WIRING 0
#define LAN_NINT_DRIVEN_SIM_VALUE 0
#define LAN_NINT_HAS_TRI 0
#define LAN_NINT_HAS_OUT 0
#define LAN_NINT_HAS_IN 1
#define LAN_NINT_CAPTURE 0
#define LAN_NINT_DATA_WIDTH 1
#define LAN_NINT_RESET_VALUE 0
#define LAN_NINT_EDGE_TYPE "NONE"
#define LAN_NINT_IRQ_TYPE "LEVEL"
#define LAN_NINT_BIT_CLEARING_EDGE_REGISTER 0
#define LAN_NINT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LAN_NINT_FREQ 100000000
#define ALT_MODULE_CLASS_LAN_nINT altera_avalon_pio

/*
 * LAN_RSTN configuration
 *
 */

#define LAN_RSTN_NAME "/dev/LAN_RSTN"
#define LAN_RSTN_TYPE "altera_avalon_pio"
#define LAN_RSTN_BASE 0x00001850
#define LAN_RSTN_SPAN 16
#define LAN_RSTN_DO_TEST_BENCH_WIRING 0
#define LAN_RSTN_DRIVEN_SIM_VALUE 0
#define LAN_RSTN_HAS_TRI 0
#define LAN_RSTN_HAS_OUT 1
#define LAN_RSTN_HAS_IN 0
#define LAN_RSTN_CAPTURE 0
#define LAN_RSTN_DATA_WIDTH 1
#define LAN_RSTN_RESET_VALUE 0
#define LAN_RSTN_EDGE_TYPE "NONE"
#define LAN_RSTN_IRQ_TYPE "NONE"
#define LAN_RSTN_BIT_CLEARING_EDGE_REGISTER 0
#define LAN_RSTN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LAN_RSTN_FREQ 100000000
#define ALT_MODULE_CLASS_LAN_RSTN altera_avalon_pio

/*
 * USB_SCS_O configuration
 *
 */

#define USB_SCS_O_NAME "/dev/USB_SCS_O"
#define USB_SCS_O_TYPE "altera_avalon_pio"
#define USB_SCS_O_BASE 0x00001860
#define USB_SCS_O_SPAN 16
#define USB_SCS_O_DO_TEST_BENCH_WIRING 0
#define USB_SCS_O_DRIVEN_SIM_VALUE 0
#define USB_SCS_O_HAS_TRI 0
#define USB_SCS_O_HAS_OUT 1
#define USB_SCS_O_HAS_IN 0
#define USB_SCS_O_CAPTURE 0
#define USB_SCS_O_DATA_WIDTH 1
#define USB_SCS_O_RESET_VALUE 0
#define USB_SCS_O_EDGE_TYPE "NONE"
#define USB_SCS_O_IRQ_TYPE "NONE"
#define USB_SCS_O_BIT_CLEARING_EDGE_REGISTER 0
#define USB_SCS_O_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_SCS_O_FREQ 100000000
#define ALT_MODULE_CLASS_USB_SCS_O altera_avalon_pio

/*
 * USB_SDO_I configuration
 *
 */

#define USB_SDO_I_NAME "/dev/USB_SDO_I"
#define USB_SDO_I_TYPE "altera_avalon_pio"
#define USB_SDO_I_BASE 0x00001870
#define USB_SDO_I_SPAN 16
#define USB_SDO_I_DO_TEST_BENCH_WIRING 0
#define USB_SDO_I_DRIVEN_SIM_VALUE 0
#define USB_SDO_I_HAS_TRI 0
#define USB_SDO_I_HAS_OUT 0
#define USB_SDO_I_HAS_IN 1
#define USB_SDO_I_CAPTURE 0
#define USB_SDO_I_DATA_WIDTH 1
#define USB_SDO_I_RESET_VALUE 0
#define USB_SDO_I_EDGE_TYPE "NONE"
#define USB_SDO_I_IRQ_TYPE "NONE"
#define USB_SDO_I_BIT_CLEARING_EDGE_REGISTER 0
#define USB_SDO_I_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_SDO_I_FREQ 100000000
#define ALT_MODULE_CLASS_USB_SDO_I altera_avalon_pio

/*
 * USB_SDI_O configuration
 *
 */

#define USB_SDI_O_NAME "/dev/USB_SDI_O"
#define USB_SDI_O_TYPE "altera_avalon_pio"
#define USB_SDI_O_BASE 0x00001880
#define USB_SDI_O_SPAN 16
#define USB_SDI_O_DO_TEST_BENCH_WIRING 0
#define USB_SDI_O_DRIVEN_SIM_VALUE 0
#define USB_SDI_O_HAS_TRI 0
#define USB_SDI_O_HAS_OUT 1
#define USB_SDI_O_HAS_IN 0
#define USB_SDI_O_CAPTURE 0
#define USB_SDI_O_DATA_WIDTH 1
#define USB_SDI_O_RESET_VALUE 0
#define USB_SDI_O_EDGE_TYPE "NONE"
#define USB_SDI_O_IRQ_TYPE "NONE"
#define USB_SDI_O_BIT_CLEARING_EDGE_REGISTER 0
#define USB_SDI_O_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_SDI_O_FREQ 100000000
#define ALT_MODULE_CLASS_USB_SDI_O altera_avalon_pio

/*
 * USB_SCK_O configuration
 *
 */

#define USB_SCK_O_NAME "/dev/USB_SCK_O"
#define USB_SCK_O_TYPE "altera_avalon_pio"
#define USB_SCK_O_BASE 0x00001890
#define USB_SCK_O_SPAN 16
#define USB_SCK_O_DO_TEST_BENCH_WIRING 0
#define USB_SCK_O_DRIVEN_SIM_VALUE 0
#define USB_SCK_O_HAS_TRI 0
#define USB_SCK_O_HAS_OUT 1
#define USB_SCK_O_HAS_IN 0
#define USB_SCK_O_CAPTURE 0
#define USB_SCK_O_DATA_WIDTH 1
#define USB_SCK_O_RESET_VALUE 0
#define USB_SCK_O_EDGE_TYPE "NONE"
#define USB_SCK_O_IRQ_TYPE "NONE"
#define USB_SCK_O_BIT_CLEARING_EDGE_REGISTER 0
#define USB_SCK_O_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_SCK_O_FREQ 100000000
#define ALT_MODULE_CLASS_USB_SCK_O altera_avalon_pio

/*
 * USB_INT_I configuration
 *
 */

#define USB_INT_I_NAME "/dev/USB_INT_I"
#define USB_INT_I_TYPE "altera_avalon_pio"
#define USB_INT_I_BASE 0x000018a0
#define USB_INT_I_SPAN 16
#define USB_INT_I_DO_TEST_BENCH_WIRING 0
#define USB_INT_I_DRIVEN_SIM_VALUE 0
#define USB_INT_I_HAS_TRI 0
#define USB_INT_I_HAS_OUT 0
#define USB_INT_I_HAS_IN 1
#define USB_INT_I_CAPTURE 0
#define USB_INT_I_DATA_WIDTH 1
#define USB_INT_I_RESET_VALUE 0
#define USB_INT_I_EDGE_TYPE "NONE"
#define USB_INT_I_IRQ_TYPE "NONE"
#define USB_INT_I_BIT_CLEARING_EDGE_REGISTER 0
#define USB_INT_I_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_INT_I_FREQ 100000000
#define ALT_MODULE_CLASS_USB_INT_I altera_avalon_pio

/*
 * NET_TESTDO configuration
 *
 */

#define NET_TESTDO_NAME "/dev/NET_TESTDO"
#define NET_TESTDO_TYPE "altera_avalon_pio"
#define NET_TESTDO_BASE 0x000018b0
#define NET_TESTDO_SPAN 16
#define NET_TESTDO_DO_TEST_BENCH_WIRING 0
#define NET_TESTDO_DRIVEN_SIM_VALUE 0
#define NET_TESTDO_HAS_TRI 0
#define NET_TESTDO_HAS_OUT 1
#define NET_TESTDO_HAS_IN 0
#define NET_TESTDO_CAPTURE 0
#define NET_TESTDO_DATA_WIDTH 1
#define NET_TESTDO_RESET_VALUE 0
#define NET_TESTDO_EDGE_TYPE "NONE"
#define NET_TESTDO_IRQ_TYPE "NONE"
#define NET_TESTDO_BIT_CLEARING_EDGE_REGISTER 0
#define NET_TESTDO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define NET_TESTDO_FREQ 100000000
#define ALT_MODULE_CLASS_NET_TESTDO altera_avalon_pio

/*
 * NET_EN configuration
 *
 */

#define NET_EN_NAME "/dev/NET_EN"
#define NET_EN_TYPE "altera_avalon_pio"
#define NET_EN_BASE 0x000018c0
#define NET_EN_SPAN 16
#define NET_EN_DO_TEST_BENCH_WIRING 0
#define NET_EN_DRIVEN_SIM_VALUE 0
#define NET_EN_HAS_TRI 0
#define NET_EN_HAS_OUT 0
#define NET_EN_HAS_IN 1
#define NET_EN_CAPTURE 0
#define NET_EN_DATA_WIDTH 1
#define NET_EN_RESET_VALUE 0
#define NET_EN_EDGE_TYPE "NONE"
#define NET_EN_IRQ_TYPE "NONE"
#define NET_EN_BIT_CLEARING_EDGE_REGISTER 0
#define NET_EN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define NET_EN_FREQ 100000000
#define ALT_MODULE_CLASS_NET_EN altera_avalon_pio

/*
 * USB_EN configuration
 *
 */

#define USB_EN_NAME "/dev/USB_EN"
#define USB_EN_TYPE "altera_avalon_pio"
#define USB_EN_BASE 0x000018d0
#define USB_EN_SPAN 16
#define USB_EN_DO_TEST_BENCH_WIRING 0
#define USB_EN_DRIVEN_SIM_VALUE 0
#define USB_EN_HAS_TRI 0
#define USB_EN_HAS_OUT 0
#define USB_EN_HAS_IN 1
#define USB_EN_CAPTURE 0
#define USB_EN_DATA_WIDTH 1
#define USB_EN_RESET_VALUE 0
#define USB_EN_EDGE_TYPE "NONE"
#define USB_EN_IRQ_TYPE "NONE"
#define USB_EN_BIT_CLEARING_EDGE_REGISTER 0
#define USB_EN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_EN_FREQ 100000000
#define ALT_MODULE_CLASS_USB_EN altera_avalon_pio

/*
 * USBSD_SEL configuration
 *
 */

#define USBSD_SEL_NAME "/dev/USBSD_SEL"
#define USBSD_SEL_TYPE "altera_avalon_pio"
#define USBSD_SEL_BASE 0x000018e0
#define USBSD_SEL_SPAN 16
#define USBSD_SEL_DO_TEST_BENCH_WIRING 0
#define USBSD_SEL_DRIVEN_SIM_VALUE 0
#define USBSD_SEL_HAS_TRI 0
#define USBSD_SEL_HAS_OUT 0
#define USBSD_SEL_HAS_IN 1
#define USBSD_SEL_CAPTURE 0
#define USBSD_SEL_DATA_WIDTH 1
#define USBSD_SEL_RESET_VALUE 0
#define USBSD_SEL_EDGE_TYPE "NONE"
#define USBSD_SEL_IRQ_TYPE "NONE"
#define USBSD_SEL_BIT_CLEARING_EDGE_REGISTER 0
#define USBSD_SEL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USBSD_SEL_FREQ 100000000
#define ALT_MODULE_CLASS_USBSD_SEL altera_avalon_pio

/*
 * USBSD_RDO configuration
 *
 */

#define USBSD_RDO_NAME "/dev/USBSD_RDO"
#define USBSD_RDO_TYPE "altera_avalon_pio"
#define USBSD_RDO_BASE 0x000018f0
#define USBSD_RDO_SPAN 16
#define USBSD_RDO_DO_TEST_BENCH_WIRING 0
#define USBSD_RDO_DRIVEN_SIM_VALUE 0
#define USBSD_RDO_HAS_TRI 0
#define USBSD_RDO_HAS_OUT 1
#define USBSD_RDO_HAS_IN 0
#define USBSD_RDO_CAPTURE 0
#define USBSD_RDO_DATA_WIDTH 16
#define USBSD_RDO_RESET_VALUE 0
#define USBSD_RDO_EDGE_TYPE "NONE"
#define USBSD_RDO_IRQ_TYPE "NONE"
#define USBSD_RDO_BIT_CLEARING_EDGE_REGISTER 0
#define USBSD_RDO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USBSD_RDO_FREQ 100000000
#define ALT_MODULE_CLASS_USBSD_RDO altera_avalon_pio

/*
 * USBSD_RVLD configuration
 *
 */

#define USBSD_RVLD_NAME "/dev/USBSD_RVLD"
#define USBSD_RVLD_TYPE "altera_avalon_pio"
#define USBSD_RVLD_BASE 0x00001900
#define USBSD_RVLD_SPAN 16
#define USBSD_RVLD_DO_TEST_BENCH_WIRING 0
#define USBSD_RVLD_DRIVEN_SIM_VALUE 0
#define USBSD_RVLD_HAS_TRI 0
#define USBSD_RVLD_HAS_OUT 1
#define USBSD_RVLD_HAS_IN 0
#define USBSD_RVLD_CAPTURE 0
#define USBSD_RVLD_DATA_WIDTH 1
#define USBSD_RVLD_RESET_VALUE 0
#define USBSD_RVLD_EDGE_TYPE "NONE"
#define USBSD_RVLD_IRQ_TYPE "NONE"
#define USBSD_RVLD_BIT_CLEARING_EDGE_REGISTER 0
#define USBSD_RVLD_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USBSD_RVLD_FREQ 100000000
#define ALT_MODULE_CLASS_USBSD_RVLD altera_avalon_pio

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       SDRAM
#define ALT_RODATA_DEVICE     SDRAM
#define ALT_RWDATA_DEVICE     SDRAM
#define ALT_EXCEPTIONS_DEVICE SDRAM
#define ALT_RESET_DEVICE      EPCS


#endif /* __SYSTEM_H_ */
