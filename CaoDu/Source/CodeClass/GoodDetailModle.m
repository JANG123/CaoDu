//
//  GoodDetailModle.m
//  CaoDu
//
//  Created by jang on 16/3/23.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GoodDetailModle.h"

@implementation GoodDetailModle
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setBorrowingRate:(NSString *)BorrowingRate
{
    double borrow =[BorrowingRate doubleValue];
    _BorrowingRateMoney = [NSString stringWithFormat:@"%@",BorrowingRate];
    _BorrowingRate = [NSString stringWithFormat:@"%.2f",borrow*100];
}


-(void)setTimelimit:(NSString *)Timelimit{
    _Timelimit = [NSString stringWithFormat:@"%.0f",[Timelimit doubleValue]/30.0];
}

-(void)setRemainAmount:(NSString *)remainAmount{
    double remain = [remainAmount doubleValue];
    _remainAmount= [NSString stringWithFormat:@"%.0f万元",remain/10000.0];
}

-(void)setPrice:(NSString *)Price{
    double price = [Price doubleValue];
    _Price = [NSString stringWithFormat:@"%.00f万元",price/10000.0];
}

-(void)setMinPrice:(NSString *)minPrice{
    _minPrice = [NSString stringWithFormat:@"%@元",minPrice];
}

-(void)setSumPrice:(NSString *)SumPrice{
    double sum = [SumPrice doubleValue];
    sum = sum/10000.0;
    if (sum > 10.0 || sum <=0) {
        _SumPrice= [NSString stringWithFormat:@"%.0f",sum];
    }else if(sum > 0){
        _SumPrice= [NSString stringWithFormat:@"%.1f",sum];
    }
    
}


@end
