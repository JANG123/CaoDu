//
//  GoodDetailsView.h
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailsView : UIView
@property (nonatomic,strong) UILabel *borrowingRateLabel;//年利率
@property (nonatomic,strong) UILabel *timelimitLabel;//时间
@property (nonatomic,strong) UILabel *totalAmountLabel;//总金额
@property (nonatomic,strong) UILabel *goodsNameLabel;//项目名
@property (nonatomic,strong) UILabel *moneyLabel;//剩余金额
@property (nonatomic,strong) UILabel *earningsLabel;//每百元收益
@property (nonatomic,strong) UILabel *typeLabel;//还款方式
@property (nonatomic,strong) UILabel *minPriceLable;//最小金额
@property (nonatomic,strong) UILabel *maxPriceLable;//最大金额
@property (nonatomic,strong) UILabel *timeRemainingLabel;//剩余时间
@property (nonatomic,strong) UIImageView *investmentLogo;//项目状态logo
@property (nonatomic,strong) MDRadialProgressView *radialView;
@property (nonatomic,strong) UILabel *investmentLabel;//项目状态
@property (nonatomic,strong) UILabel *label10;

-(void)textWidth:(NSString *)text Text2:(NSString *)text2;
@end
