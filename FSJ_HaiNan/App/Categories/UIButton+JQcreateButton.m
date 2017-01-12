//
//  UIButton+JQcreateButton.m
//  GospellLive
//
//  Created by Monstar on 16/10/20.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "UIButton+JQcreateButton.h"

@implementation UIButton (JQcreateButton)
+ (UIButton *)createButtonwithFrame:(CGRect)frame andTitle:(NSString *)title andTitleColor:(UIColor *)color{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}
+ (UIButton *)createButtonwithFrame:(CGRect)frame andTitle:(NSString *)title andTitleColor:(UIColor *)color andBgColor:(UIColor *)bgcolor{
    UIButton *button = [UIButton createButtonwithFrame:frame andTitle:title andTitleColor:color];
    [button setBackgroundColor:bgcolor];
    return button;
}
+ (UIButton *)createButtonwithFrame:(CGRect)frame andTitle:(NSString *)title andTitleFont:(NSInteger)font andTitleColor:(UIColor *)color andBgColor:(UIColor *)bgcolor{
    UIButton *button = [UIButton createButtonwithFrame:frame andTitle:title andTitleColor:color andBgColor:bgcolor];

    button.titleLabel.font = [UIFont systemFontOfSize:font];
    return button;
}
@end
