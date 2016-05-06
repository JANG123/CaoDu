//
//  MainDateTolls.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MainDateTolls.h"
static MainDateTolls *mData;
@implementation MainDateTolls
+(MainDateTolls *)shareGetMainDateTollsDate
{
    static dispatch_once_t once_token;
    if (mData == nil) {
        dispatch_once(&once_token, ^{
            mData = [[MainDateTolls alloc]init];
        });
    }
    return mData;
}

-(void)cycleScrollWithMainDateTollsPassValue:(MainDateTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",URL_api,URL_AdvertiseList];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *tempArr = [dict objectForKey:@"items"];
        NSMutableArray *imageArr = [NSMutableArray array];
        for (NSDictionary *d in tempArr) {
            NSString *imageString = [NSString stringWithFormat:@"%@%@",URL_api,[[d objectForKey:@"Image"] substringFromIndex:1]];
            [imageArr  addObject:imageString];
        }
        passVallue(imageArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)GetAllRaiseWithMainDateTollsPassValue:(MainDateTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?Timelimit=-1&IsRecommended=true",URL_api,URL_GetAllRaise];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *tempArr = [dict objectForKey:@"items"];
        NSMutableArray *AllRaiseArr = [NSMutableArray array];
        for (NSDictionary *d in tempArr) {
            MainGoodModle *aMainGood = [[MainGoodModle alloc]init];
            [aMainGood setValuesForKeysWithDictionary:d];
            [AllRaiseArr addObject:aMainGood];
        }
        passVallue(AllRaiseArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


-(void)SelectNewsWithMainDateTollsPassValue:(MainDateTollsPassValue)passVallue{
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?Id=0",URL_api,URL_SelectNews];
    //2.发起请求
    [manager GET:urlString parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *tempArr = [dict objectForKey:@"items"];
        NSMutableArray *SelectNewsArr = [NSMutableArray array];
        for (NSDictionary *d in tempArr) {
            NewsModle *aNews = [[NewsModle alloc]init];
            aNews.NContent = [d objectForKey:@"NContent"];
            aNews.Title = [d objectForKey:@"Title"];
            aNews.timeStr = [self returnUploadETime:[d objectForKey:@"BeginTime"]];
            [SelectNewsArr addObject:aNews];
        }
        passVallue(SelectNewsArr);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

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
