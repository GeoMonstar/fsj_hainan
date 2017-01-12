//
//  MBProgressHUD+HUDTools.h
//  UJF
//
//  Created by JUNN on 15/7/21.
//  Copyright (c) 2015年 JUNN. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HUDTools)

/**
 *  显示成功信息提示框
 *
 *  @param success 成功信息
 *  @param view    指定显示信息的view
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
/**
 *  显示失败信息提示框
 *
 *  @param success 失败信息
 *  @param view    指定显示信息的view
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;
/**
 *  显示消息提示框
 *
 *  @param message 消息
 *  @param view    指定显示信息的view
 *
 *  @return 提示框
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
/**
 *  显示成功信息提示框
 *
 *  @param success 成功信息
 */
+ (void)showSuccess:(NSString *)success;
/**
 *  显示失败信息提示框
 *
 *  @param success 失败信息
 */
+ (void)showError:(NSString *)error;
/**
 *  显示消息提示框(有loading效果)
 *
 *  @param message 消息
 *
 *  @return 提示框
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;

/**
 *  @author T, 15-06-12 14:06:54
 *
 *  显示消息提示框(纯文本)
 *
 *  @param message 消息
 *  @param view    指定显示信息的view
 *
 */
+ (void)showTextMessage:(NSString *)message toView:(UIView *)view;

/**
 *  @author T, 15-06-12 14:06:20
 *
 *  显示消息提示框(纯文本)
 *
 *  @param message 消息
 */
+(void)showTextMessage:(NSString *)message;

/**
 *  隐藏提示框
 *
 *  @param view 指定隐藏提示框的view
 */
+ (void)hideHUDForView:(UIView *)view;
/**
 *  隐藏提示框
 */
+ (void)hideHUD;

@end
