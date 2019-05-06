/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <unistd.h>

#include "../inc/sopc.h"
#include "../inc/enc28j60.h"
#include "../inc/ip_arp_udp_tcp.h"
#include "../inc/net.h"

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"

//-----------------------------------------
#include "../inc/Main.h"
#include "../inc/CH376INC.H"
#include "../inc/fpga_io.h"


#include "../inc/HAL.H"
#include "../inc/HAL_BASE.C"
#include "../inc/DEBUG.H"
#include "../inc/DEBUG.C"

#include "../inc/SPI_SW.C"		
#include "../inc/FILE_SYS.H"
#include "../inc/FILE_SYS.C"

void usb_host(void);
void CH376OffUSB(void);
void delay_USB_us(UINT32 i);

char USBH_info[30];
char USBS_info[30];
//--extern char USBH_info[];
//--extern char USBS_info[];

UINT8	buf_usb[64];

UINT8V	FreeUSBmS;

//--------------------------------------------


static uint8_t mymac[6] = {0xab,0xbc,0x6f,0x55,0x1c,0xc2};
static uint8_t myip[4] = {192,168,0,8};
#define MYWWWPORT 80
#define MYUDPPORT 1200
#define PSTR(s) s

#define BUFFER_SIZE 1500//450
static uint8_t buf[BUFFER_SIZE+1];


static char password[]="123456"; // <=9 char


void delay_my_ms(unsigned int ms) 
{
  unsigned int len;
  for (;ms > 0; ms --)
  	for (len = 0; len < 5000; len++ );
}

//=====================================

uint8_t verify_password(char *str)
{
        // the first characters of the received string are
        // a simple password/cookie:
        if (strncmp(password,str,5)==0){
                return(1);
        }
        return(0);
}

// takes a string of the form password/commandNumber and analyse it
// return values: -1 invalid password, otherwise command number
//                -2 no command given but password valid
//                -3 valid password, no command and no trailing "/"
int8_t analyse_get_url(char *str1)
{
        uint8_t loop=1;
        uint8_t i=0;
        while(loop){
                if(password[i]){
                        if(*str1==password[i]){
                                str1++;
                                i++;
                        }else{
                                return(-1);
                        }
                }else{
                        // end of password
                        loop=0;
                }
        }
        // is is now one char after the password
        if (*str1 == '/'){
                str1++;
        }else{
                return(-3);
        }
        // check the first char, garbage after this is ignored (including a slash)
        if (*str1 < 0x3a && *str1 > 0x2f){
                // is a ASCII number, return it
                return(*str1-0x30);
        }
        return(-2);
}

// answer HTTP/1.0 301 Moved Permanently\r\nLocation: password/\r\n\r\n
// to redirect to the url ending in a slash
uint16_t moved_perm(uint8_t *buf)
{
        uint16_t plen;
        plen=fill_tcp_data_p(buf,0,PSTR("HTTP/1.0 301 Moved Permanently\r\nLocation: "));
        plen=fill_tcp_data(buf,plen,password);
        plen=fill_tcp_data_p(buf,plen,PSTR("/\r\nContent-Type: text/html\r\nPragma: no-cache\r\n\r\n"));
        plen=fill_tcp_data_p(buf,plen,PSTR("<h1>301 Moved Permanently</h1>\n"));
        plen=fill_tcp_data_p(buf,plen,PSTR("add a trailing slash to the url\n"));
        return(plen);
}


// prepare the webpage by writing the data to the tcp send buffer
uint16_t print_webpage(uint8_t *buf,uint8_t on_off)
{
        uint16_t plen;
        plen=fill_tcp_data_p(buf,0,PSTR("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nPragma: no-cache\r\n\r\n"));
        plen=fill_tcp_data_p(buf,plen,PSTR("<center><p>Output is: "));
        if (on_off){
                plen=fill_tcp_data_p(buf,plen,PSTR("<font color=\"#00FF00\"> ON</font>"));
        }else{
                plen=fill_tcp_data_p(buf,plen,PSTR("OFF"));
        }
        plen=fill_tcp_data_p(buf,plen,PSTR(" <small><a href=\".\">[refresh status]</a></small></p>\n<p><a href=\"."));
        if (on_off){
                plen=fill_tcp_data_p(buf,plen,PSTR("/0\">LED01 off</a><p>"));
        }else{
                plen=fill_tcp_data_p(buf,plen,PSTR("/1\">LED01 on</a><p>"));
        }
        plen=fill_tcp_data_p(buf,plen,PSTR("</center><hr><br>Ver 1.0, 芯视清多功能FPGA开发板C4-30欢迎您  http://hevc265.taobao.com\n"));
		return(plen);
}


