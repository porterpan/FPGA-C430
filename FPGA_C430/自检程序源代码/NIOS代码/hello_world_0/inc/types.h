/*

                         \\\|///
                       \\  - -  //
                        (  @ @  )
+---------------------oOOo-(_)-oOOo-------------------------+
|                                                           |
|                         TYPE.H                            |
|                     by Xiaoran Liu                        |
|                        2005.3.16                          |
|                                                           |
|                    ZERO research group                    |
|                        www.the0.net                       |
|                                                           |
|                            Oooo                           |
+----------------------oooO--(   )--------------------------+
                      (   )   ) /
                       \ (   (_/
                        \_)     

*/
#ifndef _TYPE_H_
#define _TYPE_H_

#define int8_t    signed char
#define uint8_t   unsigned char
#define int16_t   signed short
#define uint16_t  unsigned short
#define uint32_t  unsigned int
#define prog_char char

typedef char               S8;
typedef unsigned char      U8;
typedef short              S16;
typedef unsigned short     U16;
typedef int                S32;
typedef unsigned int       U32;
typedef long long          S64;
typedef unsigned long long U64;
typedef unsigned char      BIT;
typedef unsigned int       BOOL;

#ifndef NULL
#define NULL    ((void *)0)
#endif

#ifndef FALSE
#define FALSE   (0)
#endif

#ifndef TRUE
#define TRUE    (1)
#endif

typedef unsigned char  BYTE;
typedef unsigned short WORD;
typedef unsigned long  DWORD;
//typedef unsigned int   BOOL;

#endif

