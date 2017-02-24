//
//  DataToHexString.h
//  test
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(BinaryDataToHexString)
//将2进制data转成16进制字符串
- (NSString *)binaryDataToHexString;
@end
