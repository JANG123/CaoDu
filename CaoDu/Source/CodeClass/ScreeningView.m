//
//  ScreeningView.m
//  CaoDu
//
//  Created by jang on 16/3/28.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "ScreeningView.h"

@implementation ScreeningView

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
    self.backgroundColor = Color_back;
    UIColor *textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35/PxHeight)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"筛选";
    _titleLabel.textColor = textColor;
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont adapterFontOfSize:15.0];
    [self addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10/PxWidth, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), 25/PxHeight)];
    _dateLabel.text = @"时间";
    _dateLabel.textColor = textColor;
    _dateLabel.font = [UIFont adapterFontOfSize:15.0];
    [self addSubview:_dateLabel];
    
    _starTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _starTimeButton.frame = CGRectMake(0, CGRectGetMaxY(_dateLabel.frame), CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame));
    _starTimeButton.backgroundColor = [UIColor whiteColor];
    _starTimeButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_starTimeButton];
    
    _starTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_dateLabel.frame), 0, kScreenWidth/2, CGRectGetHeight(_starTimeButton.frame))];
    _starTimeLabel.text = @"--请选择开始时间--";
    _starTimeLabel.textColor = textColor;
    _starTimeLabel.font = [UIFont adapterFontOfSize:15.0];
    [_starTimeButton addSubview:_starTimeLabel];
    
    _starTimeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30/PxWidth, 14/PxHeight, 15/PxWidth, 8/PxHeight)];
    _starTimeImage.image = [UIImage imageNamed:@"下拉箭头.png"];
    [_starTimeButton addSubview:_starTimeImage];
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_starTimeButton.frame) - 1, kScreenWidth, 1)];
    lineLable.backgroundColor = Color_back;
    [_starTimeButton addSubview:lineLable];
    
    _endTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _endTimeButton.frame = CGRectMake(0, CGRectGetMaxY(_starTimeButton.frame), CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_starTimeButton.frame));
    _endTimeButton.backgroundColor = [UIColor whiteColor];
    _endTimeButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_endTimeButton];
    
    _endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_dateLabel.frame), 0, kScreenWidth/2, CGRectGetHeight(_endTimeButton.frame))];
    _endTimeLabel.text = @"--请选择结束时间--";
    _endTimeLabel.textColor = textColor;
    _endTimeLabel.font = [UIFont adapterFontOfSize:15.0];
    [_endTimeButton addSubview:_endTimeLabel];
    
    _endTimeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30/PxWidth, 14/PxHeight, 15/PxWidth, 8/PxHeight)];
    _endTimeImage.image = [UIImage imageNamed:@"下拉箭头.png"];
    [_endTimeButton addSubview:_endTimeImage];
    
    _emptyButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endTimeButton.frame), kScreenWidth /2, 39/PxHeight)];
    _emptyButton.backgroundColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    [_emptyButton setTitle:@"清空" forState:UIControlStateNormal];
    [self addSubview:_emptyButton];
    
    _determineButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth /2, CGRectGetMaxY(_endTimeButton.frame), kScreenWidth /2, 39/PxHeight)];
    _determineButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_determineButton setTitle:@"确认" forState:UIControlStateNormal];
    [self addSubview:_determineButton];
    
    
}


@end
