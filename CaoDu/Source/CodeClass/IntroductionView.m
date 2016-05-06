//
//  IntroductionView.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "IntroductionView.h"

@implementation IntroductionView

+ (IntroductionView *)contentIntroductionView{
    IntroductionView *contentTV = [[IntroductionView alloc] initWithFrame:CGRectZero];
    contentTV.backgroundColor =  [UIColor redColor];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(13/PxWidth, 25/PxHeight, kScreenWidth - 26/PxWidth, 343/PxHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [contentTV addSubview:backView];
    
    
    return contentTV;
}

@end
