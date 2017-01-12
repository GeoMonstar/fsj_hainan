//
//  FQS_TabbarBtn.m
//  FQS_Tabbar
//
//  Created by yier on 15/2/25.
//  Copyright (c) 2015年 huiyict. All rights reserved.
//

#import "FQS_TabbarBtn.h"

@implementation FQS_TabbarBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
 
    return self;
}

- (void)initImageAndName
{
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 10)];
    self.name.textAlignment = 1;
    self.name.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.name];
    
    self.redcircle = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2+12,5, 5, 5)];
    self.redcircle.layer.cornerRadius = self.redcircle.bounds.size.width/2;
    self.redcircle.backgroundColor = [UIColor redColor];
    self.redcircle.hidden = YES;
    [self addSubview:self.redcircle];
    
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-24)/2, 5,24, 24)];
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.image];
}

- (void)initCircleBtn
{
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-39)/2, -10,50, 50)];
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.image];
}

/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}

@end
