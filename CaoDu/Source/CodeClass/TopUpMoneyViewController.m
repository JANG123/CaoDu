//
//  TopUpMoneyViewController.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "TopUpMoneyViewController.h"
#import "TopSucssViewController.h"
@interface TopUpMoneyViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton *nextButton;
@end

@implementation TopUpMoneyViewController

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
    self.navigationItem.title = @"充值";
    [self.view setBackgroundColor:Color_back];
    
    KFontColor_NavBlackColor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"btn_back.png"]];
    [backButton addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backImage.frame) + 4, 0, CGRectGetWidth(backButton.frame) - CGRectGetMaxX(backImage.frame), 30)];
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];;
    [backButton addSubview:backLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)drawView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 10/PxHeight, kScreenWidth, 110/PxHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *banktextLable = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, 25/PxHeight, 70/PxWidth, 20/PxHeight)];
    banktextLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    banktextLable.font = [UIFont adapterFontOfSize:15.0];
    banktextLable.text = @"储蓄卡";
    [headView addSubview:banktextLable];
    
    bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bankButton.frame = CGRectMake(CGRectGetMaxX(banktextLable.frame), 0, kScreenWidth - CGRectGetMaxX(banktextLable.frame), 65/PxHeight);
    
    bankLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bankButton.frame), 35/PxHeight)];
    bankLable.textColor = [UIColor colorWithRed:112/255.0 green:129/255.0 blue:158/255.0 alpha:1.0];
    bankLable.font = [UIFont adapterFontOfSize:16.0];
    bankLable.text = @"华夏银行（1111）";
    [bankButton addSubview:bankLable];
    
    bankLableNumLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(bankLable.frame), CGRectGetWidth(bankButton.frame), 20/PxHeight)];
    bankLableNumLable.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    bankLableNumLable.font = [UIFont adapterFontOfSize:14.0];
    bankLableNumLable.text = @"单日交易限额¥5000.00元";
    [bankButton addSubview:bankLableNumLable];

    [headView addSubview:bankButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(bankButton.frame)-1, kScreenWidth, 1)];
    label.backgroundColor = Color_back;
    [headView addSubview:label];

    UILabel *moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(bankButton.frame), CGRectGetMaxX(banktextLable.frame), 45/PxHeight)];
    moneyLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    moneyLable.font = [UIFont adapterFontOfSize:15.0];
    moneyLable.text = @"金额(元)";
    [headView addSubview:moneyLable];
    moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(bankButton.frame), CGRectGetMaxY(bankButton.frame), kScreenWidth - CGRectGetMaxX(moneyLable.frame), CGRectGetHeight(moneyLable.frame))];
    moneyTextField.textAlignment = NSTextAlignmentLeft;
    moneyTextField.font = [UIFont adapterFontOfSize:14.0];
    moneyTextField.backgroundColor = [UIColor clearColor];
    moneyTextField.delegate = self;
    moneyTextField.placeholder = @"请输入交易金额";
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [headView addSubview:moneyTextField];
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(headView.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _nextButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:_nextButton];
    [_nextButton.layer setMasksToBounds:YES];
    [_nextButton.layer setCornerRadius:5.0];
    [_nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextButtonAction:(UIButton *)sender{
    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
    payAlert.title = @"请输入支付密码";
    payAlert.detail = @"提现";
    payAlert.amount = [moneyTextField.text doubleValue];
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        [[UserDataTolls shareGetUserData]UserFundJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID UserPass:inputPwd Money:moneyTextField.text type:@"1" PassValue:^(NSMutableArray *code) {
            if ([code[0] isEqualToString:@"0"]) {
                moneyTextField.text = @"";
                TopSucssViewController *tc = [[TopSucssViewController alloc]init];
                [self.navigationController pushViewController:tc animated:YES];
            }else{
                [self p_showAlertView:@"充值失败！" message:@"请确认密码是否正确"];
            }
        }];
        
    };
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
