//
//  InviteView.m
//  CaoDu
//
//  Created by jang on 16/4/12.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InviteView.h"

@implementation InviteView

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
    self.backgroundColor = Color_back;
    self.processImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 175/PxHeight)];
    self.processImageView.image = [UIImage imageNamed:@"邀请流程.png"];
    [self addSubview:_processImageView];
    
    self.detaileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_processImageView.frame) + 10/PxHeight, kScreenWidth, 185/PxHeight)];
    self.detaileImageView.image = [UIImage imageNamed:@"首次邀请奖.png"];
    [self addSubview:_detaileImageView];
    
    self.recordView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_detaileImageView.frame) + 10/PxHeight, kScreenWidth, 50/PxHeight)];
    self.recordView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_recordView];
    self.recordTitle = [[UILabel alloc]initWithFrame:CGRectMake(10/PxHeight, 0, kScreenWidth/3 - 10/PxHeight, CGRectGetHeight(_recordView.frame))];
    self.recordTitle.text = @"●  我的战绩";
    self.recordTitle.font = [UIFont adapterFontOfSize:15.0];
    self.recordTitle.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self.recordView addSubview:_recordTitle];
    
    self.recordDetaile = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_recordTitle.frame), 0, kScreenWidth*2/3 - 10/PxHeight, CGRectGetHeight(_recordView.frame))];
    self.recordDetaile.text = @"邀请过0人，交易0人";
    self.recordDetaile.textAlignment = NSTextAlignmentRight;
    self.recordDetaile.font = [UIFont adapterFontOfSize:15.0];
    self.recordDetaile.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.recordView addSubview:_recordDetaile];
    NSLog(@"%f",self.frame.size.height - CGRectGetMaxY(_recordView.frame));
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(0,CGRectGetMaxY(_recordView.frame) + 10/PxHeight, kScreenWidth, self.frame.size.height - CGRectGetMaxY(_recordView.frame) - 10/PxHeight);
    [self.sendButton setTitle:@"发送邀请链接" forState:UIControlStateNormal];
    _sendButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self addSubview:_sendButton];
    
}

@end
