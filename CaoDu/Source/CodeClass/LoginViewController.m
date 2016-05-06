//
//  LoginViewController.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisteredViewController.h"
#import "FogotViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)LoginView *lv;
@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation LoginViewController

-(void)loadView{
    self.lv = [[LoginView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _lv;
    
    [_lv.userNameTextFiel setTextFieldDelegate:self];
    [_lv.passWordTextFiel setTextFieldDelegate:self];
    
    [_lv.returnButton addTarget:self action:@selector(returnButton:) forControlEvents:UIControlEventTouchUpInside];
    _lv.headBackImage.userInteractionEnabled = YES;
    [_lv.loginButton addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_lv.registeredButton addTarget:self action:@selector(registeredButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_lv.forgotButton addTarget:self action:@selector(forgotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnButton:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loginButton:(UIButton *)sender{
    [self p_setupProgressHud];
    if ([_lv.userNameTextFiel inputFieldText].length >0 &&[_lv.passWordTextFiel inputFieldText].length >0) {
        [[LoginRegistDateTolls shareGetLoginRegistDate]LoginWithTel:[_lv.userNameTextFiel inputFieldText] PassWord:[_lv.passWordTextFiel inputFieldText] LoginRegistPassValue:^(NSString *code) {
            
            if ([code isEqualToString:@"0"]) {
                [UserAccount SetUserAccout:[_lv.userNameTextFiel inputFieldText] PassWord:[_lv.passWordTextFiel inputFieldText]];
//                MainTabController *mainTC = [[MainTabController alloc]init];
//                [self.navigationController pushViewController:mainTC animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
                self.hud.hidden = YES;
                
            }else if([code isEqualToString:@"1001"]){
                [self p_showAlertView:@"密码错误" message:nil];
                self.hud.hidden = YES;
            }else if([code isEqualToString:@"1000"]){
                [self p_showAlertView:@"用户不存在" message:nil];
                self.hud.hidden = YES;
            }else if([code isEqualToString:@"500"]){
                [self p_showAlertView:@"登录出错，请重试" message:nil];
                self.hud.hidden = YES;
            }else{
                [self p_showAlertView:@"登录出错，请重试" message:nil];
                self.hud.hidden = YES;
            }
        }];
    }
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [UIView appearance].tintColor = Color_Alert;
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)registeredButtonAction:(UIButton *)sender{
    RegisteredViewController *rv = [[RegisteredViewController alloc]init];
    [self.navigationController pushViewController:rv animated:YES];
}

-(void)forgotButtonAction:(UIButton *)sender{
    FogotViewController *fv = [[FogotViewController alloc]init];
    [self.navigationController pushViewController:fv animated:YES];
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
