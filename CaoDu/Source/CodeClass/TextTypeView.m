//
//  TextTypeView.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "TextTypeView.h"

@implementation TextTypeView


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
    _typeTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_typeTextField];
}

//初始化方法，显示的文字
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)textLable imageName:(NSString *)imageName Interaction:(BOOL)interaction{
    self = [self initWithFrame:frame];
    if (self) {
        _typeTextField.placeholder = textLable;
        UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        leftView.image = [UIImage imageNamed:imageName];
        leftView.contentMode = UIViewContentModeCenter;
        _typeTextField.leftView = leftView;
        _typeTextField.leftViewMode = UITextFieldViewModeAlways;
        _typeTextField.userInteractionEnabled = interaction;

    }
    return self;
}

//获取输入框的内容
- (NSString *)inputFieldText
{
    return _typeTextField.text;
}

-(void)outputFileText:(NSString *)text
{
    _typeTextField.text = text;
}

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate
{
    _typeTextField.delegate = fieldDelegate;
}

//textfield回收键盘
- (void)recyleKeyboard
{
    [_typeTextField resignFirstResponder];
}


@end
