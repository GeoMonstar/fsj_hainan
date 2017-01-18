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
 * 导航层
 */
@property (nonatomic,strong)UIView *navView;
/**
 * 标题
 */
@property (nonatomic,strong)UILabel *navTitle;
/**
 * 搜索栏
 */
@property (nonatomic,strong)UISearchBar *mysearchBar;
/**
 * 返回键
 */
@property (nonatomic,strong)UIButton *leftBtn;
/**
 * 搜索层 
 */
@property (nonatomic,strong)UIView * searchView;
/**
 * 取消按钮
 */
@property (nonatomic,strong)UIButton *rightBtn;
/**
 * 个人
 */
@property (nonatomic,strong)UIButton *leftBigBtn;
/**
 * 基本tableview
 */
@property (nonatomic,strong)UITableView *mytableView;
/**
 * 基本dataArray
 */
@property (nonatomic,strong)NSMutableArray *dataArray;

- (void)createUI;
- (void)initData;
- (void)rightBtnClicked:(UIButton *)sender;
@end
