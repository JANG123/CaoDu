//
//  FinHeadView.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FinHeadView.h"

@implementation FinHeadView

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
    self.backgroundColor = [UIColor whiteColor];
    _headButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton1.frame = CGRectMake(0, 0, kScreenWidth/3, 80/PxHeight);
    [self addSubview:_headButton1];
    
    UIImageView *conditionsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(47/PxWidth, 15/PxHeight, 32/PxWidth, 32/PxWidth)];
    [conditionsImageView  setImage:[UIImage imageNamed:@"iconfont-supplierfeatures.png"]];
    [_headButton1 addSubview:conditionsImageView];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(conditionsImageView.frame) + 8/PxHeight, CGRectGetWidth(_headButton1.frame), 15/PxHeight)];
    _label1.text = @"申请时间";
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.font = [UIFont adapterFontOfSize:14.0];
    _label1.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [_headButton1 addSubview:_label1];
    
    _greenLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton1 addSubview:_greenLabel1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headButton1.frame) - 1, 10/PxHeight, 1, CGRectGetHeight(_headButton1.frame) - 20/PxHeight)];
    label1.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [_headButton1 addSubview:label1];
    
    
    _headButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton2.frame = CGRectMake(CGRectGetMaxX(_headButton1.frame), 0, CGRectGetWidth(_headButton1.frame), CGRectGetHeight(_headButton1.frame));
    [self addSubview:_headButton2];
    
    _greenLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton2 addSubview:_greenLabel2];
    
    UIImageView *prepareImageView = [[UIImageView alloc]initWithFrame:CGRectMake(47/PxWidth, 15/PxHeight, 32/PxWidth, 32/PxWidth)];
    [prepareImageView  setImage:[UIImage imageNamed:@"iconfont-edit.png"]];
    [_headButton2 addSubview:prepareImageView];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(conditionsImageView.frame) + 8/PxHeight, CGRectGetWidth(_headButton2.frame), 15/PxHeight)];
    _label2.text = @"准备资料";
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont adapterFontOfSize:14.0];
    _label2.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [_headButton2 addSubview:_label2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_headButton2.frame) - 1, 10/PxHeight, 1, CGRectGetHeight(_headButton2.frame) - 20/PxHeight)];
    label2.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [_headButton2 addSubview:label2];
    
    _headButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton3.frame = CGRectMake(CGRectGetMaxX(_headButton2.frame), 0, CGRectGetWidth(_headButton2.frame), CGRectGetHeight(_headButton2.frame));
    [self addSubview:_headButton3];
    
    UIImageView *processImageView = [[UIImageView alloc]initWithFrame:CGRectMake(47/PxWidth, 15/PxHeight, 32/PxWidth, 32/PxWidth)];
    [processImageView  setImage:[UIImage imageNamed:@"iconfont-0001liucheng"]];
    [_headButton3 addSubview:processImageView];
    
    _greenLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton3 addSubview:_greenLabel3];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(conditionsImageView.frame) + 8/PxHeight, CGRectGetWidth(_headButton3.frame), 15/PxHeight)];
    _label3.text = @"办理流程";
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.font = [UIFont adapterFontOfSize:14.0];
    _label3.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [_headButton3 addSubview:_label3];
    
    
}

@end
