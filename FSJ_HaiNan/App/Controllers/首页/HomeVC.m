//
//  HomeVC.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCell.h"
#import "BaseViewController.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated{
    self.leftBigBtn.hidden = NO;
    
    self.searchView.hidden = NO;
    self.rightBtn.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)initData{
    
    

}
-(void)createUI{
    //nav
    
    //tableview
    self.mytableView.delegate = self;
    self.mytableView.dataSource= self;
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mytableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeCell"];
    [self.view addSubview:self.mytableView];
    //注册
    
    UIButton *regBtn = [UIButton createButtonwithFrame:CGRectZero andTitle:@"注册" andTitleFont:12 andTitleColor:[UIColor blackColor] andBgColor:ThemeColor];
    [[regBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIStoryboard  *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [board instantiateViewControllerWithIdentifier:@"BaseViewController"];
        [self.navigationController pushViewController:vc animated:YES];
       
    }];
    
    regBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    regBtn.layer.cornerRadius = 30;
    regBtn.layer.masksToBounds = YES;
    [self.view insertSubview:regBtn aboveSubview:self.mytableView];
    
    
    [regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-65);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [HomeCell initWith:tableView];
    cell.selectedIndexBlock = ^(NSInteger index){
    
        VVDLog(@"%ld",index);
    };
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
