//
//  AppDelegate.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "AppDelegate.h"
#import "JQInitializeTabbarController.h"

@interface AppDelegate (){

    UIBackgroundTaskIdentifier backgroundTaskIdentifier;
    
    UIBackgroundTaskIdentifier oldBackgroundTaskIdentifier;

    NSInteger count;
}

@property (nonatomic, retain)NSTimer* myTimer;


@end


@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [JQInitializeTabbarController initializeTabbarControllerReturnTBC];
    
    [self.window makeKeyAndVisible];
  
    [self set3DTouch];
    return YES;
}
#pragma mark -- 3DTouch
- (void)set3DTouch{
    // Override point for customization after application launch.
    
    /**
     * UIApplicationShortcutItem 创建标签的类
     * UIApplicationShortcutItem 创建可变标签的类
     * UIApplicationShortcutItem 创建标签ICON的类
     */
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"wifi" localizedSubtitle:@"" icon:icon1 userInfo:nil];
    
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"setting" localizedSubtitle:@"" icon:icon userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[item,item1];
}
// 如果App是从快速入口启动的，则会执行这个方法。该方法的shortcutItem参数携带了从快速入口进入app时的标签参数。
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
      if ([shortcutItem.type isEqualToString:@"two"]) {
        NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
           }];
        }
      }
    if ([shortcutItem.type isEqualToString:@"one"]) {
        NSURL*url=[NSURL URLWithString:@"prefs:root=WIFI"];
       
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
            }];
        }
    }
}
- (BOOL) isMultitaskingSupported{

    BOOL result = NO;
    
    if ([[UIDevice currentDevice]
         respondsToSelector:@selector(isMultitaskingSupported)]){ result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    return result;
   
}
- (void)timerMethod:(NSTimer *)paramSender{
    
    count++;

    if (count % 500 == 0) {
  
        UIApplication *application = [UIApplication sharedApplication];

        //开启一个新的后台

        backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{

        }];
        //结束旧的后台任务
        
        [application endBackgroundTask:backgroundTaskIdentifier];
        
        oldBackgroundTaskIdentifier = backgroundTaskIdentifier;
        
    }
    
    //VVDLog(@"%ld",count);
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    if ([self isMultitaskingSupported] == NO){
    
        return; }
    
    //开启一个后台任务
    
    backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    
    oldBackgroundTaskIdentifier = backgroundTaskIdentifier;
    
    if ([self.myTimer isValid]) {
        
        [self.myTimer invalidate];
    }
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application

{
    
    if (backgroundTaskIdentifier != UIBackgroundTaskInvalid){
       
        [application endBackgroundTask:backgroundTaskIdentifier];
        
        if ([self.myTimer isValid]) {
            
            [self.myTimer invalidate];
            
        }

    }
}




- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
