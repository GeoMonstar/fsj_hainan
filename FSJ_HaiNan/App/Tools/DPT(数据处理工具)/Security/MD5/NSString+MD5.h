//
//  NSString+MD5.h
//  MD5Demo
//
//  Created by Arlexovincy on 14-3-12.
//  Copyright (c) 2014年 Arlexovincy. All rights reserved.
// 16位其实就是32位去除头和尾各8位

#import <Foundation/Foundation.h>

@interface NSString(MD5)

//把字符串加密成32位小写md5字符串
+ (NSString*)md532BitLower:(NSString *)inPutText;

//把字符串加密成32位大写md5字符串
+ (NSString*)md532BitUpper:(NSString*)inPutText;

//md5 16位加密 （大写）
+ (NSString *)md5:(NSString *)str;

@end
