/*
 * =====================================================================================
 *
 *       Filename:  enc28j60.c
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  马瑞 (AVIC)
 *			Email:  avic633@gmail.com  
 *			   QQ:  984597569
 *			  URL:  http://kingst.cnblogs.com
 *
 * =====================================================================================
 */


/*-----------------------------------------------------------------------------
 *  Include
 *-----------------------------------------------------------------------------*/

#include "../inc/enc28j60.h"
#include "../inc/sopc.h"
#include <stdio.h>


/*-----------------------------------------------------------------------------
 *  Function Prototype
 *-----------------------------------------------------------------------------*/

unsigned char enc28j60_read_control_register(unsigned char address);
static void enc28j60_initialize(void);
void enc28j60_packet_send(unsigned short len,unsigned char * packet);
unsigned int enc28j60_packet_receive(unsigned short maxlen,unsigned char * packet);

/*-----------------------------------------------------------------------------
 *  Variable
 *-----------------------------------------------------------------------------*/

ENC28J60 enc28j60={
	.read_control_register	= enc28j60_read_control_register,               
	.initialize				= enc28j60_initialize,                  
	.packet_send			= enc28j60_packet_send,                 
	.packet_receive			= enc28j60_packet_receive                   
};

static unsigned char enc28j60_bank = 1;
static unsigned short next_packet_pointer;

//---------------------------------------------

void delay_lan_ms(unsigned int ms) {
	unsigned int len;
	for (;ms > 0; ms --)
		for (len = 0; len < 5000; len++ );
	}



/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  set_cs
 *  Description:  
 * =====================================================================================
 */