//======================================


void usb_host(void)
{
	UINT8	i, s;
	UINT8	TotalCount;
	UINT16	RealCount;
	P_FAT_DIR_INFO	pDir;
	UINT8   filefstrd;
	
	UINT16	RDATA0=0;
	UINT16	RDATA1=0;
	UINT16	RDATA2=0;
	UINT16	RDATA3=0;

	s = mInitCH376Host( );  /* 初始化CH376 */
	mStopIfError( s );
		//--while ( CH376DiskConnect( ) != USB_INT_SUCCESS ) { 			
		//--	printf( "No USB Host connect\r\n" );
		//--	memset(USBH_info,0x0,28);
		//--	sprintf(USBH_info, "No USB connect");
		//--	mDelaymS( 250 ); mDelaymS( 250 );mDelaymS( 250 );mDelaymS( 250 ); /* 没必要频繁查询 */			
		//--	
                //--   return;
		//--}
		
		mDelaymS( 200 );  /* 延时,可选操作,有的USB存储器需要几十毫秒的延时 */

/* 对于检测到USB设备的,最多等待100*50mS,主要针对有些MP3太慢,对于检测到USB设备并且连接DISK_MOUNTED的,最多等待5*50mS,主要针对DiskReady不过的 */
		for ( i = 0; i < 100; i ++ ) {  /* 最长等待时间,100*50mS */
			mDelaymS( 50 );
			printf( "Ready ?\r\n" );
			s = CH376DiskMount( );  /* 初始化磁盘并测试磁盘是否就绪 */
			printf( "CH376DiskMount = %02x\r\n",s);
			if ( s == USB_INT_SUCCESS ) break;  /* 准备好 */
			else if ( s == ERR_DISK_DISCON ) break;  /* 检测到断开,重新检测并计时 */
			if ( CH376GetDiskStatus( ) >= DEF_DISK_MOUNTED && i >= 5 ) break;  /* 有的U盘总是返回未准备好,不过可以忽略,只要其建立连接MOUNTED且尝试5*50mS */
		}
		if ( s == ERR_DISK_DISCON ) {  /* 检测到断开,重新检测并计时 */
			printf( "Device gone\r\n" );
			USBSD_RVLD->DATA=0;
			return;
		}
		if ( CH376GetDiskStatus( ) < DEF_DISK_MOUNTED ) {  /* 未知USB设备,例如USB键盘、打印机等 */
			printf( "Unknown device\r\n" );
			USBSD_RVLD->DATA=0;
			goto UnknownUsbDevice;
		}
		i = CH376ReadBlock( buf_usb );  /* 如果需要,可以读取数据块CH376_CMD_DATA.DiskMountInq,返回长度 */
		if ( i == sizeof( INQUIRY_DATA ) ) {  /* U盘的厂商和产品信息 */
			buf_usb[ i ] = 0;
			printf( "UdiskInfo: %s\r\n", ((P_INQUIRY_DATA)buf_usb) -> VendorIdStr );
			memset(USBH_info,0x0,28);
			memcpy(USBH_info,((P_INQUIRY_DATA)buf_usb) -> VendorIdStr,28);
		}

/* 读取原文件 */
		printf( "Open\r\n" );
		strcpy( buf_usb, "\\C430\\C430TEST.C" );  /* 源文件名,多级目录下的文件名和路径名必须复制到RAM中再处理,而根目录或者当前目录下的文件名可以在RAM或者ROM中 */
		s = CH376FileOpenPath( buf_usb );  /* 打开文件,该文件在C51子目录下 */
		if ( s == ERR_MISS_DIR || s == ERR_MISS_FILE ) {  /* 没有找到目录或者没有找到文件 */
/* 列出文件,完整枚举可以参考EXAM13全盘枚举 */
                        USBSD_RVLD->DATA=0;
			if ( s == ERR_MISS_DIR ) strcpy( buf_usb, "\\*" );  /* C51子目录不存在则列出根目录下的文件 */
			else strcpy( buf_usb, "\\C430\\C430*" );  /* CH376HFT.C文件不存在则列出\C51子目录下的以CH376开头的文件 */
			printf( "List file %s\r\n", buf_usb );
			s = CH376FileOpenPath( buf_usb );  /* 枚举多级目录下的文件或者目录,输入缓冲区必须在RAM中 */
			while ( s == USB_INT_DISK_READ ) {  /* 枚举到匹配的文件 */
				CH376ReadBlock( buf_usb );  /* 读取枚举到的文件的FAT_DIR_INFO结构,返回长度总是sizeof( FAT_DIR_INFO ) */
				pDir = (P_FAT_DIR_INFO)buf_usb;  /* 当前文件目录信息 */
				if ( pDir -> DIR_Name[0] != '.' ) {  /* 不是本级或者上级目录名则继续,否则必须丢弃不处理 */
					if ( pDir -> DIR_Name[0] == 0x05 ) pDir -> DIR_Name[0] = 0xE5;  /* 特殊字符替换 */
					pDir -> DIR_Attr = 0;  /* 强制文件名字符串结束以便打印输出 */
					printf( "*** EnumName: %s\r\n", pDir -> DIR_Name );  /* 打印名称,原始8+3格式,未整理成含小数点分隔符 */
				}
				xWriteCH376Cmd( CMD0H_FILE_ENUM_GO );  /* 继续枚举文件和目录 */
				xEndCH376Cmd( );
				s = Wait376Interrupt( );
			}
			if ( s != ERR_MISS_FILE ) mStopIfError( s );  /* 操作出错 */
		}
		else {  /* 找到文件或者出错 */
			mStopIfError( s );
			TotalCount = 200;  /* 准备读取总长度 */
			printf( "从文件中读出的前%d个字符是:\r\n",(UINT16)TotalCount );
			filefstrd=1;
			while ( TotalCount ) {  /* 如果文件比较大,一次读不完,可以再调用CH376ByteRead继续读取,文件指针自动向后移动 */
				if ( TotalCount > sizeof(buf_usb) ) i = sizeof(buf_usb);  /* 剩余数据较多,限制单次读写的长度不能超过缓冲区大小 */
				else i = TotalCount;  /* 最后剩余的字节数 */
				s = CH376ByteRead( buf_usb, i, &RealCount );  /* 以字节为单位读取数据块,单次读写的长度不能超过缓冲区大小,第二次调用时接着刚才的向后读 */
				mStopIfError( s );
				TotalCount -= (UINT8)RealCount;  /* 计数,减去当前实际已经读出的字符数 */
				for ( s=0; s!=RealCount; s++ ) printf( "%C", buf_usb[s] );  /* 显示读出的字符 */
				
				if(filefstrd==1){
				
				if(buf_usb[0]>64)  
				    RDATA0 = (UINT16)(buf_usb[0]-55);
				else
				    RDATA0 = (UINT16)(buf_usb[0]-48);	
				    
				if(buf_usb[1]>64)  
				    RDATA1 = (UINT16)(buf_usb[1]-55);
				else
				    RDATA1 = (UINT16)(buf_usb[1]-48);
				    
				if(buf_usb[2]>64)  
				    RDATA2 = (UINT16)(buf_usb[2]-55);
				else
				    RDATA2 = (UINT16)(buf_usb[2]-48);	
				    
				if(buf_usb[3]>64)  
				    RDATA3 = (UINT16)(buf_usb[3]-55);
				else
				    RDATA3 = (UINT16)(buf_usb[3]-48);				    			    				    
					
				//USBSD_RDO->DATA = (((UINT16)buf_usb[0])<<8)|((UINT16)buf_usb[1]);
				
				USBSD_RDO->DATA = (RDATA0<<12)|(RDATA1<<8)|(RDATA2<<4)|RDATA3;
				USBSD_RVLD->DATA=1;	
				}
				
				filefstrd=0;
				if ( RealCount < i ) {  /* 实际读出的字符数少于要求读出的字符数,说明已经到文件的结尾 */
					printf( "\r\n" );
					printf( "文件已经结束\r\n" );
					break;
				}
			}
			printf( "Close\r\n" );
			s = CH376FileClose( FALSE );  /* 关闭文件 */
			mStopIfError( s );
		}

UnknownUsbDevice:
		printf( "Take out\r\n" );
		//while ( CH376DiskConnect( ) == USB_INT_SUCCESS ) {  /* 检查U盘是否连接,等待U盘拔出 */
			//mDelaymS( 100 );
		//}
		//printf("TURN OFF LED\r\n");//LED_UDISK_OUT( );  /* LED灭 */
		mDelaymS( 100 );
}



