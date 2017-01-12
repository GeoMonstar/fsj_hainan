//
//  FQS_TabbarController.h
//  FQS_Tabbar
//
//  Created by yier on 15/2/25.
//  Copyright (c) 2015年 huiyict. All rights reserved.
//

/**
 .
 NSDictionary * redStateDic = @{@"redStateArray":@[@"1",@"0",@"0",@"0",@"1"]};
 [[NSNotificationCenter defaultCenter]postNotificationName:@"initRedState" object:nil userInfo:redStateDic];
 
 - returns: 返回那些是红色按钮
 */

#import <UIKit/UIKit.h>

@interface FQS_TabbarController : UITabBarController



- (void)initTabbarWithResource:( NSMutableDictionary * _Nonnull )tabbarDic TabbarNameColor:(UIColor * _Nullable)tabbarNameColor TabbarBackgroundColor:( UIColor * _Nullable  )tabbarBGColor;
@end
