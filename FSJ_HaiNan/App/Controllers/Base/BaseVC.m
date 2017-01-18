//
//  BaseVC.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "BaseVC.h"
#import "PersonVC.h"


@interface BaseVC ()


@end

@implementation BaseVC
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
     [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
   
}

- (void)linkTicks:(CADisplayLink *)link{

}
- (void)createUI{
    
}
- (void)initData{

}
#pragma mark --定制导航栏
- (void)createNav{

    self.navigationController.navigationBar.hidden = YES;
    UIView *statusView = [UIView createViewwithFrame:CGRectMake(0, 0, WIDTH, 20) andColor:ThemeColor];
    [self.view addSubview:statusView];
    
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self rightBtnClicked:self.rightBtn];
    }];
    [[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self leftBtnClicked:self.leftBtn];
    }];
    [[self.leftBigBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self leftBigBtnClicked:self.leftBtn];
    }];
    [self.searchView addSubview:self.mysearchBar];
    //[self.navigationController.navigationBar addSubview:self.navView];
   
    [self.view addSubview:self.navView];
    [self.view addSubview:self.navTitle];
    [self.navView addSubview:self.leftBigBtn];
    [self.navView addSubview:self.leftBtn];
    [self.navView addSubview:self.rightBtn];
    [self.navView addSubview:self.searchView];
    
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.navView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(35);

    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.navView.mas_leading).offset(12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(15);
        make.centerY.equalTo(self.navView.mas_centerY);
    }];

    [self.leftBigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.navView.mas_leading).offset(7);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(self.navView.mas_centerY);
    }];

    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.navView.mas_trailing).offset(-5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(self.navView.mas_centerY);
    }];

    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftBigBtn.mas_trailing).offset(5);
        make.trailing.equalTo(self.rightBtn.mas_leading).offset(0);
        make.height.mas_equalTo(35);
        make.centerY.equalTo(self.navView.mas_centerY);
    }];
    [self.mysearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(self.searchView);
    }];
    
    self.leftBigBtn.hidden = YES;
    self.searchView.hidden = YES;
    self.rightBtn.hidden = YES;
    self.leftBtn.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)leftBigBtnClicked:(UIButton *)sender{
    VVDLog(@"个人");
    PersonVC *vc = [[PersonVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)leftBtnClicked:(UIButton *)sender{
     VVDLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark -- getter
- (UIButton *)leftBigBtn{
    if (!_leftBigBtn) {
        _leftBigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBigBtn setImage:[UIImage imageNamed:@"geren"] forState:UIControlStateNormal];
    }
    return _leftBigBtn;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _rightBtn;
}
- (UISearchBar *)mysearchBar{
    if (!_mysearchBar) {
        _mysearchBar = [[UISearchBar alloc]init];
      
        _mysearchBar.placeholder = Placeholder;
        _mysearchBar.backgroundColor = [UIColor clearColor];
        _mysearchBar.searchBarStyle =UISearchBarStyleDefault;
        _mysearchBar.barTintColor = [UIColor whiteColor];
        [_mysearchBar setBackgroundImage:[UIImage imageWithColor:WhiteColor]];
        _mysearchBar.layer.borderColor = ThemeColor.CGColor;
        _mysearchBar.layer.borderWidth = 0;
        _mysearchBar.layer.cornerRadius = 17.5;
        _mysearchBar.layer.masksToBounds = YES;
        _mysearchBar.barStyle =UIBarStyleBlack;
        _mysearchBar.showsCancelButton = NO;
        for (UIView* view in _mysearchBar.subviews)
        {
            for (UIView *v in view.subviews) {
                if ( [v isKindOfClass: [UITextField class]] )
                {
                    UITextField *tf = (UITextField *)v;
                    tf.clearButtonMode = UITextFieldViewModeNever;
                }
            }
        }
    }
    return _mysearchBar;
}
- (UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc]init];
        _searchView.backgroundColor = [UIColor clearColor];
    }
    return _searchView;
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
        _navView.backgroundColor =ThemeColor;
    }
    return _navView;
}
- (UITableView *)mytableView{
    if (!_mytableView) {
        _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGTH) style:UITableViewStyleGrouped];
        
    }
    return _mytableView;
}
- (UILabel *)navTitle{
    if (!_navTitle) {
        _navTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _navTitle.textColor = WhiteColor;
        _navTitle.font = [UIFont systemFontOfSize:20];
        _navTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _navTitle;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
@end
