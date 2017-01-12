//
//  JQNagcAdapter.m
//  GospellLive
//
//  Created by Monstar on 16/7/9.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "JQNagcAdapter.h"
#import <SDWebImage/SDImageCache.h>
@implementation JQNagcAdapter

static JQNagcAdapter * _nagcAdapter = nil;

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nagcAdapter = [[super allocWithZone:NULL]init];
    });
    return _nagcAdapter;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [JQNagcAdapter shareInstance];
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return [JQNagcAdapter shareInstance];
}
- (void)popNagcViewController:(UIViewController *)viewController Animation:(BOOL)animation{
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backBarBtn.png"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        [viewController.navigationController popViewControllerAnimated:animation];
    }];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    viewController.navigationItem.leftBarButtonItem = backBarBtn;
    
    
}
- (void)disMissNagcViewController:(UIViewController *)viewController Animation:(BOOL)animation{
    //返回按钮
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backBarBtn.png"] forState:UIControlStateNormal];
    
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [viewController dismissViewControllerAnimated:animation completion:^{
             
         }];
     }];
    UIBarButtonItem * backBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    viewController.navigationItem.leftBarButtonItem = backBarBtn;
}

- (void)setRootViewControllerWithViewController:(UIViewController *)rootVC end:(EndBlock)endBlock{
    


    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate respondsToSelector:@selector(window)]) {
        self.window = [delegate performSelector:@selector(window)];
    }
    else
    {
        self.window = [[UIApplication sharedApplication]keyWindow];}
    [self.window.rootViewController.view removeFromSuperview];
    self.window.rootViewController = nil;
    
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        //因为之前动画是打开的 下面关闭再打开
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = rootVC;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        [[SDImageCache sharedImageCache]cleanDisk];
        [[SDImageCache sharedImageCache]clearMemory];
        endBlock();
    }];
    
}

@end
