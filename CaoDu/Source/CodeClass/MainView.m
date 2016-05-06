//
//  MainView.m
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MainView.h"

@implementation MainView

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
    self.backgroundColor = [UIColor whiteColor];
    
    double width = 750;
    double height = 1334;

    // 主循环滚动图
    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"banner1.jpg"],[UIImage imageNamed:@"banner2.jpg"],[UIImage imageNamed:@"banner1.jpg"], nil];
    _mainCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150/PxHeight) imagesGroup:tempArr];
    [self addSubview:_mainCycleScrollView];
    
    //主界面view
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainCycleScrollView.frame), kScreenWidth, kScreenHeight - CGRectGetHeight(self.mainCycleScrollView.frame) - 44)];
    [self addSubview:_mainScrollView];
    
    _mainScrollView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth*3, kScreenHeight - CGRectGetHeight(self.mainCycleScrollView.frame) - 44);
    
    _mainScrollView.pagingEnabled = YES;
    //显示水平方向滚动条，默认YES
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    
    //显示垂直方向滚动条，默认YES
    _mainScrollView.showsVerticalScrollIndicator = NO;
    
    //遇到水平边框是否反弹
    _mainScrollView.alwaysBounceHorizontal = YES;
    
    
    _moduleView1 = [[ModuleView alloc]initWithFrame:CGRectMake(70/width*KboundsWidth, 20, 610/width*KboundsWidth, 770/height*KboundsHeight)];
    [self.mainScrollView addSubview:_moduleView1];
    
    [_moduleView1.layer setMasksToBounds:YES];
    [_moduleView1.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
}
@end
