//
//  GoodDetailsView.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GoodDetailsView.h"

@implementation GoodDetailsView

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
    
    UIImageView *curveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 461/PxHeight)];
    [curveImageView setImage:[UIImage imageNamed:@"xiangmuxq.png"]];
    [self addSubview:curveImageView];
    
    _borrowingRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(26/PxWidth, 35/PxHeight, 110/PxWidth, 28/PxHeight)];
    _borrowingRateLabel.text = @"11.0";
    _borrowingRateLabel.textAlignment = NSTextAlignmentRight;
    _borrowingRateLabel.font = [UIFont adapterFontOfSize:30.0];
    _borrowingRateLabel.textColor = [UIColor colorWithRed:255/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    [self addSubview:_borrowingRateLabel];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.borrowingRateLabel.frame), CGRectGetMinY(self.borrowingRateLabel.frame) + 15/PxHeight, 20/PxWidth, 13/PxHeight)];
    label1.text = @"%";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont adapterFontOfSize:15.0];
    label1.textColor = [UIColor colorWithRed:255/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.borrowingRateLabel.frame) + 10/PxWidth, CGRectGetMaxY(self.borrowingRateLabel.frame) + 10/PxHeight, CGRectGetMaxX(label1.frame) - CGRectGetMinX(self.borrowingRateLabel.frame), 15/PxHeight)];
    label2.text = @"年化收益";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont adapterFontOfSize:12.0];
    label2.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:label2];
    
    _timelimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 100/PxWidth, 55/PxHeight, 30/PxWidth, 28/PxHeight)];
    _timelimitLabel.text = @"3";
    _timelimitLabel.textAlignment = NSTextAlignmentRight;
    _timelimitLabel.font = [UIFont adapterFontOfSize:32.0];
    _timelimitLabel.textColor = [UIColor colorWithRed:95/255.0 green:180/255.0 blue:241/255.0 alpha:1.0];
    [self addSubview:_timelimitLabel];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timelimitLabel.frame), CGRectGetMinY(self.timelimitLabel.frame) + 10/PxHeight, 50/PxWidth, 15/PxHeight)];
    label3.text = @"个月";
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont adapterFontOfSize:20.0];
    label3.textColor = [UIColor colorWithRed:95/255.0 green:180/255.0 blue:241/255.0 alpha:1.0];
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.timelimitLabel.frame), CGRectGetMaxY(self.timelimitLabel.frame) + 10/PxHeight, CGRectGetMaxX(label3.frame) - CGRectGetMinX(self.timelimitLabel.frame), 15/PxHeight)];
    label4.text = @"投资期望";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont adapterFontOfSize:12.0];
    label4.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:label4];
    
    _totalAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(150/PxWidth, 210/PxHeight, 79/PxWidth, 28/PxHeight)];
    _totalAmountLabel.text = @"320";
    _totalAmountLabel.font = [UIFont adapterFontOfSize:32.0];
    _totalAmountLabel.textAlignment = NSTextAlignmentCenter;
    _totalAmountLabel.textColor = [UIColor colorWithRed:255/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    [self addSubview:_totalAmountLabel];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.totalAmountLabel.frame), CGRectGetMinY(self.totalAmountLabel.frame) + 15/PxHeight, 50/PxWidth, 13/PxHeight)];
    label5.text = @"万元";
    label5.textAlignment = NSTextAlignmentLeft;
    label5.font = [UIFont adapterFontOfSize:11.0];
    label5.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.totalAmountLabel.frame) , CGRectGetMaxY(self.totalAmountLabel.frame) + 5/PxHeight, CGRectGetWidth(_totalAmountLabel.frame), 15/PxHeight)];
    label6.text = @"众筹总金额";
    label6.font = [UIFont adapterFontOfSize:11.0];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    [self addSubview:label6];
    
    UIImageView *benImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60/PxWidth, CGRectGetMaxY(label6.frame) + 10/PxHeight, 17/PxWidth, 17/PxWidth)];
    [benImageView setImage:[UIImage imageNamed:@"img_moren.png"]];
    [self addSubview:benImageView];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(benImageView.frame) + 6/PxWidth, CGRectGetMinY(benImageView.frame), 58/PxWidth, CGRectGetHeight(benImageView.frame))];
    label7.text = @"保障本息";
    label7.font = [UIFont adapterFontOfSize:12.0];
    label7.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:label7];
    
    UIImageView *kongImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label7.frame) + 9/PxWidth, CGRectGetMinY(label7.frame), CGRectGetWidth(benImageView.frame), CGRectGetHeight(benImageView.frame))];
    [kongImageView setImage:[UIImage imageNamed:@"img_moren02.png"]];
    [self addSubview:kongImageView];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(kongImageView.frame) + 6/PxWidth, CGRectGetMinY(kongImageView.frame), 58/PxWidth, CGRectGetHeight(kongImageView.frame))];
    label8.text = @"风险控制";
    label8.font = [UIFont adapterFontOfSize:12.0];
    label8.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:label8];
    
    UIImageView *baoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label8.frame) + 9/PxWidth, CGRectGetMinY(label8.frame), CGRectGetWidth(benImageView.frame), CGRectGetHeight(benImageView.frame))];
    [baoImageView setImage:[UIImage imageNamed:@"img_moren03.png"]];
    [self addSubview:baoImageView];
    
    UILabel *label9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(baoImageView.frame) + 6/PxWidth, CGRectGetMinY(baoImageView.frame), 58/PxWidth, CGRectGetHeight(baoImageView.frame))];
    label9.text = @"还款保障";
    label9.font = [UIFont adapterFontOfSize:12.0];
    label9.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:label9];
    
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18/PxWidth, CGRectGetMaxY(label9.frame) + 23/PxHeight, 25/PxWidth, 16/PxHeight)];
    [logoImageView setImage:[UIImage imageNamed:@"logo-1.png"]];
    [self addSubview:logoImageView];
    
    _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame) + 5/PxWidth, CGRectGetMinY(logoImageView.frame), 98/PxWidth, CGRectGetHeight(logoImageView.frame))];
    _goodsNameLabel.text = @"保本保息草标";
    _goodsNameLabel.font = [UIFont adapterFontOfSize:18.0];
    _goodsNameLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    [self addSubview:_goodsNameLabel];
    
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(logoImageView.frame) , CGRectGetMaxY(logoImageView.frame) + 10/PxHeight, 150/PxWidth, 9/PxHeight)];
    _moneyLabel.text = @"剩余投标金额:0.00，每百元收益";
    _moneyLabel.font = [UIFont adapterFontOfSize:11.0];
    _moneyLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:_moneyLabel];
    
    _earningsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), CGRectGetMinY(self.moneyLabel.frame), 15/PxWidth, CGRectGetHeight(self.moneyLabel.frame))];
    _earningsLabel.text = @"0.5";
    _earningsLabel.font = [UIFont adapterFontOfSize:10.0];
    _earningsLabel.textColor = [UIColor colorWithRed:225/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    [self addSubview:_earningsLabel];
    
    _label10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.earningsLabel.frame), CGRectGetMinY(self.earningsLabel.frame), 15/PxWidth, CGRectGetHeight(self.earningsLabel.frame))];
    _label10.text = @"元";
    _label10.font = [UIFont adapterFontOfSize:11.0];
    _label10.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:_label10];
    
    CGSize size =[@"还款方式：" sizeWithAttributes:@{NSFontAttributeName:[UIFont adapterFontOfSize:14.0]}];
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_moneyLabel.frame), CGRectGetMaxY(_moneyLabel.frame) + 16/PxHeight, size.width, 14/PxHeight)];
    label11.text = @"还款方式：";
    label11.font = [UIFont adapterFontOfSize:14.0];
    label11.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    [self addSubview:label11];
    
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label11.frame), CGRectGetMinY(label11.frame), 100/PxWidth, CGRectGetHeight(label11.frame))];
    _typeLabel.text = @"月还息到期还本";
    _typeLabel.font = [UIFont adapterFontOfSize:14.0];
    _typeLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:_typeLabel];
    
    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label11.frame), CGRectGetMaxY(label11.frame) + 16/PxHeight, CGRectGetWidth(label11.frame), 14/PxHeight)];
    label12.text = @"最小可投：";
    label12.font = [UIFont adapterFontOfSize:14.0];
    label12.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    [self addSubview:label12];
    
    _minPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label12.frame), CGRectGetMinY(label12.frame), 100/PxWidth, CGRectGetHeight(label12.frame))];
    _minPriceLable.text = @"500元";
    _minPriceLable.font = [UIFont adapterFontOfSize:14.0];
    _minPriceLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:_minPriceLable];
    
    UILabel *label13 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label12.frame), CGRectGetMaxY(label12.frame) + 16/PxHeight, CGRectGetWidth(label11.frame), 14/PxHeight)];
    label13.text = @"最大可投：";
    label13.font = [UIFont adapterFontOfSize:14.0];
    label13.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    [self addSubview:label13];
    
    _maxPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label13.frame), CGRectGetMinY(label13.frame), 100/PxWidth, CGRectGetHeight(label13.frame))];
    _maxPriceLable.text = @"200万元";
    _maxPriceLable.font = [UIFont adapterFontOfSize:14.0];
    _minPriceLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:_maxPriceLable];
    
    UILabel *label14 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label13.frame), CGRectGetMaxY(label13.frame) + 16/PxHeight, CGRectGetWidth(label11.frame), 14/PxHeight)];
    label14.text = @"剩余时间：";
    label14.font = [UIFont adapterFontOfSize:14.0];
    label14.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    [self addSubview:label14];
    
    _timeRemainingLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label14.frame), CGRectGetMinY(label14.frame), 130/PxWidth, CGRectGetHeight(label14.frame))];
    _timeRemainingLabel.text = @"2天12小时36分";
    _timeRemainingLabel.font = [UIFont adapterFontOfSize:14.0];
    _timeRemainingLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:_timeRemainingLabel];
    
    _radialView = [[MDRadialProgressView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 125/PxWidth, CGRectGetMinY(_typeLabel.frame) + 10/PxHeight, 91/PxWidth, 91/PxWidth)];
    _radialView.theme.sliceDividerHidden = YES;
    _radialView.theme.completedColor = [UIColor colorWithRed:86/255.0 green:205/255.0 blue:81/255.0 alpha:1.0];
    _radialView.theme.thickness = 9;
    [self addSubview:_radialView];
    
    _investmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(12/PxWidth, 32/PxHeight, 70/PxWidth, 25/PxHeight)];
    _investmentLabel.text = @"100%";
    _investmentLabel.textAlignment = NSTextAlignmentCenter;
    _investmentLabel.font = [UIFont adapterFontOfSize:22.0];
    _investmentLabel.textColor = [UIColor colorWithRed:98/255.0 green:160/255.0 blue:98/255.0 alpha:1.0];
    [_radialView addSubview:_investmentLabel];
}

-(void)textWidth:(NSString *)text Text2:(NSString *)text2{
    CGSize size =[text sizeWithAttributes:@{NSFontAttributeName:[UIFont adapterFontOfSize:11.0]}];
    CGFloat width = size.width - _moneyLabel.frame.size.width;
    
    CGRect tempRect1 = _moneyLabel.frame;
    tempRect1.size.width = size.width;
    _moneyLabel.frame = tempRect1;
    
    CGSize size2 =[text2 sizeWithAttributes:@{NSFontAttributeName:[UIFont adapterFontOfSize:11.0]}];
    
    CGRect tempRect2 = _earningsLabel.frame;
    CGFloat width2 = size2.width - _earningsLabel.frame.size.width;
    tempRect2.size.width = size2.width;
    tempRect2.origin.x = _earningsLabel.frame.origin.x + width;
    _earningsLabel.frame = tempRect2;
    
    CGRect tempRect3 = _label10.frame;
    tempRect3.origin.x = _label10.frame.origin.x + width + width2;
    _label10.frame = tempRect3;
    
}

@end
