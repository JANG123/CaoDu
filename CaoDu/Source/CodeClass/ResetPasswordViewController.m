//
//  ResetPasswordViewController.m
//  CaoDu
//
//  Created by jang on 16/3/18.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *qhoneTextFiel;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFiel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiel;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self drawNa];
    [self drawTextFiel];
    [self buildCountDown];
}

-(void)drawNa{
    self.navigationItem.title = @"找回密码";
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

-(void)drawTextFiel{
    [self setRightViewWithTextField:_qhoneTextFiel imageName:@"loginphone.png"];
    _qhoneTextFiel.userInteractionEnabled = NO;
    _qhoneTextFiel.placeholder = [UserAccount shareGetUserAccountDate].aUser.Tel;
    [self setRightViewWithTextField:_passWordTextFiel imageName:@"loginpwd.png"];
    _passWordTextFiel.placeholder = @"请设置新密码";
    _passWordTextFiel.delegate = self;
    [self setRightViewWithTextField:_codeTextFiel imageName:@"iconfont-yanzhengma.png"];
    _codeTextFiel.placeholder = @"请输入短信验证码";
    _codeTextFiel.delegate = self;
}

-(void)setRightViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName{
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 13, 22, 22)];
    leftView.image = [UIImage imageNamed:imageName];
    leftView.contentMode = UIViewContentModeCenter;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetPassWordAction:(id)sender {
    if (_passWordTextFiel.text.length < 6) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"新密码请大于6位" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [UIView appearance].tintColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
        [alertView show];
    }else if (![_codeTextFiel.text isEqualToString:registCode]){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"验证码错误！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [UIView appearance].tintColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
        [alertView show];
    }else{
        [[LoginRegistDateTolls shareGetLoginRegistDate]ResetPasswordWith:[UserAccount shareGetUserAccountDate].aUser.Tel PassWord:_passWordTextFiel.text LoginRegistPassValue:^(NSString *code) {
            if ([code isEqualToString:@"0"]) {
                [UserAccount SetUserAccout:[UserAccount shareGetUserAccountDate].aUser.Tel PassWord:_passWordTextFiel.text];
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"修改成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [UIView appearance].tintColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
                [alertView show];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"请重试" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [UIView appearance].tintColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
                [alertView show];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)buildCountDown{
    
    _countDownCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(kScreenWidth - 123/PxWidth, 7/PxHeight, 90/PxWidth, 32/PxHeight);
    [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    _countDownCode.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    _countDownCode.backgroundColor = [UIColor colorWithRed:49/255.0 green:143/255.0 blue:43/255.0 alpha:1.0];
    [_codeTextFiel addSubview:_countDownCode];
    
    
    [self addToucheHandler:^(UIButton*sender, NSInteger tag) {
                
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
        
        [[TelValiDateTolls shareGetTelValiDate]telValiDataWithPhoneNum:[UserAccount shareGetUserAccountDate].aUser.Tel PassValue:^(NSString *string) {
            registCode = string;
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
