//
//  FQS_TabbarController.m
//  FQS_Tabbar
//
//  Created by yier on 15/2/25.
//  Copyright (c) 2015年 huiyict. All rights reserved.
//

#import "FQS_TabbarController.h"
#import "FQS_TabbarBtn.h"
#import "FQS_Tabbar.h"


@interface FQS_TabbarController ()<FQS_TabBarDelegate>
{
    FQS_Tabbar *myView;
}
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation FQS_TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"selectTabbarWithIndex" object:nil]
    subscribeNext:^(NSNotification * indexInfo) {
        NSNumber * index = indexInfo.userInfo[@"index"];
        
        for (UIView *view in self.tabBar.subviews) {
            
            if ([view isKindOfClass:[FQS_Tabbar class]]) {
                FQS_Tabbar * tabbar = (FQS_Tabbar *)view;
                FQS_TabbarBtn * btn = (FQS_TabbarBtn *)view.subviews[index.integerValue];
                [tabbar tabbarclickBtn:btn];
            }
        }
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"initRedState" object:nil] subscribeNext:^(NSNotification * redState) {
        NSArray * redStateArray = redState.userInfo[@"redStateArray"];
        
        for (UIView *view in self.tabBar.subviews) {
            
            if ([view isKindOfClass:[FQS_Tabbar class]]) {
                for (int i = 0; i<redStateArray.count; i++) {
                    FQS_TabbarBtn * btn = (FQS_TabbarBtn *)view.subviews[i];
                    if ([redStateArray[i] integerValue] != 0) {
                        btn.redcircle.hidden = NO;
                    }
                }
            }
        }
    }];
}

- (void)initTabbarWithResource:( NSMutableDictionary * _Nonnull )tabbarDic TabbarNameColor:(UIColor * _Nullable)tabbarNameColor TabbarBackgroundColor:( UIColor * _Nullable  )tabbarBGColor
{
    ////这个是tabbar的frame，这样中间的超出来的部分才能点击
    CGRect rectTabbar = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height+0);
    self.tabBar.frame = rectTabbar;
    
    //这个是myview的frame
     CGRect rectMyView = CGRectMake(0,0,CGRectGetWidth(rectTabbar), 49);
    
    //测试添加自己的视图
    //设置代理必须改掉前面的类型,不能用UIView
    
    myView = [[FQS_Tabbar alloc] init];
    myView.count = self.viewControllers.count;
    myView.frame = rectMyView;
    
    //初始化tabbar的背景色
    myView.backgroundColor= tabbarBGColor? tabbarBGColor : [UIColor colorWithWhite:0.8 alpha:1];
    [self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
   
    myView.tabbarDic = tabbarDic;
    //为控制器添加按钮
    for (int i=0; i<self.viewControllers.count; i++) { //根据有多少个子视图控制器来进行添加按钮
        
        NSString *imageName = [NSString stringWithFormat:@"%@",tabbarDic[@"imageName"][i]];
        NSString *imageNameSel = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        UIColor * tabbarItemTextColor = tabbarNameColor ? tabbarNameColor:[UIColor colorWithRed:79/255.0 green:81/255.0 blue:82/255.0 alpha:1];
        
        
        [myView addButtonWithName:tabbarDic[@"name"][i] image:image selectedImage:imageSel selectIndex:self.selectedIndex tabbarNameColor:tabbarItemTextColor];
    }
    
    //设置tabbar的跳转代理方法 因为第一个按钮初始化时调用了选中事件 会触发代理方法 所以等初始化完成后才设置代理
    myView.delegate = self; //设置代理
 
}
/**设置代理*/
- (void)tabBar:(FQS_Tabbar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;

    for (FQS_TabbarBtn * btn in tabBar.subviews) {
        if (btn.tag == to) {
            btn.redcircle.hidden = YES;
        }
    }
}



@end
