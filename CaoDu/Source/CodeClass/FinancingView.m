//
//  FinancingView.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FinancingView.h"
#import "FinHeadView.h"
@implementation FinancingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    _fhView = [[FinHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80/PxHeight)];
    [self addSubview:_fhView];
}

@end
