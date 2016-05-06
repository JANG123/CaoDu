//
//  SettingTableViewController.m
//  CaoDu
//
//  Created by jang on 16/3/18.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "SettingTableViewController.h"
#import "ResetPasswordViewController.h"
#import "VerifyViewController.h"
#import "MoneyPasswordViewController.h"
@interface SettingTableViewController ()<UIAlertViewDelegate>

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self drawNa];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.scrollEnabled = NO;
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO ;
}


-(void)drawNa{
    self.navigationItem.title = @"设置";
    [self.view setBackgroundColor:Color_back];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"bai-back.png"]];
    [backButton addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backImage.frame) + 4, 0, CGRectGetWidth(backButton.frame) - CGRectGetMaxX(backImage.frame), 30)];
    backLabel.text = @"我的账户";
    backLabel.textColor = [UIColor whiteColor];
    [backButton addSubview:backLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3;
    }else if(section == 1){
        return 2;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self tableViewCellText:indexPath];
    cell.textLabel.font = [UIFont adapterFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.detailTextLabel.text = [UserAccount shareGetUserAccountDate].aUser.Tel;
        cell.detailTextLabel.font = [UIFont adapterFontOfSize:14.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1.0];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        cell.detailTextLabel.text = [UserAccount shareGetUserAccountDate].aUser.Name;
        cell.detailTextLabel.font = [UIFont adapterFontOfSize:14.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1.0];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 67/PxWidth, 5/PxHeight, 55/PxWidth, 35/PxHeight)];
        [switchButton setOn:[PasswordAccount isOnWithNeedPassword]];
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:switchButton];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)switchAction:(UISwitch *)sender{
    if (sender.on == YES) {
        GestureViewController *ges = [[GestureViewController alloc] initWithCaseMode:ResetMode];
        ges.isFormer = NO;
        ges.isLogin = NO;
//        [PasswordAccount needPasswordIsOn:NO];
        [self.navigationController pushViewController:ges animated:YES];
        
    }else{
        GestureViewController *ges = [[GestureViewController alloc] initWithCaseMode:VerifyMode];
        ges.isFormer = YES;
        ges.isLogin = NO;
        [self.navigationController pushViewController:ges animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           
        }else if(indexPath.row == 1){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你已经实名认证了" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [UIView appearance].tintColor = Color_Alert;
            [self presentViewController:alertController animated:YES completion:nil];
        }else if (indexPath.row == 2){
            ResetPasswordViewController *rpVC = [[ResetPasswordViewController alloc]init];
            [self.navigationController pushViewController:rpVC animated:YES];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
           
        }else{
            if ([PasswordAccount isOnWithNeedPassword]) {
                GestureViewController *ges = [[GestureViewController alloc] initWithCaseMode:VerifyMode];
                ges.isFormer = NO;
                ges.isLogin = NO;
                [self.navigationController pushViewController:ges animated:YES];
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未开启手势密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [UIView appearance].tintColor = Color_Alert;
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }
    }else{
        if (indexPath.row == 0) {
            VerifyViewController *vc = [[VerifyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            MoneyPasswordViewController *mv = [[MoneyPasswordViewController alloc]init];
            [self.navigationController pushViewController:mv animated:YES];
        }
    }
}


-(NSString *)tableViewCellText:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return @"账户名";
        }else if(indexPath.row == 1){
            return @"实名认证";
        }else if (indexPath.row == 2){
            return @"修改登录密码";
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return @"手势密码";
        }else{
            return @"修改手势密码";
        }
    }else{
        if (indexPath.row == 0) {
            return @"设置交易密码";
        }else{
            return @"找回交易密码";
        }
    }
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10/PxHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45/PxHeight;
}

-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
