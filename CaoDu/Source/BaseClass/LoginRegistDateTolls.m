//
//  LoginRegistDateTolls.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "LoginRegistDateTolls.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
static LoginRegistDateTolls *lData;
@implementation LoginRegistDateTolls
+(LoginRegistDateTolls *)shareGetLoginRegistDate
{
    static dispatch_once_t once_token;
    if (lData == nil) {
        dispatch_once(&once_token, ^{
            lData = [[LoginRegistDateTolls alloc]init];
        });
    }
    return lData;
}

-(void)registWithRegist:(RegisteredModle *)aRegist LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?InviteCode=%@&PassWord=%@&Tel=%@",URL_api,URL_InsertClientInfo,aRegist.InviteCode,aRegist.PassWord,aRegist.Tel];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        loginRegistPassValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)LoginWithTel:(NSString *)tel PassWord:(NSString *)pw LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue{
    
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *ipString = [NetWorkTolls getIPAddress];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientID=%@&PassWord=%@&IP=%@&w_Address=%@",URL_api,URL_Login,tel,pw,ipString,nil];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        if ([code isEqualToString:@"0"]) {
            UserModle *aUser = [[UserModle alloc]init];
            [aUser setValuesForKeysWithDictionary:[dict objectForKey:@"view"]];
            [[UserAccount shareGetUserAccountDate] setValue:aUser forKey:@"aUser"];
            [self MyPersonalWithClientId:aUser.ClientID];
        }
        loginRegistPassValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)ResetPasswordWith:(NSString *)tel PassWord:(NSString *)newPw LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?Tel=%@&Email=%@&NewPassword=%@",URL_api,URL_ResetPassword,tel,nil,newPw];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        loginRegistPassValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)MyPersonalWithClientId:(NSString *)ClientId{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@",URL_api,URL_MyPersonal,ClientId];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

        
        NSDictionary *tempDict = [dict objectForKey:@"items"];

        [UserAccount shareGetUserAccountDate].aUser.MyFund = [numberFormatter stringFromNumber:[tempDict valueForKey:@"MyFund"][0]];
        [UserAccount shareGetUserAccountDate].aUser.WaitingMoney = [numberFormatter stringFromNumber:[tempDict valueForKey:@"WaitingMoney"][0]];
        
        [[UserAccount shareGetUserAccountDate].WaitingMoney addObserver:self forKeyPath:@"login" options:NSKeyValueObservingOptionNew context:nil];
        [[UserAccount shareGetUserAccountDate] setValue:[numberFormatter stringFromNumber:[tempDict valueForKey:@"WaitingMoney"][0]] forKey:@"WaitingMoney"];
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)UserPassWithClientId:(NSString *)ClientId PassWord:(NSString *)Password  NewPassword:(NSString *)NewPassword LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?ClientId=%@&Password=%@&NewPassword=%@",URL_api,URL_UserPass,ClientId,Password,NewPassword];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        loginRegistPassValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}
-(void)ResetFundpassWithClientId:(NSString *)ClientId NewPassword:(NSString *)NewPassword LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?UserId=%@&NewPassword=%@",URL_api,URL_ResetFundpass,ClientId,NewPassword];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSNumber *longNumber = [NSNumber numberWithLong:[[dict objectForKey:@"ReturnValue"] longLongValue]];
        NSString *code = [longNumber stringValue];
        loginRegistPassValue(code);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
@end
