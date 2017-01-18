//
//  HomeCell.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)drawRect:(CGRect)rect{
   
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.statusView.layer.cornerRadius = 5;
    self.statusView.layer.masksToBounds = YES;
    //根据tag判断
    self.changeBtn.tag = 501;
    self.startBtn.tag =502;
    self.warnBtn.tag = 503;
    self.deleteBtn.tag =504;
    [self changeBtn:self.changeBtn];
    [self changeBtn:self.startBtn];
    [self changeBtn:self.warnBtn];
    [self changeBtn:self.deleteBtn];
    
}
- (void)setDataDic:(NSDictionary *)dataDic{
    self.fsjNameLb.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:[@"0x0002" ReverseStr]]];
    self.fansheLb.text = [NSString stringWithFormat:@"发射功率:%@W",[dataDic objectForKey:[@"0x000A" ReverseStr]]];
    self.fasheLb.text = [NSString stringWithFormat:@"反射功率:%@W",[dataDic objectForKey:[@"0x0202" ReverseStr]]];
    self.zbLb.text = [NSString stringWithFormat:@"驻波比:%@",[dataDic objectForKey:[@"0x0205" ReverseStr]]];
    self.wenduLb.text = [NSString stringWithFormat:@"温度:%@°C",[dataDic objectForKey:[@"0x0207" ReverseStr]]];
//    self.fsjNameLb.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"0x0002"]];
//    self.fansheLb.text = [NSString stringWithFormat:@"发射功率:%@W",[dataDic objectForKey:@"0x000A"]];
//    self.fasheLb.text = [NSString stringWithFormat:@"反射功率:%@W",[dataDic objectForKey:@"0x0202" ]];
//    self.zbLb.text = [NSString stringWithFormat:@"驻波比:%@",[dataDic objectForKey:@"0x0205"]];
//    self.wenduLb.text = [NSString stringWithFormat:@"温度:%@°C",[dataDic objectForKey:@"0x0207"]];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
  
}
- (void)changeBtn:(UIButton *)btn{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.selectedIndexBlock) {
            self.selectedIndexBlock(btn.tag-500);
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (HomeCell *)initWith:(UITableView *)tableView{
    static NSString *ID = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;


}
@end
