//
//  MD5.m
//  MD5Demo
//
//  Created by Arlexovincy on 14-3-12.
//  Copyright (c) 2014年 Arlexovincy. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(MD5)

/**
 *  把字符串加密成32位小写md5字符串
 *
 *  @param inPutText 需要被加密的字符串
 *
 *  @return 加密后的32位小写md5字符串
 */
+ (NSString*)md532BitLower:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (uint32_t)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/**
 *  把字符串加密成32位大写md5字符串
 *
 *  @param inPutText 需要被加密的字符串
 *
 *  @return 加密后的32位大写md5字符串
 */
+ (NSString*)md532BitUpper:(NSString*)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (uint32_t)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

//md5 16位加密 （大写）
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash uppercaseString];
//    return [hash lowercaseString];
}

@end
