/* CH376芯片 软件模拟SPI串行连接的硬件抽象层 V1.0 */
/* 提供I/O接口子程序 */

#include	"HAL.H"
#include	"fpga_io.h"
#include        "sopc.h"

/* 本例中的硬件连接方式如下(实际应用电路可以参照修改下述定义及子程序) */
/* 单片机的引脚    CH376芯片的引脚
      P1.4                 SCS
      P1.5                 SDI
      P1.6                 SDO
      P1.7                 SCK      */
//sbit	P14					=	P1^4;
//sbit	P15					=	P1^5;
//sbit	P16					=	P1^6;
//sbit	P17					=	P1^7;

//IO Set function
#define	SET_USB_SCS_O(a)	IOWR_ALTERA_AVALON_PIO_DATA(USB_SCS_O_BASE, a)
#define	SET_USB_SDI_O(a)	IOWR_ALTERA_AVALON_PIO_DATA(USB_SDI_O_BASE, a)
#define	SET_USB_SCK_O(a)	IOWR_ALTERA_AVALON_PIO_DATA(USB_SCK_O_BASE, a)
#define	SET_USB_RST_O(a)	IOWR_ALTERA_AVALON_PIO_DATA(USB_RST_O_BASE, a)

//IO Get function
#define	GET_SDO_I()	    	IORD_ALTERA_AVALON_PIO_DATA(USB_SDO_I_BASE			)
#define	GET_INT_I()	    	IORD_ALTERA_AVALON_PIO_DATA(USB_INT_I_BASE			)
#define	GET_PC_CONNECT_I()	IORD_ALTERA_AVALON_PIO_DATA(USB_PC_CONNECT_I_BASE	)

//#define	CH376_SPI_SCS	//		P14		/* 假定CH376的SCS引脚 */
//#define	CH376_SPI_SDI	//		P15		/* 假定CH376的SDI引脚 */
#define	CH376_SPI_SDO	1//		P16		/* 假定CH376的SDO引脚 */
//#define	CH376_SPI_SCK	//		P17		/* 假定CH376的SCK引脚 */
/*#define	CH376_SPI_BZ			P10*/		/* 假定CH376的BZ引脚 */

#define CH376_INT_WIRE		//	xsyan mask.INT0	/* 假定CH376的INT#引脚,如果未连接那么也可以通过查询兼做中断输出的SDO引脚状态实现 */

void	CH376_PORT_INIT( void )  /* 由于使用软件模拟SPI读写时序,所以进行初始化 */
{
/* 如果是硬件SPI接口,那么可使用mode3(CPOL=1&CPHA=1)或mode0(CPOL=0&CPHA=0),CH376在时钟上升沿采样输入,下降沿输出,数据位是高位在前 */
	SET_USB_SCS_O(1);//CH376_SPI_SCS = 1;  /* 禁止SPI片选 */
	SET_USB_SCK_O(1);//CH376_SPI_SCK = 1;  /* 默认为高电平,SPI模式3,也可以用SPI模式0,但模拟程序可能需稍做修改 */
/* 对于双向I/O引脚模拟SPI接口,那么必须在此设置SPI_SCS,SPI_SCK,SPI_SDI为输出方向,SPI_SDO为输入方向 */
}

void	mDelay0_5uS( void )  /* 至少延时0.5uS,根据单片机主频调整 */
{
	UINT32 i = 1;
	while(i--);
}

void	Spi376OutByte( UINT8 d )  /* SPI输出8个位数据 */
{  /* 如果是硬件SPI接口,应该是先将数据写入SPI数据寄存器,然后查询SPI状态寄存器以等待SPI字节传输完成 */
	UINT8	i;
	for (i=0; i<8; i++) 
	{		
		SET_USB_SCK_O(0);//CH376_SPI_SCK = 0;	
		if (d & 0x80) 
			SET_USB_SDI_O(1);//CH376_SPI_SDI = 1;
		else 
			SET_USB_SDI_O(0);//CH376_SPI_SDI = 0;

		d <<= 1;  /* 数据位是高位在前 */		

		SET_USB_SCK_O(1);//CH376_SPI_SCK = 1;  /* CH376在时钟上升沿采样输入 */
	}
	//SET_USB_SCK_O(0);
}

UINT8	Spi376InByte( void )  /* SPI输入8个位数据 */
{  /* 如果是硬件SPI接口,应该是先查询SPI状态寄存器以等待SPI字节传输完成,然后从SPI数据寄存器读出数据 */
	UINT8 i, d = 0;
	d = 0;
	for ( i = 0; i < 8; i ++ ) 
	{
		SET_USB_SCK_O(0);//CH376_SPI_SCK = 1;	
		d <<= 1;
		if (GET_SDO_I()/*CH376_SPI_SDO*/ ) 
			d++;
		SET_USB_SCK_O(1);//CH376_SPI_SCK = 0;  /* CH376在时钟下降沿输出 */
	}	
	return( d );
}

