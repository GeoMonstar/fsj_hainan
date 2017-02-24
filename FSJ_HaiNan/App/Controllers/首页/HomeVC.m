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
@interface HomeVC ()<UISearchBarDelegate>{
    
    BOOL isDraggingDown;
}
@property (strong, nonatomic) NSMutableArray *lenovoTableArray;
@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated{
    self.leftBigBtn.hidden = NO;
    self.searchView.hidden = NO;
    self.mysearchBar.delegate = self;
    self.rightBtn.hidden = NO;
    [self initData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WeakSelf(weakself);
    self.mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDataWhenDraggingDown];
    }];
}
- (void)initData{
    [self.dataArray removeAllObjects];
    NSMutableArray *fsjIdArr = (NSMutableArray *)[[EGOCache globalCache]objectForKey:kfsjIdArr];
    if (fsjIdArr.count >0) {
       
        for (NSString *idStr in fsjIdArr) {
            OneFSJModel * model=   [OneFSJModel getOneFSJWithFsjID:idStr];
            if (model) {
                [self.dataArray addObject:model.bodyValueDic];
            }
        }
    }
     [self endRefreshing];
     [self.mytableView reloadData];
   
}
- (void) loadDataWhenDraggingDown {
    isDraggingDown = YES;
    [self initData];
}
// 触底加载数据的方法
- (void) loadDataWhenReachingBottom {
    isDraggingDown = NO;
    [self initData];
}
// 结束下拉或上拉刷新状态
- (void) endRefreshing {
    if (isDraggingDown) {
        [self.mytableView.mj_header endRefreshing];
    }
    else {
        [self.mytableView.mj_footer endRefreshing];
    }
}
- (void)createUI{
    //tableview
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mytableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeCell"];
    self.mytableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view insertSubview:self.mytableView belowSubview:self.navView];
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

#pragma mark -- searchbar
- (void)rightBtnClicked:(UIButton *)sender{
    self.mysearchBar.text = @"";
    [self initData];
    [self.mysearchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self initData];
    
    for (NSDictionary *dic in self.dataArray) {
        //设备名称和ip
        if ([[dic valueForKey:@"0200"] containsString:searchText] || [[dic valueForKey:@"2300"] containsString:searchText]) {
            [self.lenovoTableArray addObject:dic];
        }
    }
    self.dataArray =  [self.lenovoTableArray mutableCopy];
    [self.lenovoTableArray removeAllObjects];
    [self.mytableView reloadData];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;{
    
    if ([self.mysearchBar.text isEqualToString:@""]) {
        return;
    }
    else{
        for (NSDictionary *dic in self.dataArray) {
            if ([[dic valueForKey:@"0200"] containsString:searchBar.text] || [[dic valueForKey:@"2300"] containsString:searchBar.text]) {
                [self.lenovoTableArray addObject:dic];
            }
        }
        self.dataArray =  [self.lenovoTableArray mutableCopy];
        [self.lenovoTableArray removeAllObjects];
        [self.mytableView reloadData];
    }
    
    [self.mysearchBar resignFirstResponder];
    [self.view endEditing:YES];
    
}
#pragma mark -- tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [HomeCell initWith:tableView];
    cell.dataDic = self.dataArray[indexPath.section];
    cell.selectedIndexBlock = ^(NSInteger index){
        VVDLog(@"%ld",index);
    };
    return cell;
}
- (NSMutableArray *)lenovoTableArray{
    if (!_lenovoTableArray) {
        _lenovoTableArray = @[].mutableCopy;
    }
    return _lenovoTableArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
