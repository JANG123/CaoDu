//
//  GoodView.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GoodView.h"
#import "GoodDetailsView.h"
@implementation GoodView

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
    _gdVC = [[GoodDetailsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 475/PxHeight)];
    [self addSubview:_gdVC];
}

@end