#define	xEndCH376Cmd( )	{ SET_USB_SCS_O(1);/*CH376_SPI_SCS = 1;*/ }  /* SPI片选无效,结束CH376命令,仅用于SPI接口方式 */

void	xWriteCH376Cmd( UINT8 mCmd )  /* 向CH376写命令 */
{
#ifdef	CH376_SPI_BZ
	UINT8	i;
#endif
	SET_USB_SCS_O(1);//CH376_SPI_SCS = 1;  /* 防止之前未通过xEndCH376Cmd禁止SPI片选 */
	mDelay0_5uS( );
/* 对于双向I/O引脚模拟SPI接口,那么必须确保已经设置SPI_SCS,SPI_SCK,SPI_SDI为输出方向,SPI_SDO为输入方向 */
	SET_USB_SCS_O(0);//CH376_SPI_SCS = 0;  /* SPI片选有效 */
	Spi376OutByte( mCmd );  /* 发出命令码 */
#ifdef	CH376_SPI_BZ
	for ( i = 30; i != 0 && CH376_SPI_BZ; -- i );  /* SPI忙状态查询,等待CH376不忙,或者下面一行的延时1.5uS代替 */
#else
	mDelay0_5uS( ); mDelay0_5uS( ); mDelay0_5uS( );  /* 延时1.5uS确保读写周期大于1.5uS,或者用上面一行的状态查询代替 */
#endif
}

#ifdef	FOR_LOW_SPEED_MCU  /* 不需要延时 */
#define	xWriteCH376Data( d )	{ Spi376OutByte( d ); }  /* 向CH376写数据 */
#define	xReadCH376Data( )		( Spi376InByte( ) )  /* 从CH376读数据 */
#else
void	xWriteCH376Data( UINT8 mData )  /* 向CH376写数据 */
{
	Spi376OutByte( mData );
	mDelay0_5uS( );  /* 确保读写周期大于0.6uS */
}
UINT8	xReadCH376Data( void )  /* 从CH376读数据 */
{
	mDelay0_5uS( );  /* 确保读写周期大于0.6uS */
	return( Spi376InByte( ) );
}
#endif

/* 查询CH376中断(INT#低电平) */
UINT8	Query376Interrupt( void )
{
#ifdef	CH376_INT_WIRE
	//--return( CH376_INT_WIRE ? FALSE : TRUE );  /* 如果连接了CH376的中断引脚则直接查询中断引脚 */
	return( GET_INT_I() ? FALSE : TRUE );
#else
	return( GET_SDO_I()/*CH376_SPI_SDO*/ ? FALSE : TRUE );  /* 如果未连接CH376的中断引脚则查询兼做中断输出的SDO引脚状态 */
#endif
}

UINT8	mInitCH376Host( void )  /* 初始化CH376 */
{
	UINT8	res;
	while(1)
	{
		CH376_PORT_INIT( );  /* 接口硬件初始化 */	

		xWriteCH376Cmd(CMD_GET_IC_VER);
		res = xReadCH376Data( );
		printf("CMD_GET_IC_VER = %02x\r\n",res);
		xEndCH376Cmd();
		
		xWriteCH376Cmd( CMD11_CHECK_EXIST );  /* 测试单片机与CH376之间的通讯接口 */
		xWriteCH376Data( 0x65 );
		res = xReadCH376Data( );
		xEndCH376Cmd();
		if ( res != 0x9A ) 
		{
			printf("ERR_USB_UNKNOWN\r\n");
			//return( ERR_USB_UNKNOWN );  /* 通讯接口不正常,可能原因有:接口连接异常,其它设备影响(片选不唯一),串口波特率,一直在复位,晶振不工作 */
			continue;
		}
		break;
	}
	
	xWriteCH376Cmd( CMD11_SET_USB_MODE );  
	
	if(USBSD_SEL->DATA==1)
	    xWriteCH376Data( 0x06 );           /* HOST USB工作模式 */
	else	
	    xWriteCH376Data( 0x03 );             /*SD卡主机模式*/
	
	mDelayuS( 20 );
	res = xReadCH376Data( );
	xEndCH376Cmd( );
//#ifndef	CH376_INT_WIRE
//--#ifdef	CH376_SPI_SDO
//--	xWriteCH376Cmd( CMD20_SET_SDO_INT );  /* 设置SPI的SDO引脚的中断方式 */
//--	xWriteCH376Data( 0x16 );
//--	xWriteCH376Data( 0x90 );  /* SDO引脚在SCS片选无效时兼做中断请求输出 */
//--	xEndCH376Cmd( );
//--#endif
//#endif
	if ( res == CMD_RET_SUCCESS ) return( USB_INT_SUCCESS );
	else return( ERR_USB_UNKNOWN );  /* 设置模式错误 */
}
