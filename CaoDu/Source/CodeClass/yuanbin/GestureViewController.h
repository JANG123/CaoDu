//
//  GestureViewController.h
//  Gesture
//
//  Created by 袁斌 on 15/11/7.
//  Copyright © 2015年 yinbanke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureView.h"


@interface GestureViewController : UIViewController

-(instancetype)initWithCaseMode:(CaseMode)caseMode;
/**
 *  情况：
 */
@property(nonatomic,assign)BOOL isFormer;

/**
 *  登录or关闭：
 */
@property(nonatomic,assign)BOOL isLogin;

/**
 *  进入前台
 */
@property(nonatomic,strong)NSString *EnterBackground;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com