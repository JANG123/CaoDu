//
//  FogotViewController.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FogotViewController.h"
#import "FogotView.h"
@interface FogotViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)FogotView *fv;
@end

@implementation FogotViewController


-(void)loadView{
    self.fv = [[FogotView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _fv;
    [_fv.phoneText setTextFieldDelegate:self];
    [_fv.codeText setTextFieldDelegate:self];
    [_fv.passWordText setTextFieldDelegate:self];
    [_fv.confirmText setTextFieldDelegate:self];
    [_fv.nextButton addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self buildCountDown];
    //[self buildCountDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextButton:(UIButton *)sender{
    
    [[TelValiDateTolls shareGetTelValiDate]validateNumWithPhoneNum:[_fv.phoneText inputFieldText] PassValue:^(NSString *string) {
        if ([string isEqualToString:@"格式正确"]) {
            if ([_fv.passWordText inputFieldText].length < 6 || [_fv.passWordText inputFieldText].length > 18) {
                [self p_showAlertView:@"密码必须在6-18之间" message:nil];
            }else{
                if ([[_fv.passWordText inputFieldText] isEqualToString:[_fv.confirmText inputFieldText]]) {
                    if ([_fv.codeText inputFieldText].length == 0) {
                        [self p_showAlertView:@"验证码为空" message:nil];
                    }else if(![[_fv.codeText inputFieldText] isEqualToString:registCode]){
                        [self p_showAlertView:@"验证码错误" message:nil];
                    }else{
                        
                        [[LoginRegistDateTolls shareGetLoginRegistDate]ResetPasswordWith:[_fv.phoneText inputFieldText] PassWord:[_fv.passWordText inputFieldText] LoginRegistPassValue:^(NSString *code) {
                            if ([code isEqualToString:@"0"]) {
                               [self p_showAlertView:@"重置成功" message:nil];
                                LoginViewController *lv = [[LoginViewController alloc]init];
                                [self.navigationController pushViewController:lv animated:YES];
                            }else if([code isEqualToString:@"10016"]){
                            }
                        }];
                    }
                }else{
                    [self p_showAlertView:@"两次密码输入不相同" message:nil];
                }
            }
        }else{
            [self p_showAlertView:@"请输入正确手机号码" message:nil];
        }
    }];
}

-(void)drawNa{
    KFontColor_NavBlackColor
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"重置密码";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view setBackgroundColor:Color_back];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"back.png"]];
    [backButton addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backImage.frame) + 4, 0, CGRectGetWidth(backButton.frame) - CGRectGetMaxX(backImage.frame), 30)];
    backLabel.text = @"登录";
    backLabel.textColor = [UIColor colorWithRed:49/255.0 green:143/255.0 blue:43/255.0 alpha:1.0];
    [backButton addSubview:backLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}


-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

- (void)buildCountDown{
    
    _countDownCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(kScreenWidth - 103/PxWidth, 7/PxHeight, 90/PxWidth, 32/PxHeight);
    [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    _countDownCode.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    _countDownCode.backgroundColor = [UIColor colorWithRed:49/255.0 green:143/255.0 blue:43/255.0 alpha:1.0];
    [_fv.codeText addSubview:_countDownCode];
    
    [self addToucheHandler:^(UIButton*sender, NSInteger tag) {
        [[TelValiDateTolls shareGetTelValiDate]validateNumWithPhoneNum:[_fv.phoneText inputFieldText] PassValue:^(NSString *string) {
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
                
                [[TelValiDateTolls shareGetTelValiDate]telValiDataWithPhoneNum:[_fv.phoneText inputFieldText] PassValue:^(NSString *string) {
                    registCode = string;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
