//
//  AddBankViewController.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "AddBankViewController.h"

@interface AddBankViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton *nextButton;
@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawView];
    [self drawNa];
    [self buildCountDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawNa{
    self.navigationItem.title = @"添加银行卡";
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
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, 23/PxHeight, kScreenWidth/3*2, 18/PxHeight)];
    textLabel.text = @"请绑定持卡人本人的银行卡";
    textLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    textLabel.font = [UIFont adapterFontOfSize:14.0];
    [self.view addSubview:textLabel];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 45/PxHeight, kScreenWidth, 150/PxHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *bankNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, 0, 70/PxWidth, 50/PxHeight)];
    bankNameLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    bankNameLabel.font = [UIFont adapterFontOfSize:15.0];
    bankNameLabel.text = @"持卡人";
    [headView addSubview:bankNameLabel];
    
    NameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bankNameLabel.frame), CGRectGetMinY(bankNameLabel.frame), kScreenWidth - CGRectGetMaxX(bankNameLabel.frame), CGRectGetHeight(bankNameLabel.frame))];
    NameTextField.textAlignment = NSTextAlignmentLeft;
    NameTextField.font = [UIFont adapterFontOfSize:14.0];
    NameTextField.backgroundColor = [UIColor clearColor];
    NameTextField.delegate = self;
    NameTextField.placeholder = @"请输入持卡人姓名";
    [headView addSubview:NameTextField];

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(NameTextField.frame)-1, kScreenWidth, 1)];
    label.backgroundColor = Color_back;
    [headView addSubview:label];
    
    UILabel *bankNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(NameTextField.frame), 75/PxWidth, 50/PxHeight)];
    bankNumLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    bankNumLabel.font = [UIFont adapterFontOfSize:15.0];
    bankNumLabel.text = @"银行卡号";
    [headView addSubview:bankNumLabel];
    
    numTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bankNumLabel.frame), CGRectGetMinY(bankNumLabel.frame), kScreenWidth - CGRectGetMaxX(bankNumLabel.frame), CGRectGetHeight(bankNumLabel.frame))];
    numTextField.textAlignment = NSTextAlignmentLeft;
    numTextField.font = [UIFont adapterFontOfSize:14.0];
    numTextField.backgroundColor = [UIColor clearColor];
    numTextField.delegate = self;
    numTextField.placeholder = @"请输入银行卡号";
    [numTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [headView addSubview:numTextField];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(numTextField.frame)-1, kScreenWidth, 1)];
    label2.backgroundColor = Color_back;
    [headView addSubview:label2];
    
    UILabel *typeNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(numTextField.frame), 70/PxWidth, 50/PxHeight)];
    typeNumLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    typeNumLabel.font = [UIFont adapterFontOfSize:15.0];
    typeNumLabel.text = @"卡类型";
    [headView addSubview:typeNumLabel];
    
    typeTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeNumLabel.frame), CGRectGetMinY(typeNumLabel.frame), kScreenWidth - CGRectGetMaxX(typeNumLabel.frame), CGRectGetHeight(typeNumLabel.frame))];
    typeTextField.textAlignment = NSTextAlignmentLeft;
    typeTextField.font = [UIFont adapterFontOfSize:14.0];
    typeTextField.backgroundColor = [UIColor clearColor];
    typeTextField.delegate = self;
    typeTextField.userInteractionEnabled = NO;
    [headView addSubview:typeTextField];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame) + 10/PxHeight, kScreenWidth, 100/PxHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, 0, 70/PxWidth, 50/PxHeight)];
    telLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    telLabel.font = [UIFont adapterFontOfSize:15.0];
    telLabel.text = @"手机号";
    [view addSubview:telLabel];
    
    telTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(telLabel.frame), CGRectGetMinY(telLabel.frame), kScreenWidth - CGRectGetMaxX(telLabel.frame), CGRectGetHeight(telLabel.frame))];
    telTextField.textAlignment = NSTextAlignmentLeft;
    telTextField.font = [UIFont adapterFontOfSize:14.0];
    telTextField.backgroundColor = [UIColor clearColor];
    telTextField.delegate = self;
    telTextField.placeholder = @"请输入银行预留手机号";
    [view addSubview:telTextField];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(telTextField.frame)-1, kScreenWidth, 1)];
    label3.backgroundColor = Color_back;
    [view addSubview:label3];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(telTextField.frame), 70/PxWidth, 50/PxHeight)];
    codeLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    codeLabel.font = [UIFont adapterFontOfSize:15.0];
    codeLabel.text = @"验证码";
    [view addSubview:codeLabel];
    
    codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame), CGRectGetMinY(codeLabel.frame), kScreenWidth - CGRectGetMaxX(codeLabel.frame), CGRectGetHeight(codeLabel.frame))];
    codeTextField.textAlignment = NSTextAlignmentLeft;
    codeTextField.font = [UIFont adapterFontOfSize:14.0];
    codeTextField.backgroundColor = [UIColor clearColor];
    codeTextField.delegate = self;
    codeTextField.placeholder = @"请输入短信验证码";
    [view addSubview:codeTextField];
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(view.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _nextButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_nextButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:_nextButton];
    [_nextButton.layer setMasksToBounds:YES];
    [_nextButton.layer setCornerRadius:5.0];
    [_nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nextButton];
}

