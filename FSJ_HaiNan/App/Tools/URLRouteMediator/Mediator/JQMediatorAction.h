//
//  JQMediatorAction.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/2/23.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VKMsgSend;
@interface JQMediatorAction : NSObject

+ (instancetype)sharedInstance;

/**
 *  远程调用入口(服务器下发)
 */
- (void)performActionWithUrl:(NSString *)url animated:(BOOL)animated;
/**
 *  本地组件调用入口
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName;


@end
