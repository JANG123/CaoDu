//
//  InfoCellView.m
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InfoCellView.h"

@implementation InfoCellView

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
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 95/PxWidth, 46/PxHeight)];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    _titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [self addSubview:_titleLabel];
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, 232/PxWidth, CGRectGetHeight(_titleLabel.frame))];
    _inputField.textAlignment = NSTextAlignmentLeft;
    _inputField.font = [UIFont adapterFontOfSize:14.0];
    _inputField.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_inputField.frame)-1, kScreenWidth, 1)];
    label.backgroundColor = Color_back;
    [self addSubview:label];
}

//初始化方法，显示的文字
-(instancetype)initWithFrame:(CGRect)frame titleText:(NSString *)titleText placeholder:(NSString *)placeholderText
{
    
    self = [self initWithFrame:frame];
    if (self) {
        _titleLabel.text = titleText;
        if (placeholderText != nil) {
            [self addSubview:_inputField];
            self.inputField.placeholder = placeholderText;
        }
    }
    return self;
}


//获取输入框的内容
- (NSString *)inputFieldText
{
    return _inputField.text;
}

-(void)outputFileText:(NSString *)text
{
    _inputField.text = text;
}

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate
{
    _inputField.delegate = fieldDelegate;
}

//textfield回收键盘
- (void)recyleKeyboard
{
    [_inputField resignFirstResponder];
}


@end