static void set_cs(unsigned char level)          
{
	if(level)    
		LAN_CS->DATA = 1;     
	else        
		LAN_CS->DATA = 0;      
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  enc28j60_write_operation
 *  Description:  
 * =====================================================================================
 */
static void enc28j60_write_operation(unsigned char op, unsigned char address, unsigned char data)
{       
	set_cs(0);              

	LAN->TXDATA = (op | (address & 0x1F)); // write command
	while(!(LAN->STATUS.BITS.TMT));

	LAN->TXDATA = data;          // write data
	while(!(LAN->STATUS.BITS.TMT));

	set_cs(1);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  enc28j60_read_operation
 *  Description:  
 * =====================================================================================
 */
static unsigned char enc28j60_read_operation(unsigned char op,unsigned char address)
{ 
	unsigned char data;
	set_cs(0);

	LAN->TXDATA = op|(address&0x1f);
	while(!(LAN->STATUS.BITS.TMT));

	LAN->TXDATA = 0x00;  //0x00 is random number ,to enable clock 
	while(!(LAN->STATUS.BITS.TMT));

	if(address&0x80){
		LAN->TXDATA = 0x00;
		while(!(LAN->STATUS.BITS.TMT));    //The first byte that MAC and MII registers read  is invalid,so they need to read twice
	}

	data = LAN->RXDATA;

	set_cs(1);

	return data;
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  enc28j60_write_operation
 *  Description:  
 * =====================================================================================
 */
static void enc28j60_set_bank(unsigned char address)
{   
	if((address & BANK_MASK) != enc28j60_bank){
		enc28j60_write_operation(ENC28J60_BIT_FIELD_CLR,ECON1,(ECON1_BSEL1|ECON1_BSEL0));   //clear BSEL1,BSEL0
		enc28j60_write_operation(ENC28J60_BIT_FIELD_SET,ECON1,(address&BANK_MASK)>>5);      //set bit 0x00:bank0;0x01:bank1;0x10:bank2;0x11:bank3

		enc28j60_bank=(address&BANK_MASK);
	}
}




/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  enc28j60_read_buffer
 *  Description:  
 * =====================================================================================
 */
static void enc28j60_read_buffer(unsigned short len,unsigned char * data)
{
	set_cs(0);

	LAN->TXDATA = ENC28J60_READ_BUF_MEM;

	while(!(LAN->STATUS.BITS.TMT));

	while(len--){
		LAN->TXDATA = 0x00;
		while(!(LAN->STATUS.BITS.TMT));

		while(!(LAN->STATUS.BITS.RRDY));
		*data++=LAN->RXDATA;
	}

	set_cs(1);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  enc28j60_write_buffer
 *  Description:  
 * =====================================================================================
 */
static void enc28j60_write_buffer(unsigned short len,unsigned char * data)
{
	set_cs(0);

	LAN->TXDATA = ENC28J60_WRITE_BUF_MEM;
	while(!(LAN->STATUS.BITS.TMT));

	while(len--){
		LAN->TXDATA = *data++;
		while(!(LAN->STATUS.BITS.TMT));
	}

	set_cs(1);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: enc28j60_read_control_register 
 *  Description:  
 * =====================================================================================
 */
unsigned char enc28j60_read_control_register(unsigned char address)
{

	enc28j60_set_bank(address);

	return enc28j60_read_operation(ENC28J60_READ_CTRL_REG,address);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: enc28j60_write_control_register 
 *  Description:  
 * =====================================================================================
 */
static void enc28j60_write_control_register(unsigned char address,unsigned char data)
{
	enc28j60_set_bank(address);

	enc28j60_write_operation(ENC28J60_WRITE_CTRL_REG,address,data);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: enc28j60_phy_write 
 *  Description:  
 * =====================================================================================
 */
void enc28j60_phy_write(unsigned char address,unsigned short data)
{
	enc28j60_write_control_register(MIREGADR,address);//MIREGADR:0x14

	enc28j60_write_control_register(MIWRL,data);
	enc28j60_write_control_register(MIWRH,data>>8);

	//wait until the PHY write completes
	while(enc28j60_read_control_register(MISTAT)&MISTAT_BUSY);//MISTAT:0xa0
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: enc28j60_initialize 
 *  Description:  
 * =====================================================================================
 */
static void enc28j60_initialize(void)
{
	unsigned int a;
	unsigned int timeout;
	
	LAN_RSTN->DATA=0;
	delay_lan_ms(200);
	LAN_RSTN->DATA=1;
	delay_lan_ms(200);
	

	enc28j60_write_operation(ENC28J60_SOFT_RESET, 0, ENC28J60_SOFT_RESET);

	do{
		timeout = 0;
		// perform system reset
		enc28j60_write_operation(ENC28J60_SOFT_RESET, 0, ENC28J60_SOFT_RESET);
		// check CLKRDY bit to see if reset is complete
		for(a=0;a<100000;a++);
		while(!(enc28j60_read_control_register(ESTAT) & ESTAT_CLKRDY)){
			timeout++;

			if (timeout > 100000)
			    {  LED->DATA = 1;
				break;
			    }
			else
			    LED->DATA  = 2;			
			//if (timeout > 100000)			
			//	break;
		}
	}while(timeout > 100000);

        
	next_packet_pointer=RXSTART_INIT;

	//set receive buffer start address
	enc28j60_write_control_register(ERXSTL,RXSTART_INIT&0xff);
	enc28j60_write_control_register(ERXSTH,RXSTART_INIT>>8);

	//set receive pointer address
	enc28j60_write_control_register(ERXRDPTL,RXSTART_INIT&0xff);
	enc28j60_write_control_register(ERXRDPTH,RXSTART_INIT>>8);

	//set receive buffer end
	//ERXND defaults to 0x1FFF (end of ram)
	enc28j60_write_control_register(ERXNDL,RXSTOP_INIT&0xff);
	enc28j60_write_control_register(ERXNDH,RXSTOP_INIT>>8);

	//set transmit buffer start address
	//ETXST defaults to 0x0000 (beginning of ram)
	enc28j60_write_control_register(ETXSTL,TXSTART_INIT&0xff);
	enc28j60_write_control_register(ETXSTH,TXSTART_INIT>>8);

	//enable MAC receive
	enc28j60_write_control_register(MACON1,MACON1_MARXEN|MACON1_TXPAUS|MACON1_RXPAUS);

	//bring MAC out of reset
	enc28j60_write_control_register(MACON2,0x00);
	enc28j60_write_operation(ENC28J60_BIT_FIELD_CLR,MACON2,MACON2_MARST);

	//enable automatic padding and CRC operation
	enc28j60_write_operation(ENC28J60_BIT_FIELD_SET,MACON3,MACON3_PADCFG0|MACON3_TXCRCEN|MACON3_FRMLNEN);

	//set the maximum packet size which the controller will accept
	enc28j60_write_control_register(MAMXFLL,MAX_FRAMELEN&0xff);
	enc28j60_write_control_register(MAMXFLH,MAX_FRAMELEN>>8);

	//set inter-frame gap (back-to-back)
	enc28j60_write_control_register(MABBIPG,0x12);

	//set inter-frame gap (non-back-to-back)
	enc28j60_write_control_register(MAIPGL,0x12);
	enc28j60_write_control_register(MAIPGH,0x0C);

	//write MAC address
	//Note:MAC address in ENC28J60 is byte-backward
	enc28j60_write_control_register(MAADR5,ENC28J60_MAC0);
	enc28j60_write_control_register(MAADR4,ENC28J60_MAC1);
	enc28j60_write_control_register(MAADR3,ENC28J60_MAC2);      
	enc28j60_write_control_register(MAADR2,ENC28J60_MAC3);
	enc28j60_write_control_register(MAADR1,ENC28J60_MAC4);
	enc28j60_write_control_register(MAADR0,ENC28J60_MAC5);

	enc28j60_phy_write(PHCON1,PHCON1_PDPXMD);

	//no loopback of transmitted frames
	enc28j60_phy_write(PHCON2,PHCON2_HDLDIS);

	//configurate LEDA,LEDB
	enc28j60_phy_write(PHLCON,0x0aa6);//0x0aa6 控制RJ45上面的两个灯闪烁

	//switch to bank0
	enc28j60_set_bank(ECON1);

	//enable interrupts
	enc28j60_write_operation(ENC28J60_BIT_FIELD_SET,EIE,EIE_INTIE|EIE_PKTIE);

	//enable packet reception
	enc28j60_write_operation(ENC28J60_BIT_FIELD_SET,ECON1,ECON1_RXEN);
	enc28j60_write_control_register(ERXFCON,0X81);
	enc28j60_write_control_register(ECON2,0X80);
	enc28j60_write_operation(ENC28J60_BIT_FIELD_CLR,EIR,0X01);
	
	
	LED->DATA  = 8;

}                                                                                          

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: enc28j60_packet_send 
 *  Description:  
 * =====================================================================================
 */
 void enc28j60_packet_send(unsigned short len,unsigned char * packet)
{
	//set the write pointer to start of transmit buffer area
	enc28j60_write_control_register(EWRPTL,TXSTART_INIT);
	enc28j60_write_control_register(EWRPTH,TXSTART_INIT>>8);

	//set the TXND pointer to correspond to the packet size given
	enc28j60_write_control_register(ETXNDL,(TXSTART_INIT+len));
	enc28j60_write_control_register(ETXNDH,(TXSTART_INIT+len)>>8);

	//write per-packet control byte
	enc28j60_write_operation(ENC28J60_WRITE_BUF_MEM,0,0x00);

	//copy the packet into the transmit buffer
	enc28j60_write_buffer(len,packet);

	//send the contents of the transmit buffer onto the network
	enc28j60_write_operation(ENC28J60_BIT_FIELD_SET,ECON1,ECON1_TXRTS);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: enc28j60_packet_receive 
 *  Description:  
 * =====================================================================================
 */
unsigned int enc28j60_packet_receive(unsigned short maxlen,unsigned char * packet)
{
	unsigned short rxstat;
	unsigned short len;
	unsigned int timeout=0;

	//check if a packet has been received and buffere
	if(!(enc28j60_read_control_register(EIR)&EIR_PKTIF)||(timeout++ > 100000)){
		return 0;
	}
	//set the read pointer to the start of the received packet
	enc28j60_write_control_register(ERDPTL,(next_packet_pointer));
	enc28j60_write_control_register(ERDPTH,(next_packet_pointer)>>8);

	//read the next packet pointer
	next_packet_pointer = enc28j60_read_operation(ENC28J60_READ_BUF_MEM,0);
	next_packet_pointer |= enc28j60_read_operation(ENC28J60_READ_BUF_MEM,0)<<8;

	//read the packet length
	len = enc28j60_read_operation(ENC28J60_READ_BUF_MEM,0);
	len |= enc28j60_read_operation(ENC28J60_READ_BUF_MEM,0)<<8;

	//read the receive status
	rxstat = enc28j60_read_operation(ENC28J60_READ_BUF_MEM,0);
	rxstat |= enc28j60_read_operation(ENC28J60_READ_BUF_MEM,0)<<8;

	//limit retrieve length
	//(we reduce the MAC-reported length by 4 to remove the CRC
	len = IFMIN(len,maxlen);

	//copy the packet from the receive buffer
	enc28j60_read_buffer(len,packet);

	//move the RX read pointer to the start of the next received packet
	//this frees the memory we just read out
	enc28j60_write_control_register(ERXRDPTL,(next_packet_pointer));
	enc28j60_write_control_register(ERXRDPTH,(next_packet_pointer)>>8);

	//decrement the packet counter indiacate we are done with this packet
	enc28j60_write_operation(ENC28J60_BIT_FIELD_SET,ECON2,ECON2_PKTDEC);

	return len;
}


