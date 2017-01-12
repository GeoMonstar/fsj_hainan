//
//  AESEncryption.h
//  test
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHex : NSObject

//将(2进制)转成的16进制字符串,16进制在网络传输
+(NSString *)normalStringToHexString:(NSString*)unencryptedContent;
//将16进制字符串还原成内容
+(NSString *)hexStringToNormalString:(NSString *)dataClassHexString;
@end


