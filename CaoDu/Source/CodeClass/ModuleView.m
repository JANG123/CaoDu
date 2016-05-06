//
//  ModuleView.m
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "ModuleView.h"

@implementation ModuleView

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
    
    _logoImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(65/PxWidth, 15/PxHeight, 33/PxWidth, 24/PxWidth)];
    [_logoImageView setImage:[UIImage imageNamed:@"logo-1.png"]];
    [self addSubview:_logoImageView];
    
    _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.logoImageView.frame)+10, CGRectGetMinY(self.logoImageView.frame), KboundsWidth*0.3, CGRectGetHeight(self.logoImageView.frame))];
    _goodsNameLabel.font = [UIFont adapterFontOfSize: 18.0];
    _goodsNameLabel.textAlignment = NSTextAlignmentCenter;
    _goodsNameLabel.text = @"保本保息草标";
    [self addSubview:_goodsNameLabel];
    
    _recommendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-50/PxWidth, 0, 50/PxWidth, 50/PxWidth)];
    [_recommendImageView setImage:[UIImage imageNamed:@"recommend.png"]];
    [self addSubview:_recommendImageView];
    
    
    _percentageImageView = [[TYWaveProgressView alloc]initWithFrame:CGRectMake(53/PxWidth, 60/PxHeight, 190/PxWidth, 190/PxWidth)];
    _percentageImageView.waveViewMargin = UIEdgeInsetsMake(15, 15, 20, 20);
    _percentageImageView.numberLabel.text = @"";
    _percentageImageView.percent = 0.3;
    [_percentageImageView startWave];
    [self addSubview:_percentageImageView];
    
    _radialView = [[MDRadialProgressView alloc]initWithFrame:CGRectMake(53/PxWidth, 50/PxHeight, 200/PxWidth, 200/PxWidth)];
    _radialView.center = CGPointMake(_percentageImageView.center.x, _percentageImageView.center.y);
    _radialView.theme.sliceDividerHidden = YES;
    _radialView.theme.thickness = 11;
    _radialView.theme.completedColor = [UIColor colorWithRed:0/255.0 green:167/255.0 blue:255/255.0 alpha:1];
    [self addSubview:_radialView];
    
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(64/PxWidth, 45/PxHeight, 64/PxWidth, 20/PxHeight)];
    rateLabel.font = [UIFont adapterFontOfSize: 15.0];
    rateLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    rateLabel.text = @"年化利率";
    rateLabel.textAlignment = NSTextAlignmentCenter;
    [rateLabel sizeToFit];
    [_percentageImageView addSubview:rateLabel];
    
    _rateNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/PxWidth, CGRectGetMaxY(rateLabel.frame) + 15/PxHeight, 155/PxWidth, 30/PxHeight)];
    _rateNumLabel.font = [UIFont adapterFontOfSize: 35.0];
    _rateNumLabel.textColor = [UIColor colorWithRed:251/255.0 green:92/255.0 blue:10/255.0 alpha:1];
    _rateNumLabel.textAlignment = NSTextAlignmentCenter;
    _rateNumLabel.text = @"12.00%";
    [_percentageImageView addSubview:_rateNumLabel];
    
    _sumPriceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_percentageImageView.frame) + 25/PxHeight, 113/PxWidth, 15/PxHeight)];
    _sumPriceLabel1.font = [UIFont adapterFontOfSize: 11.0];
    _sumPriceLabel1.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    _sumPriceLabel1.text = @"最大可投";
    _sumPriceLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sumPriceLabel1];
    
    _sumPriceLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sumPriceLabel1.frame), 113/PxWidth, 15/PxHeight)];
    _sumPriceLabel2.font = [UIFont adapterFontOfSize: 13.0];
    _sumPriceLabel2.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    _sumPriceLabel2.text = @"¥200万元";
    _sumPriceLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sumPriceLabel2];
    
    UILabel *stLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sumPriceLabel1.frame), CGRectGetMinY(self.sumPriceLabel1.frame), 1, 30/PxHeight)];
    stLabel.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    [self addSubview:stLabel];
    
    _timelimitLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sumPriceLabel1.frame), CGRectGetMinY(self.sumPriceLabel1.frame), 96/PxWidth, 15/PxHeight)];
    _timelimitLabel1.font = [UIFont adapterFontOfSize: 11.0];
    _timelimitLabel1.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    _timelimitLabel1.text = @"期限";
    _timelimitLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timelimitLabel1];
    
    _timelimitLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sumPriceLabel1.frame), CGRectGetMaxY(_timelimitLabel1.frame), 96/PxWidth, 15/PxHeight)];
    _timelimitLabel2.font = [UIFont adapterFontOfSize: 13.0];
    _timelimitLabel2.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    _timelimitLabel2.text = @"31天";
    _timelimitLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timelimitLabel2];
    
    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timelimitLabel1.frame), CGRectGetMinY(self.timelimitLabel1.frame), 1, 30/PxHeight)];
    tsLabel.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    [self addSubview:tsLabel];
    
    _sellOutPriceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timelimitLabel1.frame), CGRectGetMinY(_timelimitLabel1.frame), 96/PxWidth, 15/PxHeight)];
    _sellOutPriceLabel1.font = [UIFont adapterFontOfSize: 11.0];
    _sellOutPriceLabel1.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    _sellOutPriceLabel1.text = @"起投";
    _sellOutPriceLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sellOutPriceLabel1];
    
    _sellOutPriceLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timelimitLabel1.frame), CGRectGetMaxY(_timelimitLabel1.frame), 96/PxWidth, 15/PxHeight)];
    _sellOutPriceLabel2.font = [UIFont adapterFontOfSize: 13.0];
    _sellOutPriceLabel2.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    _sellOutPriceLabel2.text = @"¥500";
    _sellOutPriceLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sellOutPriceLabel2];
    
    _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goodButton.frame = CGRectMake(21/PxWidth, self.frame.size.height - 55/PxHeight, 263/PxWidth, 45/PxHeight);
    [_goodButton setTitle:@"我要投资" forState:UIControlStateNormal];
    [_goodButton setBackgroundImage:[UIImage imageNamed:@"btn_zuichangt.png"] forState:UIControlStateNormal];
    [_goodButton.layer setMasksToBounds:YES];
    [_goodButton.layer setCornerRadius:8.0];
    _goodButton.titleLabel.font = [UIFont adapterFontOfSize: 18.0];
    _goodButton.titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    [self addSubview:_goodButton];
}

@end
