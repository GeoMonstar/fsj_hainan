//
//  Config.h
//  GospellLive
//
//  Created by Monstar on 16/7/9.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#ifndef Config_h
#define Config_h

/**
 *
 *配置Tabbar上的ViewController为加载网页还是原生,有web的为网页，没有为原生
 */

#define TabbarVCArray @[@"HomeVC",@"JiankongVC",@"TongjiVC",@"RizhiVC"]

//#define TabbarVCArray @[@"HomeWeb",@"CommunityWeb",@"ServerWeb",@"ShopCartWeb",@"MyselfWeb"]

/**
 *  App Info
 */

#define App_VersionKey (NSString *)kCFBundleVersionKey

#define App_ID        @""
#define App_Store_URL @""

#define App_Name    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define APP_Identifier (NSString *)kCFBundleIdentifierKey
//取出上次使用的版本号
#define App_LastVersionCode [[NSUserDefaults standardUserDefaults] objectForKey:App_VersionKey]
//加载程序中的info.plist
#define App_CurrentVersionCode [NSBundle mainBundle].infoDictionary[App_VersionKey]
//这是真实的版本号，AppStore使用
#define App_BuildleVersion   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
//这是用户看到的版本号
#define APP_ShortBuildleVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

/**
 *  Persistence Directory
 *
 *  @return 系统的Directory路径
 */

#define Document_Directoty NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
//#define Document_Directoty NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

/**
 *  FMDB
 *
 *  FMDB_PATH 数据库存储路径
 *
 *  FMDBLogLastError 数据库打印错误
 */

#define FMDB_Path [NSString stringWithFormat:@"%@/%@.db", Document_Directoty, App_Name]
#define FMDB_Path_User [NSString stringWithFormat:@"%@/%@.db", Document_Directoty, @"User"]
//#define FMDB_Path [NSString stringWithFormat:@"%@/%@.db", @"/Users/yier/Documents/新东网项目/FMDB测试", App_Name]
#define FMDBLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

/**
 *  SSKeychain
 */

#define SSServer_Name  @"com.FSJHaiNan.www"
#define SSLogin        @"SSLogin"
#define SSPassword     @"SSPassword"
#define SSAccess_Token @"SSAccess_Token"



/**
 *  Notification
 */

#define kAppUserAccount         @"AppUserAccount"
#define kAPPUserID              @"APPUserID"
#define kAppUserPassKey         @"AppUserPassKey"
#define kAppUserInfo            @"AppUserInfo"
#define kNotificationWithLogout @"NotificationWithLogout"
#define kNotificationWithLogin  @"NotificationWithLogin"
#define kNotificatioTcpConnect  @"NotificatioTcpConnect"

/**************Cache**************/
#define kHomedata    @"kHomedata"
#define kHomelunbo   @"kHomelunbo"
#define kDianboData  @"kDianboData"
#define kJsonArr     @"kJsonArr"
#define kMapDic      @"kMapDic"
#define kfsjIdArr      @"kfsjIdArr"
/**************Class**************/
#define Placeholder @"请输入发射机名称或IP"
#endif /* Config_h */
