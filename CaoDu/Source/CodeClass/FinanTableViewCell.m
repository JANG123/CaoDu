//
//  FinanTableViewCell.m
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FinanTableViewCell.h"

@implementation FinanTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
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
    _inputField.layer.borderColor = [UIColor clearColor].CGColor;
    _inputField.userInteractionEnabled = YES;
}

//初始化方法，显示的文字
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier titleText:(NSString *)titleText placeholder:(NSString *)placeholderText
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
        _titleLabel.text = titleText;
        if (placeholderText != nil) {
            self.inputField.placeholder = placeholderText;
            [self addSubview:_inputField];
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
