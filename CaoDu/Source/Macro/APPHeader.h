//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h

#import "MainTabController.h"
#import "MoreViewController.h"
#import "UserViewController.h"
#import "FinancingViewController.h"
#import "InvestmentTableViewController.h"
#import "MainViewController.h"
#import "TextTypeView.h"
#import "TelValiDateTolls.h"
#import "MainTabController.h"
#import "LoginViewController.h"



/**
 * DataTool
 */
#import "LoginRegistDateTolls.h"
#import "NetWorkTolls.h"
#import "UserAccount.h"
#import "UserModle.h"
#import "MainDateTolls.h"
#import "InvestmentDataTolls.h"
#import "UserDataTolls.h"
#import "GesturesDataTolls.h"

/**
 * Modle
 */

#import "RegisteredModle.h"
#import "MainGoodModle.h"
#import "NewsModle.h"
#import "InvestmentModle.h"
#import "BondModle.h"
#import "GoodDetailModle.h"
#import "MyInvestmentModle.h"
#import "AttentionProjectModle.h"
#import "MoneyModle.h"
#import "MyFinancingModle.h"



/**
 * 状态栏宽高
 */
#define kStatusHeight      [[UIApplication sharedApplication] statusBarFrame].size.height

// 导航栏（navigationbar）
#define kRectNavHeight     self.navigationController.navigationBar.frame.size.height

#define KFontColor_NavWhite [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];

#define KFontColor_NavBlackColor [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];

/**
 * 当前设备的屏幕X
 */
#define SCREEN_X   [[UIScreen mainScreen] bounds].origin.x

/**
 * 当前设备的屏幕Y
 */
#define SCREEN_Y   [[UIScreen mainScreen] bounds].origin.y

/**
 * 当前设备的屏幕宽高
 */
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height


#define PxWidth (375/kScreenWidth)
#define PxHeight (667/kScreenHeight)


#define KboundsWidth          self.bounds.size.width
#define KboundsHeight        self.bounds.size.height


#define SystemVersion [[[UIDevice currentDevice] systemVersion] doubleValue]


/**
 * 导航栏 标题字体
 */
#define Font_NavBarTitel [UIFont boldsystemFontOfSize:16]

/**
 * 导航栏 默认背景颜色
 */
#define Color_NavBar_BACKGROUND  [UIColor colorWithRed:0.11 green:0.68 blue:0.75 alpha:1]

/**
 * 导航栏 标题颜色
 */
#define Color_NavBarTitel  [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]

/**
 * 青色颜色
 */
#define Color_Cyan  [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0]

/**
 * Alert字体颜色
 */
#define Color_Alert  [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0]

/**
 * 导航栏 标题字体
 */
#define Font_NavBarTitel [UIFont boldsystemFontOfSize:16]

/**
 * 项目字体颜色
 */
#define Font_Color  [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0]

#define Font_SELECT_Color  [UIColor colorWithRed:255/255.0 green:155/255.0 blue:2/255.0 alpha:1.0]

#define Color_back [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0]














































//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif
