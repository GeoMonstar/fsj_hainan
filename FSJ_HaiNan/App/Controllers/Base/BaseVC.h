//
//  BaseVC.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "ViewController.h"

@interface BaseVC : UIViewController
/**
 *  @brief 导航层
 */
@property (nonatomic,strong)UIView *navView;
/**
 *  @brief 标题
 */
@property (nonatomic,strong)UILabel *navTitle;
/**
 *  @brief 搜索栏
 */
@property (nonatomic,strong)UISearchBar *mysearchBar;
/**
 *  @brief 返回键
 */
@property (nonatomic,strong)UIButton *leftBtn;
/**
 *  @brief 搜索层
 */
@property (nonatomic,strong)UIView * searchView;
/**
 *  @brief 取消按钮
 */
@property (nonatomic,strong)UIButton *rightBtn;
/**
 *  @brief 个人
 */
@property (nonatomic,strong)UIButton *leftBigBtn;
///**
// *  @brief 状态
// */
//@property (nonatomic,strong)UIView *statusView;
/**
 *  @brief 基本tableview
 */
@property (nonatomic,strong)UITableView *mytableView;
/**
 *  @brief 基本dataArray
 */
@property (nonatomic,strong)NSMutableArray *dataArray;

- (void)createUI;
- (void)rightBtnClicked:(UIButton *)sender;
@end
