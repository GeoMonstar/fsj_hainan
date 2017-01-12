//
//  FQS_TabbarBtn.h
//  FQS_Tabbar
//
//  Created by yier on 15/2/25.
//  Copyright (c) 2015年 huiyict. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQS_TabbarBtn : UIButton

@property(nonatomic,strong)UIImageView * redcircle;
@property(nonatomic,strong)UILabel * name;
@property(nonatomic,strong)UIImageView * image;
- (void)initImageAndName;
- (void)initCircleBtn;
@end
