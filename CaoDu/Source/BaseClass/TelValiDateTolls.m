//
//  TelValiDateTolls.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "TelValiDateTolls.h"
static TelValiDateTolls *tData;
@implementation TelValiDateTolls


+(TelValiDateTolls *)shareGetTelValiDate
{
    static dispatch_once_t once_token;
    if (tData == nil) {
        dispatch_once(&once_token, ^{
            tData = [[TelValiDateTolls alloc]init];
        });
    }
    return tData;
}

-(void)validateNumWithPhoneNum:(NSString *)num PassValue:(TelValiPassValue)passValue{
    
    
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?Account=%@",URL_api,URL_ValidateNum,num];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *code = [dict objectForKey:@"error"];
        
        passValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

-(void)telValiDataWithPhoneNum:(NSString *)num PassValue:(TelValiPassValue)passValue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?TelName=%@",URL_api,URL_TelValidate,num];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *code = [dict objectForKey:@"TelNum"];
        
        passValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
