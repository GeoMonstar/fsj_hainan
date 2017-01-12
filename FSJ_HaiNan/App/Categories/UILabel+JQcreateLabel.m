//
//  UILabel+JQcreateLabel.m
//  GospellLive
//
//  Created by Monstar on 16/10/20.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "UILabel+JQcreateLabel.h"

@implementation UILabel (JQcreateLabel)

+ (UILabel *)createLabelwithFrame:(CGRect)frame andTextColor:(UIColor *)color andTextFont:(NSInteger)font{

    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}
@end
