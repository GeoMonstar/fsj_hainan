//
//  FQS_Tabbar.m
//  FQS_Tabbar
//
//  Created by yier on 15/2/25.
//  Copyright (c) 2015年 huiyict. All rights reserved.
//


//为了不和系统的tag冲突
#define RedButtonTag 33333

#import "FQS_Tabbar.h"
#import "Define.h"

@interface FQS_Tabbar ()
/**
 *  设置之前选中的按钮
 */

@property (strong, nonatomic) UIColor * tabbarNameColor;
@property (nonatomic, weak) FQS_TabbarBtn *selectedBtn;
@end

@implementation FQS_Tabbar

- (void)addButtonWithName:(NSString *)name image:(UIImage *)image selectedImage:(UIImage *)selectedImage selectIndex:(NSInteger )selectIndex tabbarNameColor:(UIColor *)tabbarNameColor{
    //按钮内容颜色
    self.tabbarNameColor = tabbarNameColor;
    
    FQS_TabbarBtn *btn = [[FQS_TabbarBtn alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width / self.count, self.bounds.size.height)];
    btn.tag = self.subviews.count+ RedButtonTag;
    
    //中间的按钮,设置为空的title就可以了
    if (![name isEqualToString:@""]) {
        [btn initImageAndName];
        btn.name.text = name;
        
        btn.name.textColor = self.tabbarNameColor;
        btn.image.image = image;
    }
    else
    {
        [btn initCircleBtn];
        btn.image.image = image;
    }
    
    [self addSubview:btn];
    
    //带参数的监听方法记得加"冒号"
    [btn addTarget:self action:@selector(tabbarclickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果是第selectIndex + 1个按钮, 则选中,错误的selectIndex系统自动置0
    if (self.subviews.count == selectIndex + 1 ) {
        [self tabbarclickBtn:btn];
    }
  
}

- (void)selectTabbarIndex:(NSInteger)selectedIndex
{
    FQS_TabbarBtn * btn = (FQS_TabbarBtn *)[self viewWithTag:selectedIndex+RedButtonTag];
    [self tabbarclickBtn:btn];
}

- (void)initRedcircle:(NSArray *)redStateArray
{
    for (int i = 0;i<redStateArray.count;i++) {
        if ([[redStateArray objectAtIndex:i] intValue] != 0) {
          
            FQS_TabbarBtn * btn = (FQS_TabbarBtn *)self.subviews[i];
            btn.redcircle.hidden = NO;
        }
    }
}

/**专门用来布局子视图, 别忘了调用super方法*/
- (void)layoutSubviews {
    [super layoutSubviews];
 
    self.count = (int)self.subviews.count;
    for (int i = 0; i < self.count; i++) {
        //取得按钮
        FQS_TabbarBtn *btn = self.subviews[i];
        btn.tag = i + RedButtonTag; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        CGFloat x = i * self.bounds.size.width / self.count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / self.count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
    }
}

/**
 *  自定义TabBar的按钮点击事件
 */
- (void)tabbarclickBtn:(FQS_TabbarBtn *)button{
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    self.selectedBtn.name.textColor = self.tabbarNameColor;
    NSInteger theIndexTag = 0;
    if (self.selectedBtn) {
        theIndexTag = self.selectedBtn.tag - RedButtonTag;
    }
    self.selectedBtn.image.image = [UIImage imageNamed:self.tabbarDic[@"imageName"][theIndexTag]];
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    //选中的颜色
    self.selectedBtn.name.textColor =ThemeColor;
    self.selectedBtn.image.image = [UIImage imageNamed:self.tabbarDic[@"imageNameSel"][button.tag- RedButtonTag]];
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag- RedButtonTag to:button.tag- RedButtonTag];
    }
}

@end
