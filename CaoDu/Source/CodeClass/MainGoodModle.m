//
//  MainGoodModle.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MainGoodModle.h"

@implementation MainGoodModle
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

- (void)setBorrowingRate:(NSString *)BorrowingRate
{
    double borrow =[BorrowingRate doubleValue];
    _rate = borrow;
    _BorrowingRate = [NSString stringWithFormat:@"%.2f%%",borrow*100];
}

-(void)setMinPrice:(NSString *)minPrice{
    
    _minPrice = [NSString stringWithFormat:@"¥%@",minPrice];
}

-(void)setTimelimit:(NSString *)Timelimit{
    _Timelimit = [NSString stringWithFormat:@"%@天",Timelimit];
}

-(void)setPrice:(NSString *)Price{
    double price = [Price doubleValue];
    _Price = [NSString stringWithFormat:@"%.0f万元",price/10000];
}
@end
