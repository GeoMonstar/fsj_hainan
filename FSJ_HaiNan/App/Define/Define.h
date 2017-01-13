//
//  Define.h
//  GospellLive
//
//  Created by Monstar on 16/7/9.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#ifndef Define_h
#define Define_h

typedef NS_ENUM(NSInteger,ViewControllerTransitionType){
    push,
    present,
};
//汉字
#define AccountChanged @"该用户已在其他设备登录"
//属性
#define __KPropertyString(key) @property(nonatomic,copy)NSString *key;

//weakSelf宏
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type


#define ScreenProportion Screen.width/320.0
#define Screen  [UIScreen mainScreen].bounds.size
#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGTH  [UIScreen mainScreen].bounds.size.height
/***********尺寸宏***********/
#define CGRM(_X,_Y,_W,_H) CGRectMake(_X * ([UIScreen mainScreen].bounds.size.width / 375.0), _Y * ([UIScreen mainScreen].bounds.size.height / 667.0), _W * ([UIScreen mainScreen].bounds.size.width / 375.0), _H * ([UIScreen mainScreen].bounds.size.height / 667.0))
#define CGRMSizeMake(_W,_H) CGSizeMake(_W * ([UIScreen mainScreen].bounds.size.width / 375.0), _H * ([UIScreen mainScreen].bounds.size.height / 667.0))
/**
 判断系统
 *
 **/
#define CurrentVersion [[UIDevice currentDevice].systemVersion doubleValue]
#define isIOS7 currentVersion>=7.0 && currentVersion <8.0
#define isIOS8 currentVersion>=8.0 && currentVersion <9.0

/**
 判断手机
 *
 **/
#define isIphone_5 Screen.height == 568
#define isIphone_4 Screen.height == 480
#define isIphone_6 Screen.height == 667
#define isIphone_6plus Screen.height == 736
#define isIphone [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define isIpad    [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad

/***********根据路径加载图片***********/
#define IMAGE_WITH_NAME(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:name]]
/***********颜色宏***********/
#define   SetColor(R,G,B,P) [UIColor colorWithRed:(CGFloat)(R/255.0) green:(CGFloat)(G/255.0) blue:(CGFloat)(B/255.0) alpha:P]
#define SetHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//主题色
#define ThemeColor SetColor(53, 166, 187, 1)

#define WhiteColor [UIColor whiteColor]

#define Lightgray SetColor(196, 197, 197, 1)
//蓝色按钮
#define BlueButton SetColor(54, 197, 252, 1)

/***********int转string***********/
#define IntToString(_int) _int = [NSString stringWithFormat:@"%d",[_int intValue]]
/***********NULL转nil***********/
#define NULL_NIL(_str)  [_str isEqual:[NSNull null]] ? @"":_str

/***********imageUrl是否为空l***********/
#define IsImageStr(imageStr) [imageStr isEqualToString:@""] || [imageStr isEqualToString:@"<null>"] || imageStr == nil
/***********默认的没有图片***********/
#define DefaultImage [UIImage imageNamed:@"noPicture"]
#define Default_Header [UIImage imageNamed:@"default_head.png"]
#define UploadDefaultImage [UIImage imageNamed:@"server_add.png"]

/***********CGRectGetHeight***********/
#define CGGetH(Frame)  CGRectGetHeight(Frame)
/***********CGRectGetWidth***********/
#define CGGetW(Frame) CGRectGetWidth(Frame)


/**************显示对话框*****************/
#define ShowAlert(message)  DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示！" contentText:message leftButtonTitle:nil    rightButtonTitle:@"知道了"];[alertView show];
#define ShowDescription  NSString * showStr = [NSString stringWithFormat:@"%@",finishedTure[@"description"]];ShowAlert(showStr);
#define ShowNetError    ShowAlert(@"网络错误");


// 日志输出
#ifdef DEBUG
#define VVDLog(format, ...) NSLog((@"\n[函数名:%s]" "[行号:%d]  \n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define VVDLog(format, ...);
#endif



//检测是否包含中文
#define IS_CH_SYMBOL(chr) ((int)(chr)>127)
/* Pod */
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

#import <MJRefresh/MJRefresh.h>

#import "ReactiveCocoa.h"
#import <YYModel/YYModel.h>
#import "SSKeychain.h"

#import <FMDB/FMDB.h>
#import <SQLCipher/sqlite3.h>
#import "EGOCache.h"
#import "MJExtension.h"
#import <Masonry/Masonry.h>


/* Tool */



/* Class */
#import "FMDBConstants.h"
#import "Constants.h"
#import "JQNagcAdapter.h"
#import "ParametersList.h"
/* Category */
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "MBProgressHUD+HUDTools.h"
#import "UIImage+Color.h"
#import "SSKeychain+Helper.h"
#import "FMEncryptDatabaseQueue+Helper.h"
#import "UIView+JQcreateView.h"
#import "UILabel+JQcreateLabel.h"
#import "UIButton+JQcreateButton.h"
#endif /* Define_h */
