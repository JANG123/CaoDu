//
//  ExtViewController.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "ExtViewController.h"
#import "ExtSussViewController.h"
@interface ExtViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton *nextButton;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UILabel *remainLabel;
@end

@implementation ExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNa];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)drawNa{
    self.navigationItem.title = @"提现";
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
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 10/PxHeight, kScreenWidth, 122/PxHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *banktextLable = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, 0, 100/PxWidth, 45/PxHeight)];
    banktextLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    banktextLable.font = [UIFont adapterFontOfSize:15.0];
    banktextLable.text = @"到账银行卡";
    [headView addSubview:banktextLable];
    
    bankButton = [UIButton buttonWithType:UIButtonTypeSystem];
    bankButton.frame = CGRectMake(CGRectGetMaxX(banktextLable.frame), 0, kScreenWidth - CGRectGetMaxX(banktextLable.frame), CGRectGetHeight(banktextLable.frame));
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bankButton.frame), CGRectGetHeight(bankButton.frame))];
    _textLabel.text = @"华夏银行（1111）";
    _textLabel.font = [UIFont adapterFontOfSize:15.0];
    _textLabel.textColor = [UIColor colorWithRed:112/255.0 green:129/255.0 blue:158/255.0 alpha:1.0];
    [bankButton addSubview:_textLabel];
    [bankButton addTarget:self action:@selector(bankButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:bankButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(bankButton.frame)-1, kScreenWidth, 1)];
    label.backgroundColor = Color_back;
    [headView addSubview:label];
    
    UILabel *moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(bankButton.frame), CGRectGetMaxX(banktextLable.frame), 45/PxHeight)];
    moneyLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    moneyLable.font = [UIFont adapterFontOfSize:15.0];
    moneyLable.text = @"提现金额";
    [headView addSubview:moneyLable];
    
    moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(bankButton.frame), CGRectGetMaxY(bankButton.frame), kScreenWidth - CGRectGetMaxX(moneyLable.frame), CGRectGetHeight(moneyLable.frame))];
    moneyTextField.textAlignment = NSTextAlignmentLeft;
    moneyTextField.font = [UIFont adapterFontOfSize:14.0];
    moneyTextField.backgroundColor = [UIColor clearColor];
    moneyTextField.delegate = self;
    moneyTextField.placeholder = @"请输入交易金额";
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [headView addSubview:moneyTextField];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(moneyTextField.frame)-1, kScreenWidth, 1)];
    label1.backgroundColor = Color_back;
    [headView addSubview:label1];
    
    UILabel *remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(moneyTextField.frame), 100/PxHeight, 30/PxHeight)];
    remainLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    remainLabel.font = [UIFont adapterFontOfSize:12.0];
    remainLabel.text = @"提现金额";
    [headView addSubview:remainLabel];
    
    UIButton *extButton = [UIButton buttonWithType:UIButtonTypeSystem];
    extButton.frame = CGRectMake(CGRectGetMaxX(remainLabel.frame), CGRectGetMaxY(moneyTextField.frame), kScreenWidth - CGRectGetMaxX(remainLabel.frame), CGRectGetHeight(remainLabel.frame));
    UILabel *extLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(extButton.frame), CGRectGetHeight(extButton.frame))];
    extLabel.text = @"全部提现";
    extLabel.font = [UIFont adapterFontOfSize:12.0];
    extLabel.textColor = [UIColor colorWithRed:112/255.0 green:129/255.0 blue:158/255.0 alpha:1.0];
    [extButton addSubview:extLabel];
    [extButton addTarget:self action:@selector(extButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:extButton];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), kScreenWidth, 30/PxHeight)];
    timeLabel.text = @"24：00前到账";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont adapterFontOfSize:12.0];
    timeLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self.view addSubview:timeLabel];

    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(headView.frame) + 30/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _nextButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_nextButton setTitle:@"提现" forState:UIControlStateNormal];
    [self.view addSubview:_nextButton];
    [_nextButton.layer setMasksToBounds:YES];
    [_nextButton.layer setCornerRadius:5.0];
    [_nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)extButtonAction:(UIButton *)sender{
    NSLog(@"222");
}

-(void)bankButtonAction:(UIButton *)sender{
    NSLog(@"111");
}

-(void)nextButtonAction:(UIButton *)sender{
    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
    payAlert.title = @"请输入支付密码";
    payAlert.detail = @"提现";
    payAlert.amount = [moneyTextField.text doubleValue];
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        [[UserDataTolls shareGetUserData]UserFundJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID UserPass:inputPwd Money:moneyTextField.text type:@"2" PassValue:^(NSMutableArray *code) {
            if ([code[0] isEqualToString:@"0"]) {
                moneyTextField.text = @"";
                ExtSussViewController *ec = [[ExtSussViewController alloc]init];
                [self.navigationController pushViewController:ec animated:YES];
            }else{
                [self p_showAlertView:@"提现失败！" message:@"请确认密码是否正确"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