-(void)nextButtonAction:(UIButton *)sender{
    [[UserDataTolls shareGetUserData]MyBankAddJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID CarType:typeTextField.text CarNumber:numTextField.text BankID:@"" PassValue:^(NSMutableArray *code) {
        
    }];
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

- (void)buildCountDown{
    
    _countDownCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(CGRectGetWidth(codeTextField.frame) - 103/PxWidth, 7/PxHeight, 90/PxWidth, 32/PxHeight);
    [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    _countDownCode.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    _countDownCode.backgroundColor = [UIColor colorWithRed:49/255.0 green:143/255.0 blue:43/255.0 alpha:1.0];
    [codeTextField addSubview:_countDownCode];
    
    
    [self addToucheHandler:^(UIButton*sender, NSInteger tag) {
        [[TelValiDateTolls shareGetTelValiDate]validateNumWithPhoneNum:telTextField.text PassValue:^(NSString *string) {
            if ([string isEqualToString:@"格式正确"]) {
                
                sender.enabled = NO;
                
                [self startWithSecond:120];
                
                [self didChange:^NSString *(UIButton *countDownButton,int second) {
                    NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                    return title;
                }];
                [self didFinished:^NSString *(UIButton *countDownButton, int second) {
                    _countDownCode.enabled = YES;
                    return @"点击重新获取";
                    
                }];
                
                [[TelValiDateTolls shareGetTelValiDate]telValiDataWithPhoneNum:telTextField.text PassValue:^(NSString *string) {
                    code = string;
                }];
            }else{
                [self p_showAlertView:@"请输入正确手机号码" message:nil];
            }
        }];
    }];
    
}

-(void)addToucheHandler:(TouchedDownBlock)touchHandler{
    _touchedDownBlock = [touchHandler copy];
    [_countDownCode addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(UIButton*)sender{
    
    if (_touchedDownBlock) {
        _touchedDownBlock(sender,sender.tag);
    }
}

#pragma -mark count down method
-(void)startWithSecond:(int)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (int)(deltaTime+0.5) ;
    
    
    if (_second< 0.0)
    {
        [self stop];
    }
    else
    {
        if (_didChangeBlock)
        {
            [_countDownCode setTitle:_didChangeBlock(_countDownCode,_second) forState:UIControlStateNormal];
            [_countDownCode setTitle:_didChangeBlock(_countDownCode,_second) forState:UIControlStateDisabled];
            
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [_countDownCode setTitle:title forState:UIControlStateNormal];
            [_countDownCode setTitle:title forState:UIControlStateDisabled];
            
        }
    }
}

- (void)stop{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishedBlock)
                {
                    [_countDownCode setTitle:_didFinishedBlock(_countDownCode,_totalSecond)forState:UIControlStateNormal];
                    [_countDownCode setTitle:_didFinishedBlock(_countDownCode,_totalSecond)forState:UIControlStateDisabled];
                    
                }
                else
                {
                    [_countDownCode setTitle:@"重新获取" forState:UIControlStateNormal];
                    [_countDownCode setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}
#pragma -mark block
-(void)didChange:(DidChangeBlock)didChangeBlock{
    _didChangeBlock = [didChangeBlock copy];
}
-(void)didFinished:(DidFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}

- (void)textFieldDidChange:(id)sender {
    
    UITextField *field = (UITextField *)sender;
    [[UserDataTolls shareGetUserData]GetBankNameWithBankName:field.text PassValue:^(NSMutableArray *code) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",code[0]];
        if ([codeStr isEqualToString:@"接口访问出现异常"]) {
            
        }else if([codeStr isEqualToString:@"缺少参数BankName"]){
        
        }else if([codeStr isEqualToString:@"暂无所属发卡行信息"]){
        [self p_showAlertView:@"暂无所属发卡行信息" message:nil];
        }else{
            typeTextField.text = codeStr;
        }
    }];
    
    
    
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
