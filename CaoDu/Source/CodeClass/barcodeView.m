//
//  barcodeView.m
//  CaoDu
//
//  Created by jang on 16/4/12.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "barcodeView.h"

@implementation barcodeView

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
    self.backgroundColor = [UIColor clearColor];
    self.codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 200/PxHeight)/2, 37/PxHeight, 200/PxHeight, 200/PxHeight)];
    self.codeImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_codeImageView];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_codeImageView.frame) - 30/PxWidth,CGRectGetMaxY(_codeImageView.frame) + 15/PxHeight, kScreenWidth - CGRectGetMinX(_codeImageView.frame)*2 + 60/PxWidth, 50/PxHeight)];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont adapterFontOfSize:13.0];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    self.textLabel.text = @"邀请好友扫描上方的二维码，\n完成注册并交易，您将获得红包奖励";
    [self addSubview:_textLabel];
}

@end
