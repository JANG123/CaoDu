//
//  GoodDetailModle.h
//  CaoDu
//
//  Created by jang on 16/3/23.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDetailModle : NSObject
@property (nonatomic,strong)NSString *GoodsName;//项目名
@property (nonatomic,strong)NSString *ID;//项目ID
@property (nonatomic,strong)NSString *BorrowingRate;//百元收益
@property (nonatomic,strong)NSString *BorrowingRateMoney;//百元利率
@property (nonatomic,strong)NSString *Price;//最大可投
@property (nonatomic,strong)NSString *Timelimit;//时间限制
@property (nonatomic,strong)NSString *SumPrice;//已投金额
@property (nonatomic,strong)NSString *remainAmount;//剩余金额
@property (nonatomic,strong)NSString *RepaymentType;//类型
@property (nonatomic,strong)NSString *minPrice;//最小可投
@property (nonatomic,strong)NSString *absolutely;//百分百
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)NSString *RepaymentDate;
@property (nonatomic,strong)NSString *FundRate;
@property (nonatomic,strong)NSString *TimelimitUrl;
@property (nonatomic,strong)NSString *PriceUrl;
@property (nonatomic,strong)NSString *RID;
@property (nonatomic,strong)NSString *Payment;
@property (nonatomic,strong)NSString *AllProfit;
@property (nonatomic,strong)NSString *GoodsDescription;//项目介绍
@property (nonatomic,strong)NSString *Repayment;//还款来源
@property (nonatomic,strong)NSString *RiskControl;//风险控制措施
@property (nonatomic,strong)NSString *BondData;//资金用途
@property (nonatomic,strong)NSString *Remark;//借款人信息
@property (nonatomic,strong)NSString *IsAttention;
@end
