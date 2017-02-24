//
//  PersonVc.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/12.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "PersonVC.h"
#import "FSJTopTableViewCell.h"
#import "FSJMineTableViewCell.h"
#import "FSJChangePersonInfoViewController.h"

@interface PersonVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PersonVC
static NSString *MineInfoTableViewCell = @"MineInfoViewCell";
static NSString *MineHeaderViewCell = @"MineHeaderViewCell";
- (void)viewWillAppear:(BOOL)animated{
    self.leftBtn.hidden = NO;
    self.navTitle.text = @"个人";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
}
- (void)createUI{
 
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.mytableView.scrollEnabled = YES;
    self.mytableView.bounces = NO;
    [self.mytableView registerNib:[UINib nibWithNibName:@"FSJTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineHeaderViewCell];
    [self.mytableView registerNib:[UINib nibWithNibName:@"FSJMineTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:MineInfoTableViewCell];
    [self.mytableView registerNib:[UINib nibWithNibName:@"FSJTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineHeaderViewCell];
    [self.mytableView registerNib:[UINib nibWithNibName:@"FSJMineTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:MineInfoTableViewCell];
    [self.view addSubview:self.mytableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    return 45;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    switch (sectionIndex) {
        case 0:
            return 1;
            break;
        case 1:
            return 7;
            break;
        case 2:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FSJTopTableViewCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:MineHeaderViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //[cell.BackBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        cell.BackImg.image = [UIImage imageNamed:@"fanhui"];
        [cell.BackBtn addTarget:self action:@selector(backTomain:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = ThemeColor;
        cell.BackBtn.tag = 600;
        cell.HeadBtn.layer.cornerRadius = 40;
        cell.HeadBtn.layer.masksToBounds = YES;
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgURL,userInfomodel.photo]];
        
        // [cell.HeadBtn setBackgroundImage:iconImg forState:UIControlStateNormal];
 //       [cell.HeadBtn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"yonghutouxiang.png"]];
        
        [cell.logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
        
        //NSLog(@"图片地址url == %@",url);
        [cell.HeadBtn addTarget:self action:@selector(changeIcon:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    NSArray* temp01 = @[@"用户名:",@"真实姓名:",@"工号:",@"手机号:",@"固话:",@"邮箱:",@"归属机构:"];
    //NSArray* temp02 = @[@"修改密码",@"兴趣站点",@"检查新版本"];
    FSJMineTableViewCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:MineInfoTableViewCell];
    cell.UserInfoIcon.contentMode = UIViewContentModeScaleAspectFit;
    cell.UserInfoname.font = [UIFont systemFontOfSize:14];
    cell.UserInfocontent.font = [UIFont systemFontOfSize:14];
    cell.checkLabel.hidden = YES;
    // NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    
    
    switch (indexPath.section) {
        case 1:
            cell.UserInfoname.text = temp01[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"yonghuming"];
                    cell.UserInfocontent.text = userInfomodel.loginName;
                    break;
                case 1:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"xingming"];
                    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
                    cell.UserInfocontent.text = userInfomodel.name;
                    break;
                case 2:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"gonghao"];
                    cell.UserInfocontent.text = userInfomodel.no;
                    break;
                case 3:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"shouji"];
                    cell.UserInfocontent.text = userInfomodel.mobile;
                    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 4:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"gudingdianhua"];
                    cell.UserInfocontent.text = userInfomodel.phone;
                    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 5:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"youxiang"];
                    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
                    cell.UserInfocontent.text = userInfomodel.email;
                    break;
                case 6:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"guishu"];
                    cell.UserInfocontent.text = userInfomodel.company;
                    break;
                default:
                    break;
            }
            break;
        case 2:
            //cell.UserInfoname.text = temp02[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"mima"];
                    cell.UserInfoname.text = @"修改密码";
                    cell.UserInfocontent.text = @"";
                    break;
                case 1:
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"xingqu"];
                    cell.UserInfoname.text = @"兴趣站点";
                    cell.UserInfocontent.text = @"";
                    break;
                case 2:
                    //                    if ([self.VersionStr isEqualToString: @""]) {
                    //                        [self.myTableView reloadData];
                    //                    }
                    //                    else{}
                    if ([self.appVersionStr integerValue] >=[self.VersionStr integerValue] ){
                        
                    }else{
                        cell.checkLabel.hidden = NO;
                        cell.checkLabel.text = @"发现新版本";
                    }
                    
                    cell.UserInfoIcon.image = [UIImage imageNamed:@"banben"];
                    cell.UserInfoname.text = @"检查新版本";
                    cell.UserInfocontent.text = @"";
                    break;
                    
                default:
                    break;
            }
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FSJChangePersonInfoViewController *vc = [[FSJChangePersonInfoViewController alloc]init];
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 ) {
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 6) {
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        vc.changeType = Username;
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        
        vc.changeType = Usermobile;
    }
    if (indexPath.section == 1 && indexPath.row == 4) {
        
        vc.changeType = Userphone;
    }
    if (indexPath.section == 1 && indexPath.row == 5) {
        
        vc.changeType = Useemail;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        vc.changeType = Userpwd;
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        //更新
//        [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 按钮响应
- (void)logout:(UIButton *)sender{
//    [[FSJUserInfo shareInstance]deleteUserAccount];
//    [[EGOCache globalCache]clearCache];
//    NSDictionary *dic = @{@"jwt":self.jwtStr};
//    NSLog(@"退出 %@",self.jwtStr);
//    [FSJNetworking networkingPOSTWithActionType:UserLogoutAction requestDictionary:dic success:^(NSURLSessionDataTask *operation, NSDictionary *responseObject) {
//        FSJCommonModel *model = [FSJCommonModel initWithDictionary:responseObject];
//        if ([model.status isEqualToString:@"200"]) {
//            
//            
//            //[[EGOCache globalCache]setObject:[NSNumber numberWithBool:NO] forKey:@"Login"];
//            
//            FSJLogInViewController *vc = [[FSJLogInViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//            //[SVProgressHUD showSuccessWithStatus:model.message];
//            
//        }
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        NSArray *array = error.userInfo.allValues;
//        NSHTTPURLResponse *response = array[0];
//        if (response.statusCode ==401 ) {
//           
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.618 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//                [[EGOCache globalCache]clearCache];
//                [[EGOCache globalCache]setObject:[NSNumber numberWithBool:NO] forKey:@"Login" withTimeoutInterval:0];
//            });
//        }
//    }];
}
- (void)changeIcon:(UIButton *)sender{
    UIActionSheet* mysheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相",@"从相册中选择", nil];
    
    mysheet.delegate = self;
    mysheet.frame = CGRectMake(0, self.view.frame.size.height-200, WIDTH, 200);
    [mysheet showInView:self.view];
}
- (void)backTomain:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
