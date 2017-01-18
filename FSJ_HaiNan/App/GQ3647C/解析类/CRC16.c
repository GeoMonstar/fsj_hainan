//
//  CRC16.c
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#include "CRC16.h"


//查表效率更高
USHORT useCRC16( UCHAR * pucFrame, USHORT usLen )
{
    UCHAR ucCRCHi = 0xFF;
    
    UCHAR ucCRCLo = 0xFF;
    
    int iIndex;
    
    while( usLen-- )
        
    {
        iIndex = ucCRCLo ^ *( pucFrame++ );
        ucCRCLo = ( UCHAR )( ucCRCHi ^ aucCRCHi[iIndex] );
        ucCRCHi = aucCRCLo[iIndex];
    }
    return ( USHORT )( ucCRCHi << 8 | ucCRCLo );
}

UInt16 count_CRC(unsigned char *addr, UInt16 num)
{
    UInt16 CRC = 0xFFFF;
    UInt16 i;
    while (num--)
    {
        CRC ^= *addr++;
        for (i = 0; i < 8; i ++)
        {
            if (CRC & 1)
            {
                CRC >>= 1;
                CRC ^= 0xA001;
            }
            else
            {
                CRC >>= 1;
            }
        }
    }
    return CRC;
}
