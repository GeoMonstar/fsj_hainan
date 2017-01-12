//
//  AESEncryption.h
//  test
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESEncryption : NSObject

#pragma mark - AES128加密CBC模式
//将加密内容(2进制)转成带密码的16进制字符串,16进制在网络传输
+(NSString *)encryptAESData:(NSString*)unencryptedContent app_key:(NSString*)key;
//将带密码的16进制字符串还原成未加密的内容
+(NSString *)decryptAESData:(NSString *)dataClassHexString  app_key:(NSString*)key;
 
@end


