//
//  TMyInvestmentableViewCell.h
//  CaoDu
//
//  Created by jang on 16/4/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMyInvestmentableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *goodsNameLabel;//项目名
@property (nonatomic,strong)UILabel *EndTimeLabel;//返本日期
@property (nonatomic,strong)UILabel *PriceLabel;//投资金额
@property (nonatomic,strong)UILabel *FundRateLabel;//年化收益
@property (nonatomic,strong)UILabel *RepaymentTypeLabel;//类型
@property (nonatomic,strong)UILabel *ExpectProfitLabel;//预计收益
@property (nonatomic,strong)UILabel *TimelimitLabel;//投资期限
@property (nonatomic,strong)UILabel *wCreateTimeLabel;//投资时间
@property (nonatomic,strong)UILabel *progressLabel;//投资进度
-(NSMutableAttributedString *)AddAttributeText:(NSString *)text;
@end
