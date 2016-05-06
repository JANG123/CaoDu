//
//  DetailTitleView.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "DetailTitleView.h"

@implementation DetailTitleView

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
    _headButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton1.frame = CGRectMake(0, 0, kScreenWidth/3, 47/PxHeight);
    [_headButton1 setTitle:@"项目详情" forState:UIControlStateNormal];
    [_headButton1 setTitleColor:Font_Color forState:UIControlStateNormal];
    [self addSubview:_headButton1];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_headButton1.frame) - 2/PxHeight, kScreenWidth/3, 2/PxHeight)];
    [_headButton1 addSubview:_label1];
    
    _headButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton2.frame = CGRectMake(CGRectGetMaxX(_headButton1.frame), 0, kScreenWidth/3, 47/PxHeight);
    [_headButton2 setTitle:@"风险控制" forState:UIControlStateNormal];
    [_headButton2 setTitleColor:Font_Color forState:UIControlStateNormal];
    [self addSubview:_headButton2];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_headButton2.frame) - 2/PxHeight, kScreenWidth/3, 2/PxHeight)];
    [_headButton2 addSubview:_label2];
    
    _headButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton3.frame = CGRectMake(CGRectGetMaxX(_headButton2.frame), 0, kScreenWidth/3, 47/PxHeight);
    [_headButton3 setTitle:@"投资记录" forState:UIControlStateNormal];
    [_headButton3 setTitleColor:Font_Color forState:UIControlStateNormal];
    [self addSubview:_headButton3];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_headButton3.frame) - 2/PxHeight, kScreenWidth/3, 2/PxHeight)];
    [_headButton3 addSubview:_label3];
    
//    _headButton4 = [UIButton buttonWithType:UIButtonTypeSystem];
//    _headButton4.frame = CGRectMake(CGRectGetMaxX(_headButton3.frame), 0, kScreenWidth/3, 47/PxHeight);
//    [_headButton4 setTitle:@"还款计划" forState:UIControlStateNormal];
//    [_headButton4 setTitleColor:Font_Color forState:UIControlStateNormal];
//    [self addSubview:_headButton4];
//    
//    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_headButton4.frame) - 2/PxHeight, kScreenWidth/3, 2/PxHeight)];
//    [_headButton4 addSubview:_label4];
}
@end
