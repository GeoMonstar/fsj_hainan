//
//  UIButton+JQcreateButton.h
//  GospellLive
//
//  Created by Monstar on 16/10/20.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JQcreateButton)

+ (UIButton *)createButtonwithFrame:(CGRect)frame andTitle:(NSString *)title andTitleColor:(UIColor *)color;

+ (UIButton *)createButtonwithFrame:(CGRect)frame andTitle:(NSString *)title andTitleColor:(UIColor *)color andBgColor:(UIColor *)bgcolor;


+ (UIButton *)createButtonwithFrame:(CGRect)frame andTitle:(NSString *)title andTitleFont:(NSInteger)font andTitleColor:(UIColor *)color andBgColor:(UIColor *)bgcolor;
@end
