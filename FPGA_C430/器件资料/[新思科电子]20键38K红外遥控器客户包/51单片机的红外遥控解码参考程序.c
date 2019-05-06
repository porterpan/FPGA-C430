//#################################################################################################
//�ļ���51��Ƭ���ĺ���ң�ؽ������
//���ԣ�ʹ���ⲿ�ж�0����ң��ͷ�����պ���ң�ؼ�ֵ��P2����ʾ��12MHz�ⲿ����
//���ߣ���˼�Ƶ��� 2011-06
//��Դ��P3.2=����ͷ���룬P2=8LED
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

	for(i=0;i<255;i++)  //9ms���иߵ�ƽ��Ϊ�Ǹ���
	{
		if(P3&0x04)	    //255��ֵʵ��ʱ��Ϊ800us
		{
			EX0=1;
			return;
		}
	}
	while(!(P3&0x04));	//�ȴ�9ms�͵�ƽ��ȥ
   	for(i=0;i<4;i++)
	{
		for(j=0;j<8;j++)
		{
			while(P3&0x04);	//�ȴ�4.5ms�ߵ�ƽ��ȥ	
			while(!(P3&0x04));	//�ȴ�0.56ms�͵�ƽ����ĸߵ�ƽ
			while(P3&0x04)		//��������ߵ�ƽ��ʱ��
			{
				for(us=0;us<=32;us++);	//100us����ʱ���
				if((k++)>=30)		//�ߵ�ƽʱ������˳�����
				{
					EX0=1;
					return;
				}
			}
			addr[i]=addr[i]>>1;	//����һλ����
			if(k>=8)
				addr[i]=addr[i]|0x80;	//�ߵ�ƽ����0.56ms����Ϊ1
			k=0;
		}
	}	

	P2=~(addr[2]);	 //P2��LED��ʾ�����Ƽ�ֵ

	EX0=1;	  
}	   