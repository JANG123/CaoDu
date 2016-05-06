//
//  MyInvestmentModle.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MyInvestmentModle.h"

@implementation MyInvestmentModle
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(void)setEndTime:(NSString *)EndTime{
    _EndTime = [NSString stringWithFormat:@"返本日期:%@",[self returnUploadETime:EndTime]];
}

-(void)setMyPrice:(NSString *)MyPrice{
    double p = [MyPrice doubleValue];
    _MyPrice = [NSString stringWithFormat:@"投资金额(元):%.2f",p];
}

-(void)setFundRate:(NSString *)FundRate{
    double f = [FundRate doubleValue];
    _FundRate = [NSString stringWithFormat:@"年化利率:%.1f%%",f*100];
}

-(void)setRepaymentType:(NSString *)RepaymentType{
    _RepaymentType = [NSString stringWithFormat:@"借款类型:%@",RepaymentType];
}

-(void)setTimelimit:(NSString *)Timelimit{
    _Timelimit = [NSString stringWithFormat:@"投资期限(天):%@天",Timelimit];
}

-(void)setWCreateTime:(NSString *)wCreateTime{
    _wCreateTime = [NSString stringWithFormat:@"投资日期:%@",[self returnUploadETime:wCreateTime]];
}

-(void)setExpectProfit:(NSString *)ExpectProfit{
    double e = [ExpectProfit doubleValue];
    _ExpectProfit = [NSString stringWithFormat:@"预计收益:%.2f元",e];
}

- (NSString *) returnUploadETime:(NSString *)timeStr
{
    NSArray *parArray = [timeStr componentsSeparatedByString:@"("];
    
    timeStr = [parArray[1] componentsSeparatedByString:@")"][0];
    
    NSTimeInterval timeInterval = [timeStr doubleValue]/1000;
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    return [dateformatter stringFromDate:date2];
}
@end
