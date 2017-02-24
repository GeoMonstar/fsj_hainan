//
//  HomeCell.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedIndexBlock) (NSInteger index);
@interface HomeCell : UITableViewCell
/**
 *  @brief 状态背景层 红色告警 绿色正常
 */
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
/**
 *  @brief 发射机名字
 */
@property (weak, nonatomic) IBOutlet UILabel *fsjNameLb;
/**
 *  @brief 发射功率
 */
@property (weak, nonatomic) IBOutlet UILabel *fasheLb;
/**
 *  @brief 驻波比
 */
@property (weak, nonatomic) IBOutlet UILabel *zbLb;
/**
 *  @brief 反射功率
 */
@property (weak, nonatomic) IBOutlet UILabel *fansheLb;
/**
 *  @brief 温度
 */
@property (weak, nonatomic) IBOutlet UILabel *wenduLb;
/**
 *  @brief 删除
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
/**
 *  @brief 修改
 */
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
/**
 *  @brief 开关
 */
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
/**
 *  @brief 告警
 */
@property (weak, nonatomic) IBOutlet UIButton *warnBtn;
/**
 *  @brief 按钮点击
 */
@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,copy)   SelectedIndexBlock selectedIndexBlock;
+ (HomeCell *)initWith:(UITableView *)tableView;
@end
