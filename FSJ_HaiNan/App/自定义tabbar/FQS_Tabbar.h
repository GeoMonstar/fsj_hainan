//
//  FQS_Tabbar.h
//  FQS_Tabbar
//
//  Created by yier on 15/2/25.
//  Copyright (c) 2015年 huiyict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FQS_TabbarBtn.h"

@class FQS_Tabbar;
@protocol FQS_TabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) tabBar:(FQS_Tabbar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface FQS_Tabbar : UIView

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSMutableDictionary * tabbarDic;
@property(nonatomic,weak) id<FQS_TabBarDelegate> delegate;
/**
 *  使用特定图片来创建按钮, 这样做的好处就是可扩展性. 拿到别的项目里面去也能换图片直接用
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
/**
 *  设置index跳转
 [[NSNotificationCenter defaultCenter] postNotificationName:@"selectTabbarWithIndex" object:nil userInfo:@{@"index":@(2)}];
 *
 */

- (void)tabbarclickBtn:(FQS_TabbarBtn *)button;
- (void)selectTabbarIndex:(NSInteger)selectedIndex;
- (void)initRedcircle:(NSArray *)redStateArray;
- (void)addButtonWithName:(NSString *)name image:(UIImage *)image selectedImage:(UIImage *)selectedImage selectIndex:(NSInteger )selectIndex tabbarNameColor:(UIColor *)tabbarNameColor;
@end
