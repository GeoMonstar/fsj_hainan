//
//  AESEncryption.m
//  test
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

#import "NetworkHex.h"
#import "HexAndData.h"
#import "DataToHexString.h"

@implementation NetworkHex

//将内容(2进制)转成16进制字符串
+(NSString *)normalStringToHexString:(NSString*)unencryptedContent
{
    //将nsstring转化为nsdata
    NSData *data = [unencryptedContent dataUsingEncoding:NSUTF8StringEncoding];

    //将Data转为16进制字符串
    NSString * dataClassHexString = [data dataToHexString];
    
    return dataClassHexString ;
}

//将16进制字符串还原内容
+(NSString *)hexStringToNormalString:(NSString *)dataClassHexString
{
    //把16进制字符串转为2进制NSData类型
    NSData * binaryData = [dataClassHexString stringToHexData];

    //将NSData转化为nsstring
    NSString * unencryptedContent = [[NSString alloc] initWithData:binaryData encoding:NSUTF8StringEncoding];
    return unencryptedContent;
}

@end

