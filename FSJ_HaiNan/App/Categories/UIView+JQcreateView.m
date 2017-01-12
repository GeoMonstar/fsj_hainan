//
//  UIView+JQcreateView.m
//  GospellLive
//
//  Created by Monstar on 16/10/20.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "UIView+JQcreateView.h"

@implementation UIView (JQcreateView)
+ (UIView *)createViewwithFrame:(CGRect)frame andColor:(UIColor*)color{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
@end
