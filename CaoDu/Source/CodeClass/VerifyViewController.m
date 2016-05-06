//
//  VerifyViewController.m
//  CaoDu
//
//  Created by jang on 16/3/29.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "VerifyViewController.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawNa{
    self.navigationItem.title = @"验证账户";
    [self.view setBackgroundColor:Color_back];
    
    KFontColor_NavBlackColor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"矩形-15-拷贝-6.png"]];
    [backButton addSubview:backImage];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    //self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)drawView{
    
    passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 10/PxHeight, kScreenWidth, 45/PxHeight)];
    passWordTextField.placeholder = @"请输入登录密码";
    passWordTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    leftView.image = [UIImage imageNamed:@"loginpwd.png"];
    leftView.contentMode = UIViewContentModeCenter;
    passWordTextField.leftView = leftView;
    passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passWordTextField];
    
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(13/PxWidth, CGRectGetMaxY(passWordTextField.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight);
    nextButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:nextButton];
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setCornerRadius:5.0];
    [nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextButtonAction:(UIButton *)sender{
    if (passWordTextField.text.length == 0) {
        [self p_showAlertView:@"请输入登录密码！" message:@"确定"];
    }else if ([passWordTextField.text isEqualToString:[UserAccount PassWord]]) {
        
    }else{
        [self p_showAlertView:@"登录密码错误！" message:@"确定"];
    }
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
