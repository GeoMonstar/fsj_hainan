//
//  DataToHexString.m
//  test
//
//  Created by niko on 14-10-30.
//  Copyright (c) 2014年 FuQinsghan. All rights reserved.
//

#import "BinaryDataToHexString.h"

@implementation NSData(BinaryDataToHexString)

- (NSString *)binaryDataToHexString
{
    NSUInteger len = [self length];
    char * chars = (char *)[self bytes];
    NSMutableString * hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    
    return hexString;
}

@end
