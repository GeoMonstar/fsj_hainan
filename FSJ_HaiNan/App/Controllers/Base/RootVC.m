//
//  RootVC.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "RootVC.h"
#import "JQLoginVC.h"
#import "JQInitializeTabbarController.h"
@interface RootVC ()
@property (strong, nonatomic) UIViewController * rootVC;
@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstLogin];
    [self logout];
}
- (void)logout{
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:kNotificationWithLogout object:nil]subscribeNext:^(id x) {
        JQLoginVC *loginVC = [[JQLoginVC alloc]init];
        UINavigationController *navlogin = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [[JQNagcAdapter shareInstance] setRootViewControllerWithViewController:navlogin end:^{}];
    }];
}
- (void)firstLogin{
    
    if([App_LastVersionCode isEqualToString:App_CurrentVersionCode]){
        //不是第一次启动
        if (![[SSKeychain accessToken]isEqualToString:@""]) {
            
            [self getNewestjwt];
            self.rootVC = [JQInitializeTabbarController initializeTabbarControllerReturnTBC];
        }else{
            //需要登录
            JQLoginVC *loginVC = [[JQLoginVC alloc]init];
            UINavigationController *navlogin = [[UINavigationController alloc]initWithRootViewController:loginVC];
            self.rootVC = navlogin;
        }
        //设置rootVC
        [[JQNagcAdapter shareInstance] setRootViewControllerWithViewController:self.rootVC end:^{}];
    }else{
        /**
         *  第一次使用app时
         */
        //创建数据库
        
        [[FMEncryptDatabaseQueue sharedInstance]inDatabase:^(FMDatabase *db) {
            if (App_LastVersionCode == nil) {
                [SSKeychain deleteAccessToken];
                
                if (![db executeStatements:CreatTable]) {
                    FMDBLogLastError(db);
                }
            }
        }];
        //保存当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:App_CurrentVersionCode forKey:App_VersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        JQLoginVC *loginVC = [[JQLoginVC alloc]init];
        UINavigationController *navlogin = [[UINavigationController alloc]initWithRootViewController:loginVC];
        self.rootVC = navlogin;
        [[JQNagcAdapter shareInstance] setRootViewControllerWithViewController:self.rootVC end:^{
        }];
    }
}
- (void)getNewestjwt{
    
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
