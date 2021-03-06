/* 调试 */
/* 提供printf子程序 */

#include	"DEBUG.H"

/* 检查操作状态,如果错误则显示错误代码并停机,应该替换为实际的处理措施,例如显示错误信息,等待用户确认后重试等 */
void	mStopIfError( UINT8 iError )
{
	if ( iError == USB_INT_SUCCESS ) return;  /* 操作成功 */
	printf( "Error: %02X\n", (UINT16)iError );  /* 显示错误 */
	while ( 0 ) {
/*		LED_OUT_ACT( );*/  /* LED闪烁 */
		mDelaymS( 200 );
/*		LED_OUT_INACT( );*/
		mDelaymS( 200 );
	}
}

/* 为printf和getkey输入输出初始化串口 */
void	mInitSTDIO( void )
{

}
