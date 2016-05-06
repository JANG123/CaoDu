//
//  AttentionView.m
//  CaoDu
//
//  Created by jang on 16/4/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "AttentionView.h"

@implementation AttentionView

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
    
    UIImageView *AttentionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 20, 20)];
    AttentionImageView.image = [UIImage imageNamed:@"已关注.png"];
    [self addSubview:AttentionImageView];
    UILabel *AttentionLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 15, 95, 25)];
    AttentionLabel.text = @"关注成功";
    AttentionLabel.font = [UIFont adapterFontOfSize:16.0];
    AttentionLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self addSubview:AttentionLabel];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 45, self.frame.size.width, 35)];
    textLabel.numberOfLines = 0;
    textLabel.text = @"请在""我的账户/关注的项目""\n里进行查看";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont adapterFontOfSize:12.0];
    textLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    [self addSubview:textLabel];
    
    self.backgroundColor = [UIColor whiteColor];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
}

@end
