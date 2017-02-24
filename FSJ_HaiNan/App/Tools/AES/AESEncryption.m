//
//  AESEncryption.m
//  test
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

#import "AESEncryption.h"
#import "NSData+AES.h"
#import "HexStringToBinaryData.h"
#import "BinaryDataToHexString.h"

@implementation AESEncryption

#pragma mark - AES加密
//将加密内容(2进制)转成带密码的16进制字符串
+(NSString *)encryptAESData:(NSString*)unencryptedContent app_key:(NSString*)key
{
    //将nsstring转化为nsdata
    NSData *data = [unencryptedContent dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:key];
    //将加密后的Data转为16进制字符串
    NSString * dataClassHexString = [encryptedData binaryDataToHexString];
    
    return dataClassHexString ;
}

#pragma mark - AES解密
//将带密码的16进制字符串还原成未加密的内容
+(NSString *)decryptAESData:(NSString *)dataClassHexString  app_key:(NSString*)key
{
    //把加密的16进制字符串转为2进制NSData类型
    NSData * binaryData = [dataClassHexString hexStringToBinaryData];
    //使用密码对data进行解密
    NSData *decryData = [binaryData AES128DecryptWithKey:key];
    //将解了密的NSData转化为nsstring
    NSString * unencryptedContent = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return unencryptedContent;
}

@end

