//
//  InvestmentDataTolls.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InvestmentDataTolls.h"
static InvestmentDataTolls *iData;
@implementation InvestmentDataTolls
+(InvestmentDataTolls *)shareGetInvestmentData{
    static dispatch_once_t once_token;
    if (iData == nil) {
        dispatch_once(&once_token, ^{
            iData = [[InvestmentDataTolls alloc]init];
        });
    }
    return iData;
}

-(void)GetHotBPTIWithPageSize:(NSInteger)PageSize PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?PageSize=%ld",URL_api,URL_GetHotBPTI,PageSize];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *tempArr = [dict objectForKey:@"items"];
        NSMutableArray *inveArr = [NSMutableArray array];
        for (NSDictionary *d in tempArr) {
            InvestmentModle *aInvest = [[InvestmentModle alloc]init];
            aInvest.Price = [d objectForKey:@"Price"];
            aInvest.SumPrice = [d objectForKey:@"SumPrice"];
            
            NSDictionary *tempDict = [d objectForKey:@"BPTIDetail"];
            aInvest.GoodsName = [tempDict objectForKey:@"GoodsName"];
            aInvest.ID = [tempDict objectForKey:@"ID"];
            aInvest.BorrowingRate = [tempDict objectForKey:@"BorrowingRate"];
            aInvest.Timelimit = [tempDict objectForKey:@"Timelimit"];
            aInvest.RepaymentType = [tempDict objectForKey:@"RepaymentType"];
            aInvest.absolutely = [NSString stringWithFormat:@"%f", [[d objectForKey:@"SumPrice"] doubleValue] / [[tempDict objectForKey:@"Price"] doubleValue]];
            aInvest.remainAmount = [NSString stringWithFormat:@"%.0f",[[d objectForKey:@"Price"] doubleValue] - [[d objectForKey:@"SumPrice"] doubleValue]];

            [inveArr addObject:aInvest];
        }
        passVallue(inveArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)BPTIDetailWithID:(NSString *)bpID ClientId:(NSString *)ClientId PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?BID=%@&ClientId=%@",URL_api,URL_BPTIDetail,bpID,ClientId];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *viewDict = [dict objectForKey:@"view"];
        GoodDetailModle *aGoodDetail= [[GoodDetailModle alloc]init];
        aGoodDetail.SumPrice = [NSString stringWithFormat:@"%@",[viewDict objectForKey:@"SumPrice"]];
        NSDictionary *tempDict = [viewDict objectForKey:@"BPTIDetail"];
        aGoodDetail.GoodsName = [tempDict objectForKey:@"GoodsName"];
        aGoodDetail.Price = [tempDict objectForKey:@"Price"];
        aGoodDetail.ID = [tempDict objectForKey:@"ID"];
        aGoodDetail.IsAttention = [tempDict objectForKey:@"IsAttention"];
        aGoodDetail.GoodsDescription = [tempDict objectForKey:@"GoodsDescription"];
        aGoodDetail.Repayment = [tempDict objectForKey:@"Repayment"];
        aGoodDetail.BondData = [tempDict objectForKey:@"BondData"];
        aGoodDetail.Remark = [tempDict objectForKey:@"Remark"];
        aGoodDetail.RiskControl = [tempDict objectForKey:@"RiskControl"];
        aGoodDetail.BorrowingRate = [tempDict objectForKey:@"BorrowingRate"];
        aGoodDetail.Timelimit = [tempDict objectForKey:@"Timelimit"];
        aGoodDetail.RepaymentType = [tempDict objectForKey:@"RepaymentType"];
        
        aGoodDetail.minPrice = [NSString stringWithFormat:@"%@",[tempDict objectForKey:@"minPrice"]];
        aGoodDetail.remainAmount = [NSString stringWithFormat:@"%d",(int)([[tempDict objectForKey:@"Price"] doubleValue] - [[viewDict objectForKey:@"SumPrice"] doubleValue])];
        aGoodDetail.absolutely = [NSString stringWithFormat:@"%f", [[viewDict objectForKey:@"SumPrice"] doubleValue] / [[tempDict objectForKey:@"Price"] doubleValue]];
        //NSString *CreateTime = [tempDict objectForKey:@"EndTime"];
        NSString *EnddateString = [tempDict objectForKey:@"EndTime"];
        aGoodDetail.endTime = [self returnUploadEndTime:EnddateString];
        aGoodDetail.RepaymentDate = [tempDict objectForKey:@"RepaymentDate"];
        aGoodDetail.PriceUrl = [tempDict objectForKey:@"Price"];
        aGoodDetail.TimelimitUrl = [tempDict objectForKey:@"Timelimit"];
        aGoodDetail.FundRate = [[viewDict objectForKey:@"RecordList"] objectForKey:@"FundRate"];
        aGoodDetail.RID = [tempDict objectForKey:@"RID"];
        aGoodDetail.Payment = [tempDict objectForKey:@"Payment"];
        aGoodDetail.AllProfit = [[viewDict objectForKey:@"RecordList"] objectForKey:@"AllProfit"];
        NSMutableArray *GoodArr = [NSMutableArray array];
        [GoodArr addObject:aGoodDetail];
        passVallue(GoodArr);

        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)PubLishBondWithID:(BondModle *)Bond PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&UserName=%@&UserSex=%@&UserPhone=%@&Price=%@&GoodsName=%@&GoodsID=%@&Address=%@&Timelimit=%@",URL_api,URL_PubLishBond,Bond.ClientId,Bond.UserName,Bond.UserSex,Bond.UserPhone,Bond.Price,Bond.GoodsName,Bond.GoodsID,Bond.Address,Bond.Timelimit];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *code = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ReturnValue"]];
        NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:code, nil];
        passVallue(tempArr);
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)BRaiseListWithID:(NSString *)bpID PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?BID=%@",URL_api,URL_BRaiseList,bpID];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *itemsArr = [dict objectForKey:@"items"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *d in itemsArr) {
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:[d objectForKey:@"BuyerUser"]];
            [temp addObject:[d objectForKey:@"Timelimit"]];
            [temp addObject:[d objectForKey:@"Price"]];
            [temp addObject:[d objectForKey:@"ExpectProfit"]];
            [tempArr addObject:temp];
        }
        passVallue(tempArr);
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)GetRepaymentPlanWithRepaymentDate:(NSString *)RepaymentDate FundRate:(NSString *)fundRate Timelimit:(NSString *)timelimit Price:(NSString *)price PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?RepaymentDate=%@&FundRate=%@&Timelimit=%@&Price=%@",URL_api,URL_GetRepaymentPlan,RepaymentDate,fundRate,timelimit,price];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *itemsArr = [dict objectForKey:@"items"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *d in itemsArr) {
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:[d objectForKey:@"BuyerUser"]];
            [temp addObject:[d objectForKey:@"Timelimit"]];
            [temp addObject:[d objectForKey:@"Price"]];
            [temp addObject:[d objectForKey:@"ExpectProfit"]];
            [tempArr addObject:temp];
        }
        passVallue(tempArr);
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


