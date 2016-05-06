//
//  InvestmentModle.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InvestmentModle.h"

@implementation InvestmentModle
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setBorrowingRate:(NSString *)BorrowingRate
{
    _BorrowingRateMoney = [NSString stringWithFormat:@"%@",BorrowingRate];
    double borrow =[BorrowingRate doubleValue];
    _BorrowingRate = [NSString stringWithFormat:@"%.2f%%",borrow*100];
}


-(void)setTimelimit:(NSString *)Timelimit{
    _Timelimit = [NSString stringWithFormat:@"%@",Timelimit];
}

-(void)setPrice:(NSString *)Price{
    double price = [Price doubleValue];
    _Price = [NSString stringWithFormat:@"%.0f万元",price/10000];
}


@end
