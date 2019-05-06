#ifndef SOPC_H_
#define SOPC_H_



#include "system.h"

#define _LED
#define _LAN


typedef struct{

    volatile unsigned long int RXDATA;

    volatile unsigned long int TXDATA;

    union{
        struct{
            volatile unsigned long int NC				:3;
            volatile unsigned long int ROE				:1;
            volatile unsigned long int TOE				:1;
            volatile unsigned long int TMT				:1;
            volatile unsigned long int TRDY				:1;
            volatile unsigned long int RRDY				:1;
            volatile unsigned long int E				:1;
            volatile unsigned long int NC1				:23;        
        }BITS;
        volatile unsigned long int WORD;
    }STATUS;

    union{
        struct{
            volatile unsigned long int NC				:3;
            volatile unsigned long int IROE				:1;
            volatile unsigned long int ITOE				:1;
            volatile unsigned long int NC1				:1;
            volatile unsigned long int ITRDY			:1;
            volatile unsigned long int IRRDY			:1;
            volatile unsigned long int IE				:1;
            volatile unsigned long int NC2				:1;
            volatile unsigned long int SSO				:21;
        }BITS;
        volatile unsigned long int CONTROL;
    }CONTROL;

    unsigned long int RESERVED0;
    unsigned long int SLAVE_SELECT;

}SPI_ST;

typedef struct
{
    unsigned long int DATA;
    unsigned long int DIRECTION;
    unsigned long int INTERRUPT_MASK;
    unsigned long int EDGE_CAPTURE;
}PIO_STR;

#ifdef _LED
#define LED ((PIO_STR*)PIO_LED_BASE)
#endif

#ifdef _LAN
#define LAN               ((SPI_ST *) LAN_BASE)
#define LAN_CS            ((PIO_STR *) LAN_CS_BASE)
#define LAN_NINT          ((PIO_STR *) LAN_NINT_BASE)
#define LAN_RSTN          ((PIO_STR *) LAN_RSTN_BASE)
#endif /*_LAN*/ 

#define NET_EN          ((PIO_STR *) NET_EN_BASE)
#define USBSD_EN          ((PIO_STR *) USB_EN_BASE)
#define USBSD_SEL         ((PIO_STR *) USBSD_SEL_BASE)
#define NET_TESTDO        ((PIO_STR *) NET_TESTDO_BASE)

#define USBSD_RDO        ((PIO_STR *) USBSD_RDO_BASE)
#define USBSD_RVLD        ((PIO_STR *) USBSD_RVLD_BASE)


#endif /*SOPC_H_*/
