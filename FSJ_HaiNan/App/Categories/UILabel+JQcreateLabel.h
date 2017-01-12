//
//  UILabel+JQcreateLabel.h
//  GospellLive
//
//  Created by Monstar on 16/10/20.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JQcreateLabel)

+ (UILabel *)createLabelwithFrame:(CGRect)frame andTextColor:(UIColor *)color andTextFont:(NSInteger)font;
@end