//=======================================



int main()
{
  /*printf("Hello from MY FPGA Board!\n"); */
  
  //int i;
  
  //while(1){
  //for(i=0;i<4;i++){
  //  LED->DATA = 1 <<i;
  //  usleep(500000);
  //}
  //}
  
  uint16_t plen;
  uint16_t dat_p;
  uint8_t i=0;
  uint8_t cmd_pos=0;
  int8_t cmd;
  uint8_t payloadlen=0;
  char str[30];
  char cmdval;  
  
  enc28j60.initialize();
  delay_my_ms(20);
  
  enc28j60_phy_write(PHLCON,0xD76);	//0x476	  
  delay_my_ms(20);
  
  i=1;
  
  init_ip_arp_udp_tcp(mymac,myip,MYWWWPORT);
		
	sprintf( str, "Chip rev: 0x%x \r\n",enc28j60_read_control_register(EREVID));
	printf( str );
	
      
  
       while(1)
		{
		
               if(USBSD_EN->DATA==1) {               	 
	                usb_host();
	                delay_my_ms(500);
	                }
			
			
	    if(NET_EN->DATA==1) {
	    	
               plen = enc28j60_packet_receive(BUFFER_SIZE, buf);
               if(plen==0){					
			//--OSTimeDlyHMSM(0, 0, 0, 2);
			delay_my_ms(2);
                       continue;
                        }
               
               if(eth_type_is_arp_and_my_ip(buf,plen)){
                       make_arp_answer_from_request(buf);
			//--OSTimeDlyHMSM(0, 0, 0, 2);
			delay_my_ms(2);
                       continue;
                       }
       
               // check if ip packets are for us:
               if(eth_type_is_ip_and_my_ip(buf,plen)==0){
			//--OSTimeDlyHMSM(0, 0, 0, 2);
			delay_my_ms(2);
                       continue;
                  }
       
               
               if(buf[IP_PROTO_P]==IP_PROTO_ICMP_V && buf[ICMP_TYPE_P]==ICMP_TYPE_ECHOREQUEST_V){
                       // a ping packet, let's send pong
                       make_echo_reply_from_request(buf,plen);
			//--OSTimeDlyHMSM(0, 0, 0, 2);
			delay_my_ms(2);
                       continue;
                      }
                      
               // tcp port www start, compare only the lower byte
               if (buf[IP_PROTO_P]==IP_PROTO_TCP_V&&buf[TCP_DST_PORT_H_P]==0&&buf[TCP_DST_PORT_L_P]==MYWWWPORT)
				{
                       if (buf[TCP_FLAGS_P] & TCP_FLAGS_SYN_V){
                               make_tcp_synack_from_syn(buf);
                             //--  OSTimeDlyHMSM(0, 0, 0, 2);
                             delay_my_ms(2);
                               continue;
                            }
                       if (buf[TCP_FLAGS_P] & TCP_FLAGS_ACK_V){
                               init_len_info(buf); 
                               // we can possibly have no data, just ack:
                               dat_p=get_tcp_data_pointer();
                               if (dat_p==0){
                                       if (buf[TCP_FLAGS_P] & TCP_FLAGS_FIN_V){
                                               // finack, answer with ack
                                               make_tcp_ack_from_any(buf);
                                       }
                                       // just an ack with no data, wait for next packet
                                      //-- OSTimeDlyHMSM(0, 0, 0, 2);
                                      delay_my_ms(2);
                                       continue;
                               }
                               if (strncmp("GET ",(char *)&(buf[dat_p]),4)!=0){
                                       // head, post and other methods:
                                       //
                                       // for possible status codes see:
                                       // http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
                                       plen=fill_tcp_data_p(buf,0,PSTR("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>200 OK</h1>"));
                                       goto SENDTCP;
                               }
                               if (strncmp("/ ",(char *)&(buf[dat_p+4]),2)==0){
                                       plen=fill_tcp_data_p(buf,0,PSTR("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n"));
                                       plen=fill_tcp_data_p(buf,plen,PSTR("<p>C4-30 FPGA开发板 欢迎使用芯视清开发板 请输入 http://192.168.0.8/123456\n"));
                                       goto SENDTCP;
                               }
                               cmd=analyse_get_url((char *)&(buf[dat_p+5]));
                               // for possible status codes see:
                               // http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
                               if (cmd==-1){
                                       plen=fill_tcp_data_p(buf,0,PSTR("HTTP/1.0 401 Unauthorized\r\nContent-Type: text/html\r\n\r\n<h1>401 Unauthorized</h1>"));
                                       goto SENDTCP;
                               }
                               if (cmd==1){
                                       //PORTD|= (1<<PD7);// transistor on
										printf("LED2 = 0\r\n");//IOCLR = LED;//xsyan mask
										NET_TESTDO->DATA = 1;
										i = 1;
                               }
                               if (cmd==0){
                                       //PORTD &= ~(1<<PD7);// transistor off
										printf("LED2 = 1\r\n");//IOSET = LED;//xsyan mask
										NET_TESTDO->DATA = 0;
										i = 0;
                               }
                               if (cmd==-3){
                                       // redirect to add a trailing slash
                                       plen=moved_perm(buf);
                                       goto SENDTCP;
                               }
                               // if (cmd==-2) or any other value
                               // just display the status:
                               //plen=print_webpage(buf,(PORTD & (1<<PD7)));
								plen=print_webpage(buf,(i));
                               //
              SENDTCP:
                               make_tcp_ack_from_any(buf); // send ack for http get
                               make_tcp_ack_with_data(buf,plen); // send data
                             //--  OSTimeDlyHMSM(0, 0, 0, 2);
                             delay_my_ms(2);
                               continue;
                       }
       
               }
               // tcp port www end
               //
               // udp start, we listen on udp port 1200=0x4B0
               if (buf[IP_PROTO_P]==IP_PROTO_UDP_V&&buf[UDP_DST_PORT_H_P]==4&&buf[UDP_DST_PORT_L_P]==0xb0)
				{
                       payloadlen=buf[UDP_LEN_L_P]-UDP_HEADER_LEN;
                       // you must sent a string starting with v
                       // e.g udpcom version 10.0.0.24
                       if (verify_password((char *)&(buf[UDP_DATA_P]))){
                               // find the first comma which indicates 
                               // the start of a command:
                               cmd_pos=0;
                               while(cmd_pos<payloadlen){
                                       cmd_pos++;
                                       if (buf[UDP_DATA_P+cmd_pos]==','){
                                               cmd_pos++; // put on start of cmd
                                               break;
                                       }
                               }
                               // a command is one char and a value. At
                               // least 3 characters long. It has an '=' on
                               // position 2:
                               if (cmd_pos<2 || cmd_pos>payloadlen-3 || buf[UDP_DATA_P+cmd_pos+1]!='='){
                                       strcpy(str,"e=no_cmd");
                                       goto ANSWER;
                               }
                               // supported commands are
                               // t=1 t=0 t=?
                               if (buf[UDP_DATA_P+cmd_pos]=='t'){
                                       cmdval=buf[UDP_DATA_P+cmd_pos+2];
                                       if(cmdval=='1'){
                                               //PORTD|= (1<<PD7);// transistor on
												printf("LED = 0\r\n");//IOCLR = LED;//xsyan mask
                                               strcpy(str,"t=1");
                                               goto ANSWER;
                                       }else if(cmdval=='0'){
                                               //PORTD &= ~(1<<PD7);// transistor off
												printf("LED = 1\r\n");//IOSET = LED;//xsyan mask
                                               strcpy(str,"t=0");
                                               goto ANSWER;
                                       }else if(cmdval=='?'){
                                               //if (PORTD & (1<<PD7)){
												if (1/*IOPIN & LED*/){//xsyan mask
                                                       strcpy(str,"t=1");
                                                       goto ANSWER;
                                               }
                                               strcpy(str,"t=0");
                                               goto ANSWER;
                                       }
                               }
                               strcpy(str,"e=no_such_cmd");
                               goto ANSWER;
                       }
                       strcpy(str,"e=invalid_pw");
               ANSWER:
                       make_udp_reply_from_request(buf,str,strlen(str),MYUDPPORT);
						//--OSTimeDlyHMSM(0, 0, 0, 2);
						delay_my_ms(2);
               }
               
            }
       }  
  
  

  return 0;
}
