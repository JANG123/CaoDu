//
//  InfoView.h
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InfoCellView;
@interface InfoView : UIView
@property (nonatomic,strong) InfoCellView *titleView;
@property (nonatomic,strong) InfoCellView *cityView;
@property (nonatomic,strong) InfoCellView *sexView;
@property (nonatomic,strong) InfoCellView *typeView;
@property (nonatomic,strong) InfoCellView *timeView;
@property (nonatomic,strong) InfoCellView *nameView;
@property (nonatomic,strong) InfoCellView *phoneView;
@property (nonatomic,strong) InfoCellView *moneyView;
@property (nonatomic,strong) UIButton *checkboxMan;
@property (nonatomic,strong) UIButton *checkboxWoman;
@end
