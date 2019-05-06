
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
#define MAX_DATA_SIZE		20			/* ����������������ݳ���,��Чֵ��1��56 */
#endif

typedef	struct	_USB_DOWN_PACKET {		/* �´������ݰ��ṹ,��������/д���� */
	UINT8	mCommand;					/* ������,������Ķ��� */
	UINT8	mCommandNot;				/* ������ķ���,����У���´����ݰ� */
	union {
		UINT8	mByte[4];				/* ͨ�ò��� */
		UINT16	mWord[2];				/* ͨ�ò���,���ֽ���ǰ,Little-Endian */
		UINT32	mDword;					/* ͨ�ò���,���ֽ���ǰ,Little-Endian */
		void	*mAddress;				/* ��д��������ʼ��ַ,���ֽ���ǰ,Little-Endian */
	} u;
	UINT8	mLength;					/* ����Ļ������ĳ���,��д�������ֽ��� */
	UINT8	mBuffer[ MAX_DATA_SIZE ];	/* ���ݻ����� */
}	USB_DOWN_PKT;

typedef	struct	_USB_UP_PACKET {		/* �ϴ������ݰ��ṹ,����״̬/������ */
	UINT8	mStatus;					/* ״̬��,������Ķ��� */
	UINT8	mCommandNot;				/* ������ķ���,����У���ϴ����ݰ� */
	UINT8	mReserved[4];
	UINT8	mLength;					/* ����Ļ������ĳ���,���������ֽ��� */
	UINT8	mBuffer[ MAX_DATA_SIZE ];	/* ���ݻ����� */
}	USB_UP_PKT;

typedef union	_USB_DATA_PACKET {		/* USB�ϴ������´����ݻ����� */
	USB_DOWN_PKT	down;
	USB_UP_PKT		up;
}	USB_DATA_PKT;

/* �����붨��,��λ˵��
   λ7Ϊ��������:  0=ʵ���ض�����, 1=�洢����SFR��д
   ����"ʵ���ض�����"��������:
       λ6-λ0Ϊ����ľ���������, ������Ϊ00H-7FH, ����: 00H-3FHΪͨ�ñ�׼����, 40H-7FHΪ��Ӧ��ϵͳ�йص��ض�����
       Ŀǰ�汾����������ͨ�ñ�׼����:
           00H: ��ȡ���Թ̼�����İ汾,��ȡ��δ��ɵ��ϴ����ݿ�
           10H: ��ȡ��ǰӦ��ϵͳ�İ汾��˵���ַ���
   ����"�洢����SFR��д"��������:
       λ6Ϊ���ݴ��䷽��:      0=������/�ϴ�, 1=д����/�´�
       λ5-λ4Ϊ���ݶ�д���:  00=���ֽ�Ϊ��λ/8λ, 01=����Ϊ��λ/16λ, 10=��˫��Ϊ��λ/32λ, 11=��λΪ��λ/1λ
       λ1-λ0Ϊ�洢���ռ�:    00=��ȡSFR, 01=��ȡ�ڲ�RAM, 10=��ȡ�ⲿRAM, 11=��ȡ����ROM
       ����: ������80HΪ��SFR, ������83HΪ������ROM, ������C1HΪд�ڲ�RAM, ������C2HΪд�ⲿRAM
   ״̬�붨��: 00HΪ�����ɹ�, 080HΪ���֧��, 0FFHΪδ����Ĵ��� */

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


#define DELAY_START_VALUE		1	  /* ���ݵ�Ƭ����ʱ��ѡ���ֵ,20MHz����Ϊ0,30MHz����Ϊ2 */

extern int USB_Test(void);


