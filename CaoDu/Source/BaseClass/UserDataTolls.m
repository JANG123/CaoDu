//
//  UserDataTolls.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "UserDataTolls.h"
static UserDataTolls *uData;
@implementation UserDataTolls

+(UserDataTolls *)shareGetUserData{
    static dispatch_once_t once_token;
    if (uData == nil) {
        dispatch_once(&once_token, ^{
            uData = [[UserDataTolls alloc]init];
        });
    }
    return uData;
}

-(void)UserFundJsonWithClientId:(NSString *)ClientId UserPass:(NSString *)UserPass Money:(NSString *)Money type:(NSString *)type PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&UserPass=%@&Money=%@&type=%@",URL_api,URL_UserFundJson,ClientId,UserPass,Money,type];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        NSMutableArray *tempArr = [NSMutableArray arrayWithObject:code];
        passVallue(tempArr);
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)SelectBankWithPassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",URL_api,URL_SelectBank];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *tempArr = (NSMutableArray *)[dict objectForKey:@"items"];
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)MyBankAddJsonWithClientId:(NSString *)ClientId CarType:(NSString *)CarType CarNumber:(NSString *)CarNumber BankID:(NSString *)BankID PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&CarType=%@&CarNumber=%@&BankID=%@",URL_api,URL_MyBankAddJson,ClientId,CarType,CarNumber,BankID];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *tempArr = (NSMutableArray *)[dict objectForKey:@"items"];
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)GetBankNameWithBankName:(NSString *)BankName PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?BankName=%@",URL_api,URL_GetBankName,BankName];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSString *error = [dict objectForKey:@"error"];
        NSString *Name = [dict objectForKey:@"ReturnMsg"];
        NSMutableArray *tempArr = [NSMutableArray array];
        if (error.length>0) {
            [tempArr addObject:error];
        }else {
            [tempArr addObject:Name];
        }
        
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)MyInvestmentJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&BeginTime=%@&EndTime=%@&PageSize=1000",URL_api,URL_MyInvestmentJson,ClientId,BeginTime,EndTime];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = [dict objectForKey:@"items"];
        NSMutableArray *arrIng = [NSMutableArray array];
        NSMutableArray *arrEd = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            MyInvestmentModle *myModle = [[MyInvestmentModle alloc]init];
            [myModle setValuesForKeysWithDictionary:dict];
            if ([myModle.State isEqualToString:@"招标中"]) {
                [arrIng addObject:myModle];
            }else{
                [arrEd addObject:myModle];
            }
            
        }
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObject:arrIng];
        [tempArr addObject:arrEd];
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)AttentionProjectJsonWithClientId:(NSString *)ClientId PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@",URL_api,URL_AttentionProjectJson,ClientId];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = [dict objectForKey:@"items"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            AttentionProjectModle *attention = [[AttentionProjectModle alloc]init];
            [attention setValuesForKeysWithDictionary:dict];
            [tempArr addObject:attention];
        }
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)AttentionCollectionWithClientId:(NSString *)ClientId RID:(NSString *)RID IsIsAttention:(NSString *)IsIsAttention PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&RID=%@&IsIsAttention=%@",URL_api,URL_AttentionCollection,ClientId,RID,IsIsAttention];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        NSString *code = [dict objectForKey:@"ReturnValue"];
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObject:code];
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)EarningsJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&BeginTime=%@&EndTime=%@",URL_api,URL_EarningsJson,ClientId,BeginTime,EndTime];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = [dict objectForKey:@"items"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            NSMutableArray *earArr = [NSMutableArray array];
            [earArr addObject:[dict objectForKey:@"wCreateTime"]];
            [earArr addObject:[dict objectForKey:@"BackMoney"]];
            [earArr addObject:[dict objectForKey:@"Price"]];
            [tempArr addObject:earArr];
        }
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//资金明细
-(void)UserFundListJsonWithClientId:(NSString *)ClientId PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&PageSize=1000",URL_api,URL_UserFundListJson,ClientId];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = [dict objectForKey:@"items"];
        NSMutableArray *arrIn = [NSMutableArray array];
        NSMutableArray *arrOut = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            MoneyModle *mModle = [[MoneyModle alloc]init];
            [mModle setValuesForKeysWithDictionary:dict];
            if ([mModle.IOpId isEqualToString:@"入金"]) {
                [arrIn addObject:mModle];
            }else if ([mModle.IOpId isEqualToString:@"出金"]){
                [arrOut addObject:mModle];
            }else{
            
            }
        }
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObject:arrIn];
        [tempArr addObject:arrOut];
        passVallue(tempArr);

    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


-(void)UserFundListJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&BeginTime=%@&EndTime=%@&PageSize=1000",URL_api,URL_UserFundListJson,ClientId,BeginTime,EndTime];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = [dict objectForKey:@"items"];
        NSMutableArray *arrIn = [NSMutableArray array];
        NSMutableArray *arrOut = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            MoneyModle *mModle = [[MoneyModle alloc]init];
            [mModle setValuesForKeysWithDictionary:dict];
            if ([mModle.IOpId isEqualToString:@"入金"]) {
                [arrIn addObject:mModle];
            }else if ([mModle.IOpId isEqualToString:@"出金"]){
                [arrOut addObject:mModle];
            }else{
                
            }
        }
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObject:arrIn];
        [tempArr addObject:arrOut];
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}

-(void)MyFinancingJsonWithClientId:(NSString *)ClientId BeginTime:(NSString *)BeginTime EndTime:(NSString *)EndTime PageSize:(NSInteger)PageSize PassValue:(UserDataTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&BeginTime=%@&EndTime=%@&PageSize=%ld",URL_api,URL_MyFinancingJson,ClientId,BeginTime,EndTime,PageSize];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"items"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *d in array) {
            MyFinancingModle *myFinancing = [[MyFinancingModle alloc]init];
            [myFinancing setValuesForKeysWithDictionary:d];
            [tempArr addObject:myFinancing];
        }
        passVallue(tempArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}



@end
