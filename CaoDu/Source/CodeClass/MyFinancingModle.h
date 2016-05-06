//
//  MyFinancingModle.h
//  CaoDu
//
//  Created by jang on 16/4/11.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFinancingModle : NSObject
@property (nonatomic,strong)NSString *GoodsName;//项目名称
@property (nonatomic,strong)NSString *State;//状态
@property (nonatomic,strong)NSString *Price;//金额
@property (nonatomic,strong)NSString *CreateTime;//申请时间
@property (nonatomic,strong)NSString *FundRate;//利率
@property (nonatomic,strong)NSString *StartTime;//开始时间
@property (nonatomic,strong)NSString *StopTime;//还款时间
@property (nonatomic,strong)NSString *BID;//ID
@end
