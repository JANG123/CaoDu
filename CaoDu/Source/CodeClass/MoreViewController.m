//
//  MoreViewController.m
//  CaoDu
//
//  Created by jang on 16/3/18.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MoreViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "HelpTableViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[UserAccount shareGetUserAccountDate].WaitingMoney addObserver:self forKeyPath:@"login" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.scrollEnabled = NO;
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setExtraCellLineHidden:self.tableView];
    
    [self drawButton];
}

-(void)drawButton{

    exitButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, 250/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    exitButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:7/255.0 alpha:1.0];
    if ([UserAccount UserName].length > 1) {
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }else{
        [exitButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    
    [self.tableView addSubview:exitButton];
    [exitButton.layer setMasksToBounds:YES];
    [exitButton.layer setCornerRadius:5.0];
    [exitButton addTarget:self action:@selector(exitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    self.navigationItem.title = @"更多";
    [self.view setBackgroundColor:Color_back];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
    if ([UserAccount UserName].length > 1) {
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }
}

-(void)exitButtonAction:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"登录"]) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [sender setTitle:@"登录" forState:UIControlStateNormal];
            [UserAccount deleteUserAccount];
            [[UserAccount shareGetUserAccountDate] setValue:@"" forKey:@"WaitingMoney"];
            [PasswordAccount needPasswordIsOn:NO];
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [UIView appearance].tintColor = Color_Alert;
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10/PxHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55/PxHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15/PxWidth, 14/PxHeight, 28/PxWidth, 28/PxWidth)];
    [logoImageView setImage:[UIImage imageNamed:[self tableCellImage:indexPath]]];
    [cell addSubview:logoImageView];
    
    UILabel *textLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame) + 10/PxWidth, CGRectGetMinY(logoImageView.frame), 100, CGRectGetHeight(logoImageView.frame))];
    textLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    textLable.font = [UIFont adapterFontOfSize:16.0];
    [cell addSubview:textLable];
    textLable.text = [self tableCellText:indexPath];
    if (indexPath.row != 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(NSString *)tableCellImage:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return @"iconfont-comment.png";
    }else if(indexPath.row == 1){
        return @"iconfont-attachment(3).png";
    }else if (indexPath.row == 2){
        return @"iconfont-attachment(34).png";
    }else if (indexPath.row == 3) {
        return @"iconfont-service.png";
    }
    return @"";
}

-(NSString *)tableCellText:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return @"意见反馈";
    }else if(indexPath.row == 1){
        return @"关于我们";
    }else if (indexPath.row == 2){
        return @"帮助中心";
    }else if (indexPath.row == 3) {
        return @"联系我们";
    }
    return @"";
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        FeedbackViewController *fv = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:fv animated:YES];
        
    }else if(indexPath.row == 1){
        AboutViewController *av = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:av animated:YES];
        
    }else if (indexPath.row == 2){
        HelpTableViewController *hv = [[HelpTableViewController alloc]init];
        [self.navigationController pushViewController:hv animated:YES];
    }else if (indexPath.row == 3) {        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否拨打客服电话" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_Phone]];
            });
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
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
