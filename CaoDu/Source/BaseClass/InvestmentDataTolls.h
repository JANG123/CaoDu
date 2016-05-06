//
//  InvestmentDataTolls.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^InvestmentDataTollsPassValue)(NSMutableArray *code);
@class BondModle;
@interface InvestmentDataTolls : NSObject
+(InvestmentDataTolls *)shareGetInvestmentData;

-(void)GetHotBPTIWithPageSize:(NSInteger)PageSize PassValue:(InvestmentDataTollsPassValue)passVallue;

-(void)BPTIDetailWithID:(NSString *)bpID ClientId:(NSString *)ClientId PassValue:(InvestmentDataTollsPassValue)passVallue;

-(void)PubLishBondWithID:(BondModle *)Bond PassValue:(InvestmentDataTollsPassValue)passVallue;

-(void)BRaiseListWithID:(NSString *)bpID PassValue:(InvestmentDataTollsPassValue)passVallue;

-(void)GetRepaymentPlanWithRepaymentDate:(NSString *)RepaymentDate FundRate:(NSString *)fundRate Timelimit:(NSString *)timelimit Price:(NSString *)price PassValue:(InvestmentDataTollsPassValue)passVallue;

- (NSString *) returnUploadEndTime:(NSString *)endtimeStr;

- (NSString *) returnPoorTime:(NSString *)CreatetimeStr Time:(NSString *)endtimeStr;

-(void)InvestmentWithRID:(NSString *)RID Payment:(NSString *)Payment AllProfit:(NSString *)AllProfit Pwd:(NSString *)Pwd ClientId:(NSString *)ClientId PassValue:(InvestmentDataTollsPassValue)passVallue;

//筛选
-(void)GetAllRaiseWithGoodsType:(NSString *)GoodsType Timelimit:(NSString *)Timelimit State:(NSString *)State PageSize:(NSInteger)PageSize UserID:(NSString *)UserID PassValue:(InvestmentDataTollsPassValue)passVallue;

//关注
-(void)AttentionCollectionWithClientId:(NSString *)ClientId RID:(NSString *)RID IsIsAttention:(NSString *)IsIsAttention PassValue:(InvestmentDataTollsPassValue)passVallue;

@end
