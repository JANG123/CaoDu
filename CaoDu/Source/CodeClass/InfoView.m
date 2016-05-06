//
//  InfoView.m
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InfoView.h"
#import "InfoCellView.h"
@implementation InfoView

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
    self.backgroundColor = [UIColor whiteColor];;
    _titleView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50/PxHeight) titleText:@"在线申请" placeholder:nil];
    _titleView.titleLabel.textColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
    _titleView.titleLabel.font = [UIFont adapterFontOfSize:16.0];
    _titleView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleView];
    
    _cityView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame)) titleText:@"所在城市：" placeholder:@"省/市/区"];
    [self addSubview:_cityView];
    
    _sexView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_cityView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame)) titleText:@"性别：" placeholder:nil];
    [self addSubview:_sexView];
    
    _checkboxMan = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkboxMan.frame = CGRectMake(CGRectGetMaxX(_sexView.titleLabel.frame), CGRectGetHeight(_sexView.frame)/2 - 4/PxWidth, 8/PxWidth, 8/PxWidth);
    [_checkboxMan.layer setBorderWidth:1.5]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 234/255.0, 234/255.0, 234/255.0, 1 });
    [_checkboxMan.layer setBorderColor:colorref];//边框颜色
    _checkboxMan.backgroundColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
    [_sexView addSubview:_checkboxMan];
    [_checkboxMan.layer setMasksToBounds:YES];
    [_checkboxMan.layer setCornerRadius:_checkboxMan.frame.size.height/2];
    UILabel *manLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_checkboxMan.frame) + 10/PxWidth, 0, 50/PxWidth, CGRectGetHeight(_sexView.frame))];
    manLabel.text = @"男";
    [_sexView addSubview:manLabel];
    
    _checkboxWoman = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkboxWoman.frame = CGRectMake((kScreenWidth - CGRectGetWidth(_sexView.titleLabel.frame))/2 + CGRectGetWidth(_sexView.titleLabel.frame), CGRectGetHeight(_sexView.frame)/2 - 4/PxWidth, 8/PxWidth, 8/PxWidth);
    [_checkboxWoman.layer setBorderWidth:1.5]; //边框宽度
    [_checkboxWoman.layer setBorderColor:colorref];//边框颜色
    _checkboxWoman.backgroundColor = Color_back;
    [_sexView addSubview:_checkboxWoman];
    [_checkboxWoman.layer setMasksToBounds:YES];
    [_checkboxWoman.layer setCornerRadius:_checkboxMan.frame.size.height/2];
    UILabel *womanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_checkboxWoman.frame) + 10/PxWidth, 0, 50/PxWidth, CGRectGetHeight(_sexView.frame))];
    womanLabel.text = @"女";
    [_sexView addSubview:womanLabel];
    
    
    _typeView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sexView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame)) titleText:@"抵押方式：" placeholder:@""];
    [self addSubview:_typeView];
    
    _timeView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame)) titleText:@"借款期限：" placeholder:@""];
    [self addSubview:_timeView];
    
    _nameView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timeView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame)) titleText:@"姓名：" placeholder:@"请输入您的真实姓名"];
    [self addSubview:_nameView];
    
    _phoneView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame))  titleText:@"手机号：" placeholder:@"请输入您的手机号"];
    [self addSubview:_phoneView];
    
    _moneyView = [[InfoCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_phoneView.frame), kScreenWidth, CGRectGetHeight(_titleView.frame))  titleText:@"申请金额：" placeholder:@"可保留两位小数"];
    [self addSubview:_moneyView];
}
@end
