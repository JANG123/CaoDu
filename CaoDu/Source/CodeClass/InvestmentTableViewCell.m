//
//  InvestmentTableViewCell.m
//  CaoDu
//
//  Created by jang on 16/3/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InvestmentTableViewCell.h"

@implementation InvestmentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.backgroundColor = Color_back;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(13/PxWidth, 0, kScreenWidth - 26/PxWidth, 112/PxHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20/PxWidth, 14/PxHeight, 25/PxWidth, 16/PxHeight)];
    [logoImageView setImage:[UIImage imageNamed:@"logo-1.png"]];
    [backView addSubview:logoImageView];
    
    _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame) + 5/PxWidth, CGRectGetMinY(logoImageView.frame), 98/PxWidth, CGRectGetHeight(logoImageView.frame))];
    _goodsNameLabel.text = @"保本保息草标";
    _goodsNameLabel.font = [UIFont adapterFontOfSize:16.0];
    _goodsNameLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    [backView addSubview:_goodsNameLabel];
    
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(logoImageView.frame), CGRectGetMaxY(logoImageView.frame) + 5/PxHeight, 150/PxWidth, 9/PxHeight)];
    _moneyLabel.text = @"剩余投标金额:0.00，每百元收益";
    _moneyLabel.font = [UIFont adapterFontOfSize:10.0];
    _moneyLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [backView addSubview:_moneyLabel];
    
    _earningsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), CGRectGetMinY(self.moneyLabel.frame), 15/PxWidth, CGRectGetHeight(self.moneyLabel.frame))];
    _earningsLabel.text = @"0.5";
    _earningsLabel.font = [UIFont adapterFontOfSize:9.0];
    _earningsLabel.textColor = [UIColor colorWithRed:225/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    [backView addSubview:_earningsLabel];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.earningsLabel.frame), CGRectGetMinY(self.earningsLabel.frame), 15/PxWidth, CGRectGetHeight(self.earningsLabel.frame))];
    _label1.text = @"元";
    _label1.font = [UIFont adapterFontOfSize:10.0];
    _label1.textAlignment = NSTextAlignmentLeft;
    _label1.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [backView addSubview:_label1];
    
    _borrowingRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_moneyLabel.frame), CGRectGetMaxY(_moneyLabel.frame) + 18/PxHeight, 75/PxWidth, 18/PxHeight)];
    _borrowingRateLabel.text = @"12.00%";
    _borrowingRateLabel.font = [UIFont adapterFontOfSize:18.0];
    _borrowingRateLabel.textColor = [UIColor colorWithRed:225/255.0 green:115/255.0 blue:2/255.0 alpha:1.0];
    [backView addSubview:_borrowingRateLabel];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.borrowingRateLabel.frame), CGRectGetMinY(self.borrowingRateLabel.frame) + 6/PxHeight, 55/PxWidth, 12/PxHeight)];
    label2.text = @"年化利率";
    label2.font = [UIFont adapterFontOfSize:11.0];
    label2.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [backView addSubview:label2];
    
    _timelimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame)+10/PxWidth, CGRectGetMinY(_borrowingRateLabel.frame), 42/PxWidth, CGRectGetHeight(self.borrowingRateLabel.frame))];
    _timelimitLabel.text = @"31";
    _timelimitLabel.font = [UIFont adapterFontOfSize:20.0];
    _timelimitLabel.textAlignment = NSTextAlignmentCenter;
    _timelimitLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];;
    [backView addSubview:_timelimitLabel];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timelimitLabel.frame), CGRectGetMinY(_timelimitLabel.frame) + 6/PxHeight, 15/PxWidth, CGRectGetHeight(label2.frame))];
    label3.text = @"天";
    label3.font = [UIFont adapterFontOfSize:11.0];
    label3.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [backView addSubview:label3];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_borrowingRateLabel.frame), CGRectGetMaxY(_borrowingRateLabel.frame) + 10/PxHeight, CGRectGetWidth(_borrowingRateLabel.frame), CGRectGetHeight(label2.frame))];
    _titleLabel.text = @"新手标第10期";
    _titleLabel.font = [UIFont adapterFontOfSize:11.0];
    _titleLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [backView addSubview:_titleLabel];
    
    
    _maxPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+16/PxWidth, CGRectGetMinY(_titleLabel.frame), 120/PxWidth, CGRectGetHeight(_titleLabel.frame))];
    _maxPriceLable.text = @"可投金额：200万元";
    _maxPriceLable.font = [UIFont adapterFontOfSize:11.0];
    _maxPriceLable.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    [backView addSubview:_maxPriceLable];
    
//    _investmentLogo = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backView.frame) - 93/PxWidth, 26/PxHeight, 75/PxWidth, 75/PxWidth)];
//    [_investmentLogo setImage:[UIImage imageNamed:@"quan_touzi.png"]];
//    [backView addSubview:_investmentLogo];
    
    _radialView = [[MDRadialProgressView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backView.frame) - 75/PxWidth, 26/PxHeight, 75/PxWidth, 75/PxWidth)];
    _radialView.theme.sliceDividerHidden = YES;
    _radialView.theme.completedColor = [UIColor colorWithRed:86/255.0 green:205/255.0 blue:81/255.0 alpha:1.0];
    _radialView.theme.thickness = 9;
    [self addSubview:_radialView];
    
    _investmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10/PxWidth, 32/PxHeight, 58/PxWidth, 13/PxWidth)];
    _investmentLabel.text = @"我要投资";
    _investmentLabel.font = [UIFont adapterFontOfSize:11.0];
    _investmentLabel.textAlignment = NSTextAlignmentCenter;
    _investmentLabel.textColor = [UIColor colorWithRed:98/255.0 green:160/255.0 blue:98/255.0 alpha:1.0];;
    [_radialView addSubview:_investmentLabel];
    
    
    _recommendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backView.frame) - 42/PxWidth, 0, 42/PxWidth, 42/PxWidth)];
    [_recommendImageView setImage:[UIImage imageNamed:@"msg_shouye.png"]];
    [backView addSubview:_recommendImageView];
    
}

-(void)textWidth:(NSString *)text Text2:(NSString *)text2{
    CGSize size =[text sizeWithAttributes:@{NSFontAttributeName:[UIFont adapterFontOfSize:10.0]}];
    CGFloat width = size.width - _moneyLabel.frame.size.width;
    
    CGRect tempRect1 = _moneyLabel.frame;
    tempRect1.size.width = size.width;
    _moneyLabel.frame = tempRect1;
    
    CGSize size2 =[text2 sizeWithAttributes:@{NSFontAttributeName:[UIFont adapterFontOfSize:10.0]}];
    
    CGRect tempRect2 = _earningsLabel.frame;
    CGFloat width2 = size2.width - _earningsLabel.frame.size.width;
    tempRect2.size.width = size2.width;
    tempRect2.origin.x = _earningsLabel.frame.origin.x + width;
    _earningsLabel.frame = tempRect2;
    
    CGRect tempRect3 = _label1.frame;
    tempRect3.origin.x = _label1.frame.origin.x + width + width2;
    _label1.frame = tempRect3;
  
}

@end
