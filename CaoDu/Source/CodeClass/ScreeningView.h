//
//  ScreeningView.h
//  CaoDu
//
//  Created by jang on 16/3/28.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningView : UIView
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UIButton *starTimeButton;
@property (nonatomic,strong)UILabel *starTimeLabel;
@property (nonatomic,strong)UIImageView *starTimeImage;
@property (nonatomic,strong)UIButton *endTimeButton;
@property (nonatomic,strong)UILabel *endTimeLabel;
@property (nonatomic,strong)UIImageView *endTimeImage;
@property (nonatomic,strong)UIButton *emptyButton;
@property (nonatomic,strong)UIButton *determineButton;

@end
