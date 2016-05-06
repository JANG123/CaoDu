
//
//  RegisteredView.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "RegisteredView.h"

@implementation RegisteredView

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
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 225/PxHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    _phoneText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请输入手机号" imageName:@"loginphone.png" Interaction:YES];
    [backView addSubview:_phoneText];
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(45/PxWidth, 45/PxHeight, kScreenWidth - 45/PxWidth, 1)];
    phoneLabel.backgroundColor = Color_back;
    [_phoneText addSubview:phoneLabel];
    
    _codeText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_phoneText.frame), kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请输入短信验证码" imageName:@"code.png" Interaction:YES];
    [backView addSubview:_codeText];
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45/PxWidth, 45/PxHeight, kScreenWidth - 45/PxWidth, 1)];
    codeLabel.backgroundColor = Color_back;
    [_codeText addSubview:codeLabel];
    
    _passWordText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_codeText.frame), kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请设置6-16位数字、字母密码" imageName:@"loginpwd.png" Interaction:YES];
    _passWordText.typeTextField.secureTextEntry = YES;
    [backView addSubview:_passWordText];
    UILabel *passWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(45/PxWidth, 45/PxHeight, kScreenWidth - 45/PxWidth, 1)];
    passWordLabel.backgroundColor = Color_back;
    [_passWordText addSubview:passWordLabel];
    
    _confirmText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_passWordText.frame), kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请确认登录密码" imageName:@"loginpwd.png" Interaction:YES];
    _confirmText.typeTextField.secureTextEntry = YES;
    [backView addSubview:_confirmText];
    UILabel *confirmLabel = [[UILabel alloc]initWithFrame:CGRectMake(45/PxWidth, 45/PxHeight, kScreenWidth - 45/PxWidth, 1)];
    confirmLabel.backgroundColor = Color_back;
    [_confirmText addSubview:confirmLabel];
    
    _recomText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_confirmText.frame), kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请输入推荐码（选填）" imageName:@"icon_tjm.png" Interaction:YES];
    [backView addSubview:_recomText];
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_recomText.frame) + 30/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _nextButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_nextButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [self addSubview:_nextButton];
    [_nextButton.layer setMasksToBounds:YES];
    [_nextButton.layer setCornerRadius:5.0];
}


@end
