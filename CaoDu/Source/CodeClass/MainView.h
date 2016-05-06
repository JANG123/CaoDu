//
//  MainView.h
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleView.h"
@interface MainView : UIView
// 主循环滚动图
@property (nonatomic,strong)SDCycleScrollView *mainCycleScrollView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)ModuleView *moduleView1;
@property (nonatomic,strong)ModuleView *moduleView2;
@property (nonatomic,strong)ModuleView *moduleView3;

@end
