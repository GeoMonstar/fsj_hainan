//
//  NSString+NSStringHexToBytes.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringHexToBytes)


/**
 *  16进制字符串转Data
 *  return 16进制字符串转Data
 */
-(NSData*)hexToBytes;
/**
 *  10进制字符串转16进制  倒序输出
 *  return 10进制字符串转16进制  倒序输出
 */
- (NSString *)ToHex;

- (NSString *)ToHex2;

- (NSString *)ToHex3;

- (NSString *)ToHex4;

- (NSString *)ToHex8;
/**
 *  0100转"0x0001"
 *  return "0x0001"
 */
- (NSString *)ReverseStr;


@end
