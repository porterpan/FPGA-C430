
#ifndef UINT_H_
#define UINT_H_
typedef unsigned char   UINT8;
typedef unsigned short  UINT16;
typedef unsigned int    UINT32;

#endif

#define	TRUE	1
#define	FALSE	0

//----------------------------------------------------------------------------
//function decerlation
//----------------------------------------------------------------------------
void Print_USB_Msg(void);

#ifndef MAX_DATA_SIZE
#define MAX_DATA_SIZE		20			/* 单次命令处理的最大数据长度,有效值是1到56 */
#endif

typedef	struct	_USB_DOWN_PACKET {		/* 下传的数据包结构,用于命令/写数据 */
	UINT8	mCommand;					/* 命令码,见下面的定义 */
	UINT8	mCommandNot;				/* 命令码的反码,用于校验下传数据包 */
	union {
		UINT8	mByte[4];				/* 通用参数 */
		UINT16	mWord[2];				/* 通用参数,低字节在前,Little-Endian */
		UINT32	mDword;					/* 通用参数,低字节在前,Little-Endian */
		void	*mAddress;				/* 读写操作的起始地址,低字节在前,Little-Endian */
	} u;
	UINT8	mLength;					/* 下面的缓冲区的长度,读写操作的字节数 */
	UINT8	mBuffer[ MAX_DATA_SIZE ];	/* 数据缓冲区 */
}	USB_DOWN_PKT;

typedef	struct	_USB_UP_PACKET {		/* 上传的数据包结构,用于状态/读数据 */
	UINT8	mStatus;					/* 状态码,见下面的定义 */
	UINT8	mCommandNot;				/* 命令码的反码,用于校验上传数据包 */
	UINT8	mReserved[4];
	UINT8	mLength;					/* 下面的缓冲区的长度,读操作的字节数 */
	UINT8	mBuffer[ MAX_DATA_SIZE ];	/* 数据缓冲区 */
}	USB_UP_PKT;

typedef union	_USB_DATA_PACKET {		/* USB上传或者下传数据缓冲区 */
	USB_DOWN_PKT	down;
	USB_UP_PKT		up;
}	USB_DATA_PKT;

/* 命令码定义,按位说明
   位7为命令类型:  0=实现特定功能, 1=存储器和SFR读写
   对于"实现特定功能"命令类型:
       位6-位0为定义的具体命令码, 命令码为00H-7FH, 其中: 00H-3FH为通用标准命令, 40H-7FH为与应用系统有关的特定命令
       目前版本定义了以下通用标准命令:
           00H: 获取调试固件程序的版本,并取消未完成的上传数据块
           10H: 获取当前应用系统的版本和说明字符串
   对于"存储器和SFR读写"命令类型:
       位6为数据传输方向:      0=读操作/上传, 1=写操作/下传
       位5-位4为数据读写宽度:  00=以字节为单位/8位, 01=以字为单位/16位, 10=以双字为单位/32位, 11=以位为单位/1位
       位1-位0为存储器空间:    00=存取SFR, 01=存取内部RAM, 10=存取外部RAM, 11=存取程序ROM
       例如: 命令码80H为读SFR, 命令码83H为读程序ROM, 命令码C1H为写内部RAM, 命令码C2H为写外部RAM
   状态码定义: 00H为操作成功, 080H为命令不支持, 0FFH为未定义的错误 */

#define USB_CMD_GET_FW_INFO		0x00
#define USB_CMD_GET_APP_INFO	0x10

#define USB_CMD_MEM_ACCESS		0x80
#define USB_CMD_MEM_DIR_WR		0x40
#define USB_CMD_MEM_WIDTH		0x0C
#define USB_CMD_MEM_W_BYTE		0x00
#define USB_CMD_MEM_W_WORD		0x04
#define USB_CMD_MEM_W_DWORD		0x08
#define USB_CMD_MEM_W_BIT		0x0C
#define USB_CMD_MEM_SPACE		0x03
#define USB_CMD_MEM_S_SFR		0x00
#define USB_CMD_MEM_S_IRAM		0x01
#define USB_CMD_MEM_S_XRAM		0x02
#define USB_CMD_MEM_S_ROM		0x03

#define ERR_SUCCESS				0x00
#define ERR_PARAMETER			0x10
#define ERR_UNSUPPORT			0x80
#define ERR_UNDEFINED			0xFF

#define THIS_FIRMWARE_VER		0x10
#define THIS_APP_SYS_VER		0x09
#define THIS_APP_SYS_STR		"CH376+MCS51"


#define DELAY_START_VALUE		1	  /* 根据单片机的时钟选择初值,20MHz以下为0,30MHz以上为2 */

extern int USB_Test(void);


