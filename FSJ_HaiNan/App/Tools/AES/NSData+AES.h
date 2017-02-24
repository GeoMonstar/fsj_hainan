//
//  NSData+AES.h
//  Smile
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key;   //解密

@end
