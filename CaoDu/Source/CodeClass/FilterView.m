//
//  FilterView.m
//  CaoDu
//
//  Created by jang on 16/4/6.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FilterView.h"

@implementation FilterView

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
    double width = self.frame.size.width;
    double height = self.frame.size.height;
    double fiHeight = 100.0;

    self.backgroundColor = [UIColor whiteColor];
    _goodsTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 8.0/fiHeight *height)];
    _goodsTypeLabel.text = @"项目状态";
    _goodsTypeLabel.font = [UIFont adapterFontOfSize:14.0];
    _goodsTypeLabel.textAlignment = NSTextAlignmentCenter;
    _goodsTypeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    _goodsTypeLabel.backgroundColor = Color_back;
    [self addSubview:_goodsTypeLabel];
    
    _typeButton0 = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton0.frame = CGRectMake(0, CGRectGetMaxY(_goodsTypeLabel.frame), width, 7.0/fiHeight *height);
    [_typeButton0 setTitle:@"不限" forState:UIControlStateNormal];
    _typeButton0.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_typeButton0 setTitleColor:Color_Cyan forState:UIControlStateNormal];
    [self addSubview:_typeButton0];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeButton0.frame)-1, width, 1)];
    lable1.backgroundColor = Color_back;
    [self addSubview:lable1];
    
    _typeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton1.frame = CGRectMake(0, CGRectGetMaxY(_typeButton0.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_typeButton1 setTitle:@"招标中" forState:UIControlStateNormal];
    _typeButton1.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_typeButton1 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_typeButton1];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeButton1.frame)-1, width, 1)];
    lable2.backgroundColor = Color_back;
    [self addSubview:lable2];
    
    _typeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton2.frame = CGRectMake(0, CGRectGetMaxY(_typeButton1.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_typeButton2 setTitle:@"还款中" forState:UIControlStateNormal];
    _typeButton2.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_typeButton2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_typeButton2];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeButton2.frame)-1, width, 1)];
    lable3.backgroundColor = Color_back;
    [self addSubview:lable3];
    
    _typeButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton3.frame = CGRectMake(0, CGRectGetMaxY(_typeButton2.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_typeButton3 setTitle:@"还款完成" forState:UIControlStateNormal];
    _typeButton3.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_typeButton3 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_typeButton3];
    
    
    _timelimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeButton3.frame), width, 8.0/fiHeight *height)];
    _timelimitLabel.text = @"借款期限";
    _timelimitLabel.font = [UIFont adapterFontOfSize:14.0];
    _timelimitLabel.textAlignment = NSTextAlignmentCenter;
    _timelimitLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    _timelimitLabel.backgroundColor = Color_back;
    [self addSubview:_timelimitLabel];
    
    _timelimitButton0 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton0.frame = CGRectMake(0, CGRectGetMaxY(_timelimitLabel.frame), width, 7.0/120.0 *height);
    [_timelimitButton0 setTitle:@"不限" forState:UIControlStateNormal];
    _timelimitButton0.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton0 setTitleColor:Color_Cyan forState:UIControlStateNormal];
    [self addSubview:_timelimitButton0];
    
    UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timelimitButton0.frame)-1, width, 1)];
    lable4.backgroundColor = Color_back;
    [self addSubview:lable4];
    
    _timelimitButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton1.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton0.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_timelimitButton1 setTitle:@"随存随取" forState:UIControlStateNormal];
    _timelimitButton1.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton1 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_timelimitButton1];
    
    UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timelimitButton1.frame)-1, width, 1)];
    lable5.backgroundColor = Color_back;
    [self addSubview:lable5];
    
    _timelimitButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton2.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton1.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_timelimitButton2 setTitle:@"30天" forState:UIControlStateNormal];
    _timelimitButton2.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_timelimitButton2];
    
    UILabel *lable6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timelimitButton2.frame)-1, width, 1)];
    lable6.backgroundColor = Color_back;
    [self addSubview:lable6];
    
    _timelimitButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton3.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton2.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_timelimitButton3 setTitle:@"90天" forState:UIControlStateNormal];
    _timelimitButton3.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton3 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_timelimitButton3];
    
    UILabel *lable7 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timelimitButton3.frame)-1, width, 1)];
    lable7.backgroundColor = Color_back;
    [self addSubview:lable7];
    
    _timelimitButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton4.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton3.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_timelimitButton4 setTitle:@"180天" forState:UIControlStateNormal];
    _timelimitButton4.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_timelimitButton4];
    
    UILabel *lable8 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timelimitButton4.frame)-1, width, 1)];
    lable8.backgroundColor = Color_back;
    [self addSubview:lable8];
    
    _timelimitButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton5.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton4.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_timelimitButton5 setTitle:@"270天" forState:UIControlStateNormal];
    _timelimitButton5.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton5 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_timelimitButton5];
    
    UILabel *lable9 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timelimitButton5.frame)-1, width, 1)];
    lable9.backgroundColor = Color_back;
    [self addSubview:lable9];
    
    _timelimitButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    _timelimitButton6.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton5.frame), width, CGRectGetHeight(_typeButton0.frame));
    [_timelimitButton6 setTitle:@"360天" forState:UIControlStateNormal];
    _timelimitButton6.titleLabel.font = [UIFont adapterFontOfSize:12.0];
    [_timelimitButton6 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_timelimitButton6];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_timelimitButton6.frame), width/2, 9.0/fiHeight *height);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    _cancelButton.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self addSubview:_cancelButton];
    
    _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _determineButton.frame = CGRectMake(CGRectGetMaxX(_cancelButton.frame), CGRectGetMaxY(_timelimitButton6.frame), width/2, CGRectGetHeight(_cancelButton.frame));
    [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
    _determineButton.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    _determineButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:119/255.0 blue:35/255.0 alpha:1.0];
    [self addSubview:_determineButton];
    
}

@end
