//
//  MainViewController.h
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@class SDCycleScrollView;
@class ModuleView;
@interface MainViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic,strong)iCarousel *carousel;
@property (nonatomic,strong)SDCycleScrollView *mainCycleScrollView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)ModuleView *moduleView1;

@end
