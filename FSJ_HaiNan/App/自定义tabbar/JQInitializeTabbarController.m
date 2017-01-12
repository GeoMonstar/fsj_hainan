//
//  JQInitializeTabbarController.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/10.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "JQInitializeTabbarController.h"
#import "FQS_TabbarController.h"

@implementation JQInitializeTabbarController


+ (UITabBarController *)initializeTabbarControllerReturnTBC{

    NSMutableArray * tabbarViewControllers = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * nameArr= [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * imageNameArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * imageNameSelArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i< TabbarVCArray.count; i++) {
        NSString * className = [NSString stringWithFormat:@"%@",TabbarVCArray[i]];
        Class class = NSClassFromString(className);
        
        UINavigationController * nagc= [[UINavigationController alloc]initWithRootViewController:(UIViewController *)[[class alloc] init]];
        
        //title为""时显示大图标
        if ([className containsString:@"HomeVC"]) {
            [nameArr addObject:@"首页"];
            [imageNameArr addObject:@"tb-home.png"];
            [imageNameSelArr addObject:@"tb-home1.png"];
        }
        else if ([className containsString:@"Jiankong"]){
            [nameArr addObject:@"监控"];
            [imageNameArr addObject:@"tb-jiankong.png"];
            [imageNameSelArr addObject:@"tb-jiankong1.png"];
        }
        
        else if ([className containsString:@"Tongji"]){
            [nameArr addObject:@"统计"];
            [imageNameArr addObject:@"tb-tongji.png"];
            [imageNameSelArr addObject:@"tb-tongji1.png"];
        }
        else if  ([className containsString:@"Rizhi"]){
            
            [nameArr addObject:@"日志"];
            [imageNameArr addObject:@"tb-rizhi.png"];
            [imageNameSelArr addObject:@"tb-rizhi1.png"];
            
        }
        [tabbarViewControllers addObject:nagc];
    }
    

    FQS_TabbarController * tbc = [[FQS_TabbarController alloc]init];
    tbc.viewControllers = tabbarViewControllers;
    
#pragma mark - tabbar按钮对应的图片和名字
    NSMutableDictionary *  tabbarDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [tabbarDic setObject:nameArr forKey:@"name"];
    [tabbarDic setObject:imageNameArr forKey:@"imageName"];
    [tabbarDic setObject:imageNameSelArr forKey:@"imageNameSel"];
    //超出和系统一样默认为0
    tbc.selectedIndex = 0;
    UIColor *selectedColor = ThemeColor;
    [tbc initTabbarWithResource:tabbarDic TabbarNameColor:nil TabbarBackgroundColor:[UIColor whiteColor]];
    
    //有中间大的按钮的时候去掉线和阴影
    //tbc.tabBar.backgroundImage = [[UIImage alloc] init];
    //tbc.tabBar.shadowImage = [[UIImage alloc] init];
    return tbc;

}
@end
