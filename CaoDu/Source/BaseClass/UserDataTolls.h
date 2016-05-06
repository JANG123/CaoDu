//
//  UserDataTolls.h
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UserDataTollsPassValue)(NSMutableArray *code);

@interface UserDataTolls : NSObject

+(UserDataTolls *)shareGetUserData;

-(void)UserFundJsonWithClientId:(NSString *)ClientId UserPass:(NSString *)UserPass Money:(NSString *)Money type:(NSString *)type PassValue:(UserDataTollsPassValue)passVallue;

-(void)SelectBankWithPassValue:(UserDataTollsPassValue)passVallue;

-(void)MyBankAddJsonWithClientId:(NSString *)ClientId CarType:(NSString *)CarType CarNumber:(NSString *)CarNumber BankID:(NSString *)BankID PassValue:(UserDataTollsPassValue)passVallue;

-(void)GetBankNameWithBankName:(NSString *)BankName PassValue:(UserDataTollsPassValue)passVallue;

-(void)MyInvestmentJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PassValue:(UserDataTollsPassValue)passVallue;

-(void)AttentionProjectJsonWithClientId:(NSString *)ClientId PassValue:(UserDataTollsPassValue)passVallue;

-(void)AttentionCollectionWithClientId:(NSString *)ClientId RID:(NSString *)RID IsIsAttention:(NSString *)IsIsAttention PassValue:(UserDataTollsPassValue)passVallue;

-(void)EarningsJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PassValue:(UserDataTollsPassValue)passVallue;

-(void)UserFundListJsonWithClientId:(NSString *)ClientId PassValue:(UserDataTollsPassValue)passVallue;

-(void)UserFundListJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PassValue:(UserDataTollsPassValue)passVallue;

//我的融资
-(void)MyFinancingJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PageSize:(NSInteger)PageSize PassValue:(UserDataTollsPassValue)passVallue;

@end
