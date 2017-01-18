//
//  NSDictionary+SafeValue.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/16.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "NSDictionary+SafeValue.h"

@implementation NSDictionary (SafeValue)

-(id)safeObjectForKey:(NSString*) key{
    
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    return object;
    
}

@end
