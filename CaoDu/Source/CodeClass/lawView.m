//
//  lawView.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "lawView.h"

@implementation lawView

+ (lawView *)contentlawView{
    lawView *contentTV = [[lawView alloc] initWithFrame:CGRectZero];
    contentTV.backgroundColor =  Color_back;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(13/PxWidth, 25/PxHeight, kScreenWidth - 26/PxWidth, kScreenHeight - 25/PxHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [contentTV addSubview:backView];
    return contentTV;
}

@end
