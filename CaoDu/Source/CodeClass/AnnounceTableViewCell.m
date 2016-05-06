//
//  AnnounceTableViewCell.m
//  CaoDu
//
//  Created by jang on 16/3/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "AnnounceTableViewCell.h"

@implementation AnnounceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.backgroundColor = Color_back;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(13/PxWidth, 0, kScreenWidth - 26/PxWidth, 65/PxHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    _annImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10/PxWidth, 10/PxWidth, 45/PxWidth, 45/PxWidth)];
    _annImageView.backgroundColor = [UIColor redColor];
    [backView addSubview:_annImageView];
    
    _annLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.annImageView.frame) + 10/PxWidth, CGRectGetMinY(self.annImageView.frame)-10/PxHeight, kScreenWidth*2/3, 50/PxHeight)];
    //_annLabel.text = @"草都牧草";
    _annLabel.numberOfLines = 0;
    _annLabel.font = [UIFont adapterFontOfSize: 14.0];
    _annLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    [backView addSubview:_annLabel];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.annImageView.frame) + 10/PxWidth, CGRectGetMaxY(self.annImageView.frame) - 8/PxWidth, kScreenWidth/3, 10/PxHeight)];
    _date.text = @"2016-01-10";
    _date.font = [UIFont adapterFontOfSize: 10.0];
    _date.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [backView addSubview:_date];
    
    _messImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backView.frame) - 36/PxWidth, 0, 36/PxWidth, 36/PxWidth)];
    [_messImageView setImage:[UIImage imageNamed:@"NEW.png"]];
    [backView addSubview:_messImageView];
}

@end
