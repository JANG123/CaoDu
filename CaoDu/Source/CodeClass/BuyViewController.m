//
//  BuyViewController.m
//  CaoDu
//
//  Created by jang on 16/3/24.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()<UITextFieldDelegate>

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNavigation];
    [self drawView];
    [self p_data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawNavigation{
    self.navigationItem.title = @"项目详情";
    KFontColor_NavBlackColor
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"矩形-15-拷贝-6.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = Color_back;
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)p_data{
    titleLabel.text = _aGoodDetail.GoodsName;
    rateLabel.text = [NSString stringWithFormat:@"%@%%",_aGoodDetail.BorrowingRate];
    timeLabel.text = [NSString stringWithFormat:@"%@天",_aGoodDetail.TimelimitUrl];
}

-(void)drawView{

    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100/PxHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/PxWidth, 18/PxWidth, kScreenWidth/3, 20/PxHeight)];
    titleLabel.text = @"草场";
    titleLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    titleLabel.font = [UIFont adapterFontOfSize:16.0];
    [headView addSubview:titleLabel];
    
    UILabel *rate = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 16/PxHeight, kScreenWidth/3, 14/PxHeight)];
    rate.textAlignment = NSTextAlignmentCenter;
    rate.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    rate.font = [UIFont adapterFontOfSize:11.0];
    rate.text = @"年化收益";
    [headView addSubview:rate];
    rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(rate.frame) + 5/PxHeight, kScreenWidth/3, 20/PxHeight)];
    rateLabel.textAlignment = NSTextAlignmentCenter;
    rateLabel.textColor = [UIColor colorWithRed:255/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    rateLabel.font = [UIFont adapterFontOfSize:20.0];
    rateLabel.text = @"20%";
    [headView addSubview:rateLabel];
    
    UILabel *all = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, CGRectGetMaxY(titleLabel.frame) + 16/PxHeight, kScreenWidth/3, 14/PxHeight)];
    all.textAlignment = NSTextAlignmentCenter;
    all.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    all.font = [UIFont adapterFontOfSize:11.0];
    all.text = @"预计总收益";
    [headView addSubview:all];
    allLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, CGRectGetMaxY(rate.frame) + 5/PxHeight, kScreenWidth/3, 20/PxHeight)];
    allLabel.textAlignment = NSTextAlignmentCenter;
    allLabel.textColor = [UIColor colorWithRed:255/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    allLabel.font = [UIFont adapterFontOfSize:20.0];
    allLabel.text = @"0";
    [headView addSubview:allLabel];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, CGRectGetMaxY(titleLabel.frame) + 16/PxHeight, kScreenWidth/3, 14/PxHeight)];
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    time.font = [UIFont adapterFontOfSize:11.0];
    time.text = @"投资时长";
    [headView addSubview:time];
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, CGRectGetMaxY(rate.frame) + 5/PxHeight, kScreenWidth/3, 20/PxHeight)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor colorWithRed:255/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    timeLabel.font = [UIFont adapterFontOfSize:20.0];
    timeLabel.text = @"120天";
    [headView addSubview:timeLabel];
    
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame) + 10/PxHeight, kScreenWidth, 90/PxHeight)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    
    UILabel *moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(11/PxWidth, 0, 80/PxWidth, 45/PxHeight)];
    moneyLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    moneyLable.font = [UIFont adapterFontOfSize:14.0];
    moneyLable.text = @"投资金额:";
    [textView addSubview:moneyLable];
    moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLable.frame), 0, kScreenWidth - CGRectGetMaxX(moneyLable.frame), CGRectGetHeight(moneyLable.frame))];
    moneyTextField.textAlignment = NSTextAlignmentLeft;
    moneyTextField.font = [UIFont adapterFontOfSize:14.0];
    moneyTextField.backgroundColor = [UIColor clearColor];
    moneyTextField.delegate = self;
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextField.placeholder = @"起投金额500";
    [moneyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [textView addSubview:moneyTextField];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(moneyTextField.frame)-1, kScreenWidth, 1)];
    label.backgroundColor = Color_back;
    [textView addSubview:label];
    
    UILabel *pwLable = [[UILabel alloc]initWithFrame:CGRectMake(11/PxWidth, CGRectGetMaxY(moneyTextField.frame), 120/PxWidth, 45/PxHeight)];
    pwLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    pwLable.font = [UIFont adapterFontOfSize:14.0];
    pwLable.text = @"请输入支付密码:";
    [textView addSubview:pwLable];
    pwTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwLable.frame), CGRectGetMaxY(moneyTextField.frame), kScreenWidth - CGRectGetMaxX(pwLable.frame), CGRectGetHeight(pwLable.frame))];
    pwTextField.textAlignment = NSTextAlignmentLeft;
    pwTextField.font = [UIFont adapterFontOfSize:14.0];
    pwTextField.backgroundColor = [UIColor clearColor];
    pwTextField.delegate = self;
    pwTextField.secureTextEntry = YES;
    pwTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [textView addSubview:pwTextField];
    
    _buyButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(textView.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
        _buyButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_buyButton setTitle:@"我要投资" forState:UIControlStateNormal];
    [self.view addSubview:_buyButton];
    [_buyButton.layer setMasksToBounds:YES];
    [_buyButton.layer setCornerRadius:5.0];
    [_buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buyButtonAction:(UIButton *)sender{
    if (moneyTextField.text.length<1) {
        [self p_showAlertView:@"请输入金额" message:nil];
    }else if(pwTextField.text.length<1){
        [self p_showAlertView:@"请输入支付密码" message:nil];
    }else if([moneyTextField.text doubleValue] < 500){
        [self p_showAlertView:@"起投金额请大于500" message:nil];
    }else{
    [[InvestmentDataTolls shareGetInvestmentData]InvestmentWithRID:_aGoodDetail.RID Payment:moneyTextField.text AllProfit:allLabel.text Pwd:pwTextField.text ClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID PassValue:^(NSMutableArray *code) {
        if ([code[0] isEqualToString:@"0"]) {
            [self p_showAlertView:@"购买成功！" message:nil];
            moneyTextField.text = @"";
            pwTextField.text = @"";
        }else if([code[0] isEqualToString:@"39018"]) {
        [self p_showAlertView:@"余额不足！" message:@"请充值"];
        }else{
        [self p_showAlertView:@"购买失败！" message:@"请确认密码是否正确"];
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

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidChange:(id) sender {
    
    UITextField *field = (UITextField *)sender;
    double money = [field.text doubleValue] * [_aGoodDetail.BorrowingRate doubleValue]/100 *[_aGoodDetail.TimelimitUrl doubleValue];
    allLabel.text = [NSString stringWithFormat:@"%.2f",money/365];
    
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
