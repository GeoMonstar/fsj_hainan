//
//  NSDictionary+SafeValue.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/16.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeValue)
/**
 *  显示消息提示框
 *
 *  @param key 字典键
 *
 *  @return 字典值
 */
-(id)safeObjectForKey:(NSString*) key;


@end
