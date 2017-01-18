//
//  AppDelegate.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "AppDelegate.h"
#import "JQInitializeTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //获取本地Json
    
        NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"CG3647C" ofType:@"json"];
        NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSArray *jsonArr = [[[jsonDic objectForKey:@"tables"]objectForKey:@"parameter"]objectForKey:@"item"];
        [[EGOCache globalCache]setObject:(NSArray *)jsonArr forKey:kJsonArr];
    NSMutableDictionary *mutDic = @{}.mutableCopy;
    for (NSDictionary *dic in jsonArr) {
        [mutDic setObject:[dic objectForKey:@"-name"] forKey:[dic objectForKey:@"-parno"]];
    }
    
   
    //保存 参数 名字映射字典
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (NSDictionary *tempdic in (NSArray *)[[EGOCache globalCache]objectForKey:kJsonArr]) {
            ParameterModel *model = [ParameterModel initWithDictionary:tempdic];
            [dic setObject:model.name forKey:model.parno];
        }
        [[EGOCache globalCache]setObject:(NSDictionary *)dic forKey:kMapDic];
    //保存 fsjid 数组
    if (![[EGOCache globalCache]hasCacheForKey:kfsjIdArr]) {
        NSMutableArray *fsjIDArr = @[].mutableCopy;
        [[EGOCache globalCache]setObject:(NSMutableArray *)fsjIDArr forKey:kfsjIdArr];

    }
    //connectFSJ
    NSArray *fsjIdArr = (NSArray *)[[EGOCache globalCache]objectForKey:kfsjIdArr];
    for (NSString *idStr in fsjIdArr) {
        OneFSJModel *model = [OneFSJModel getOneFSJWithFsjID:idStr];;
        if (model) {
            [model updateFSJModel];
        }
    }
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [JQInitializeTabbarController initializeTabbarControllerReturnTBC];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
   
 
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
