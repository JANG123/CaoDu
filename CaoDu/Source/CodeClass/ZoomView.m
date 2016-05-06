//
//  ZoomView.m
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "ZoomView.h"

@implementation ZoomView

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

    _squareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 33/PxWidth, CGRectGetHeight(self.frame))];
    _squareLabel.text = @"◆";
    _squareLabel.textAlignment = NSTextAlignmentCenter;
    _squareLabel.textColor = [UIColor colorWithRed:230/255.0 green:125/255.0 blue:38/255.0 alpha:1.0];
    [self addSubview:_squareLabel];
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_squareLabel.frame), 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(_squareLabel.frame), CGRectGetHeight(_squareLabel.frame))];
    _textLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    _textLabel.font = [UIFont adapterFontOfSize:14.0];
    [self addSubview:_textLabel];
}

//初始化方法，显示的文字
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)textLable
{
    self = [self initWithFrame:frame];
    if (self) {
        _textLabel.text = textLable;
    }
    
    return self;
}

@end
