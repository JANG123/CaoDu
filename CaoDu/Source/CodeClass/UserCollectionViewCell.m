//
//  UserCollectionViewCell.m
//  CaoDu
//
//  Created by jang on 16/3/18.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "UserCollectionViewCell.h"

@implementation UserCollectionViewCell


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
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)*0.38, 0.24*CGRectGetHeight(self.frame), 31/PxWidth, 31/PxWidth)];
    [self addSubview:_logoImageView];
    
    _textLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logoImageView.frame) + 8/PxHeight, CGRectGetWidth(self.frame), 15/PxHeight)];
    _textLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    _textLable.font = [UIFont adapterFontOfSize:14.0];
    _textLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLable];
}

@end
