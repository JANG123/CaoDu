//
//  MainTabController.h
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabController : UITabBarController
@property (strong, nonatomic) UINavigationController *navBarController1;
@property (strong, nonatomic) UINavigationController *navBarController2;
@property (strong, nonatomic) UINavigationController *navBarController3;
@property (strong, nonatomic) UINavigationController *navBarController4;
@property (strong, nonatomic) UINavigationController *navBarController5;
@property(nonatomic,assign)BOOL isSetting;
@end
