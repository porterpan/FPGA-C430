//#################################################################################################
//文件：51单片机的红外遥控解码程序
//属性：使用外部中断0连接遥控头，接收红外遥控键值送P2口显示，12MHz外部晶振
//作者：新思科电子 2011-06
//资源：P3.2=接收头输入，P2=8LED
//#################################################################################################
#include"reg52.h"

#define uint unsigned int
#define uchar unsigned char

uchar led=0x00;

void io_init(void);
void int_init(void);

void main(void)
{
	io_init();
	int_init();
	while(1);
}

void io_init(void)
{
	P0=0xff;
	P1=0xff;
	P2=0xff;
	P3=0xff;
}

void int_init(void)
{
	EX0=1;
	EA=1;
}

void interrupt0()interrupt 0
{
	uchar i=0,j=0,k=0,us=0;
	uchar addr[4]={0};

	EX0=0;

	for(i=0;i<255;i++)  //9ms内有高电平认为是干扰
	{
		if(P3&0x04)	    //255的值实际时间为800us
		{
			EX0=1;
			return;
		}
	}
	while(!(P3&0x04));	//等待9ms低电平过去
   	for(i=0;i<4;i++)
	{
		for(j=0;j<8;j++)
		{
			while(P3&0x04);	//等待4.5ms高电平过去	
			while(!(P3&0x04));	//等待0.56ms低电平后面的高电平
			while(P3&0x04)		//计算这个高电平的时间
			{
				for(us=0;us<=32;us++);	//100us的延时语句
				if((k++)>=30)		//高电平时间过长退出程序
				{
					EX0=1;
					return;
				}
			}
			addr[i]=addr[i]>>1;	//接收一位数据
			if(k>=8)
				addr[i]=addr[i]|0x80;	//高电平大于0.56ms，则为1
			k=0;
		}
	}	

	P2=~(addr[2]);	 //P2的LED显示二进制键值

	EX0=1;	  
}	   