-(void)InvestmentWithRID:(NSString *)RID Payment:(NSString *)Payment AllProfit:(NSString *)AllProfit Pwd:(NSString *)Pwd ClientId:(NSString *)ClientId PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?RID=%@&Payment=%@&AllProfit=%@&Pwd=%@&ClientId=%@",URL_api,URL_Investment,RID,Payment,AllProfit,Pwd,ClientId];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        NSMutableArray *tempArr = [NSMutableArray arrayWithObject:code];
        [[LoginRegistDateTolls shareGetLoginRegistDate] MyPersonalWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID];
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}

//筛选
-(void)GetAllRaiseWithGoodsType:(NSString *)GoodsType Timelimit:(NSString *)Timelimit State:(NSString *)State PageSize:(NSInteger)PageSize UserID:(NSString *)UserID PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?Timelimit=%@&State=%@&PageSize=%ld&UserID=%@",URL_api,URL_GetAllRaise,Timelimit,State,PageSize,UserID];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *tempArr = [dict objectForKey:@"items"];
        NSMutableArray *inveArr = [NSMutableArray array];
        for (NSDictionary *d in tempArr) {
            InvestmentModle *aInvest = [[InvestmentModle alloc]init];
            aInvest.Price = [d objectForKey:@"Price"];
            aInvest.SumPrice = [d objectForKey:@"SumPrice"];
            aInvest.GoodsName = [d objectForKey:@"GoodsName"];
            aInvest.ID = [d objectForKey:@"ID"];
            aInvest.BorrowingRate = [d objectForKey:@"BorrowingRate"];
            aInvest.Timelimit = [d objectForKey:@"Timelimit"];
            aInvest.RepaymentType = [d objectForKey:@"RepaymentType"];
            aInvest.absolutely = [NSString stringWithFormat:@"%f", [[d objectForKey:@"SumPrice"] doubleValue] / [[d objectForKey:@"Price"] doubleValue]];
            aInvest.remainAmount = [NSString stringWithFormat:@"%.0f",[[d objectForKey:@"Price"] doubleValue] - [[d objectForKey:@"SumPrice"] doubleValue]];
            
            [inveArr addObject:aInvest];
        }
        passVallue(inveArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//关注
-(void)AttentionCollectionWithClientId:(NSString *)ClientId RID:(NSString *)RID IsIsAttention:(NSString *)IsIsAttention PassValue:(InvestmentDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&RID=%@&IsIsAttention=%@",URL_api,URL_AttentionCollection,ClientId,RID,IsIsAttention];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *inveArr = [NSMutableArray array];
        [inveArr addObject:[dict objectForKey:@"ReturnValue"]];
        passVallue(inveArr);
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


/*处理返回应该显示的时间*/
- (NSString *) returnUploadEndTime:(NSString *)endtimeStr
{
    NSArray *parArray = [endtimeStr componentsSeparatedByString:@"("];
    
    endtimeStr = [parArray[1] componentsSeparatedByString:@")"][0];
    
    NSTimeInterval late = [endtimeStr doubleValue]/1000;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=late-now;
    if (cha<0) {
        timeString=@"已结束";
        
    }else
    {
        double day = cha/5184000;
        NSString *dayStr = [[NSString stringWithFormat:@"%.1f", day] componentsSeparatedByString:@"."][0];
        double hours = (cha - [dayStr doubleValue]*5184000)/216000;
        NSString *hoursStr = [[NSString stringWithFormat:@"%.1f", hours] componentsSeparatedByString:@"."][0];
        double minutes = (cha - [dayStr doubleValue]*5184000 - [hoursStr doubleValue]*216000)/3600;
        NSString *minutesStr = [NSString stringWithFormat:@"%.0f", minutes];
        timeString=[NSString stringWithFormat:@"%@天%@小时%@分钟", dayStr,hoursStr,minutesStr];
    }
    return timeString;
}

/*处理返回应该显示的时间*/
- (NSString *) returnPoorTime:(NSString *)CreatetimeStr Time:(NSString *)endtimeStr
{
    NSArray *parArray1 = [CreatetimeStr componentsSeparatedByString:@"("];
    
    CreatetimeStr = [parArray1[1] componentsSeparatedByString:@")"][0];
    
    NSArray *parArray = [endtimeStr componentsSeparatedByString:@"("];
    
    endtimeStr = [parArray[1] componentsSeparatedByString:@")"][0];
    
    double day = ([endtimeStr doubleValue]/1000 -  [CreatetimeStr doubleValue]/1000)/5184000;
    NSString *timeString = [[NSString stringWithFormat:@"%.1f", day] componentsSeparatedByString:@"."][0];
    timeString = [NSString stringWithFormat:@"%@天",timeString];
    
    return timeString;
}

@end
