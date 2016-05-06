//
//  GoodTableViewCell.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GoodTableViewCell.h"

@implementation GoodTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(18/PxWidth, 10/PxHeight, 100/PxWidth, 20/PxHeight)];
    _titleLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    _titleLabel.font = [UIFont adapterFontOfSize:13.0];
    [self addSubview:_titleLabel];
    _titleLabel.text = @"项目介绍";
    _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(18/PxWidth, CGRectGetMaxY(_titleLabel.frame) + 10/PxHeight, kScreenWidth - CGRectGetMinX(_titleLabel.frame)*2, 60/PxHeight)];
    _detailsLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    _detailsLabel.font = [UIFont adapterFontOfSize:11.0];
    _detailsLabel.numberOfLines = 0;
    _detailsLabel.text = @"项目介绍项目介绍项目介绍项目介绍项目介绍";
    [self addSubview:_detailsLabel];
}

@end
