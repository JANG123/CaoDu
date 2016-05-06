//
//  ModuleView.h
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleView : UIView

@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UIImageView *recommendImageView;
@property (nonatomic,strong)TYWaveProgressView *percentageImageView;
@property (nonatomic,strong)MDRadialProgressView *radialView;

@property (nonatomic,strong)UILabel *rateNumLabel;

@property (nonatomic,strong)UILabel *sumPriceLabel1;
@property (nonatomic,strong)UILabel *sumPriceLabel2;


@property (nonatomic,strong)UILabel *timelimitLabel1;
@property (nonatomic,strong)UILabel *timelimitLabel2;

@property (nonatomic,strong)UILabel *tsLabel;

@property (nonatomic,strong)UILabel *sellOutPriceLabel1;
@property (nonatomic,strong)UILabel *sellOutPriceLabel2;

@property (nonatomic,strong)UIButton *goodButton;

@end
