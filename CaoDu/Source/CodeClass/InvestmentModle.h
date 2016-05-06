//
//  InvestmentModle.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestmentModle : NSObject
@property (nonatomic,strong)NSString *GoodsName;//项目名
@property (nonatomic,strong)NSString *ID;//项目ID
@property (nonatomic,strong)NSString *BorrowingRate;//百元收益
@property (nonatomic,strong)NSString *BorrowingRateMoney;//百元利率
@property (nonatomic,strong)NSString *Price;//最大可投
@property (nonatomic,strong)NSString *Timelimit;//时间限制
@property (nonatomic,strong)NSString *SumPrice;//已投金额
@property (nonatomic,strong)NSString *remainAmount;//剩余金额
@property (nonatomic,strong)NSString *RepaymentType;//类型
@property (nonatomic,strong)NSString *absolutely;//百分比
@end
