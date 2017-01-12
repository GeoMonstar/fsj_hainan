//
//  JQNagcAdapter.h
//  GospellLive
//
//  Created by Monstar on 16/7/9.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^EndBlock)();
@interface JQNagcAdapter : NSObject

@property (strong, nonatomic) UIWindow * window;
+(instancetype)shareInstance;
- (void)popNagcViewController:(UIViewController *)viewController Animation:(BOOL)animation;
- (void)disMissNagcViewController:(UIViewController *)viewController Animation:(BOOL)animation;

- (void)setRootViewControllerWithViewController:(UIViewController *)rootVC end:(EndBlock)endBlock;

@end
