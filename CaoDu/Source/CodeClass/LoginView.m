//
//  LoginView.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{

    _headBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250/PxHeight)];
    _headBackImage.image = [UIImage imageNamed:@"btn_backpress.png"];
    [self addSubview:_headBackImage];
    
    _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnButton.frame = CGRectMake(8/PxWidth, 30/PxHeight, 35/PxWidth, 35/PxWidth);
    [_returnButton setBackgroundImage:[UIImage imageNamed:@"矢量智能对象.png"] forState:UIControlStateNormal];
    [_headBackImage addSubview:_returnButton];
    
    _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 82/PxWidth)/2, 82/PxHeight, 85/PxWidth, 82/PxWidth)];
    _logoImage.image = [UIImage imageNamed:@"logo.png"];
    [_headBackImage addSubview:_logoImage];
    
    _textImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_logoImage.frame), CGRectGetMaxY(_logoImage.frame) + 15/PxHeight, CGRectGetWidth(_logoImage.frame), 39/PxHeight)];
    _textImage.image = [UIImage imageNamed:@"字体.png"];
    [_headBackImage addSubview:_textImage];
    

    _userNameTextFiel = [[TextTypeView alloc]initWithFrame:CGRectMake(12/PxWidth, CGRectGetMaxY(_headBackImage.frame) +18/PxHeight, kScreenWidth - 24/PxWidth, 45/PxHeight) placeholder:@"请输入您的手机号" imageName:@"loginphone.png" Interaction:YES];
    _userNameTextFiel.typeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_userNameTextFiel];
    
    _passWordTextFiel = [[TextTypeView alloc]initWithFrame:CGRectMake(12/PxWidth, CGRectGetMaxY(_userNameTextFiel.frame) + 10/PxHeight, kScreenWidth - 24/PxWidth, 45/PxHeight) placeholder:@"请输入您的登录密码" imageName:@"loginpwd.png" Interaction:YES];
    _passWordTextFiel.typeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextFiel.typeTextField.secureTextEntry = YES;
    [self addSubview:_passWordTextFiel];
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_passWordTextFiel.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _loginButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self addSubview:_loginButton];
    [_loginButton.layer setMasksToBounds:YES];
    [_loginButton.layer setCornerRadius:5.0];
    
    _registeredButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registeredButton.frame = CGRectMake(CGRectGetMinX(_loginButton.frame) - 10/PxWidth, CGRectGetMaxY(_loginButton.frame) + 20/PxHeight, 100/PxWidth, 45/PxHeight);
    [_registeredButton setTitle:@"免费注册" forState:UIControlStateNormal];
    [_registeredButton setTitleColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
    _registeredButton.titleLabel.font = [UIFont adapterFontOfSize:15.0];
    _registeredButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_registeredButton];
    
    _forgotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgotButton.frame = CGRectMake(CGRectGetMaxX(_loginButton.frame) - 90/PxWidth, CGRectGetMaxY(_loginButton.frame) + 20/PxHeight, 100/PxWidth, 45/PxHeight);
    [_forgotButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgotButton setTitleColor:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0] forState:UIControlStateNormal];
    _forgotButton.titleLabel.font = [UIFont adapterFontOfSize:16.0];
    [self addSubview:_forgotButton];
    
}

@end
