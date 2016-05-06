//
//  GoodNumTableViewCell.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GoodNumTableViewCell.h"

@implementation GoodNumTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    UIColor *fontColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];;
    _textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(18/PxWidth, 10/PxHeight, kScreenWidth/5, 20/PxHeight)];
    _textLabel1.textColor = fontColor;
    _textLabel1.font = [UIFont adapterFontOfSize:11.0];
    _textLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel1];
    _textLabel1.text = @"投标人";
    
    _textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textLabel1.frame), CGRectGetMinY(_textLabel1.frame), kScreenWidth/5, CGRectGetHeight(_textLabel1.frame))];
    _textLabel2.textColor = fontColor;
    _textLabel2.font = [UIFont adapterFontOfSize:11.0];
    _textLabel2.text = @"投标期限";
    _textLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel2];
    
    _textLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textLabel2.frame), CGRectGetMinY(_textLabel2.frame), kScreenWidth*0.3, CGRectGetHeight(_textLabel2.frame))];
    _textLabel3.textColor = fontColor;
    _textLabel3.font = [UIFont adapterFontOfSize:11.0];
    _textLabel3.text = @"投标期限";
    _textLabel3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel3];
    
    _textLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textLabel3.frame), CGRectGetMinY(_textLabel3.frame), kScreenWidth*0.3, CGRectGetHeight(_textLabel3.frame))];
    _textLabel4.textColor = fontColor;
    _textLabel4.font = [UIFont adapterFontOfSize:11.0];
    _textLabel4.text = @"投标期限";
    _textLabel4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel4];
}

@end
