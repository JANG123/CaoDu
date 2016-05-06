//
//  MyFinancingViewController.h
//  CaoDu
//
//  Created by jang on 16/4/1.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFinancingViewController : UIViewController{
    UIScrollView *backSCrollView;
    UIView *headView;
    UILabel *applyTimeLable;
    UILabel *goodNameLable;
    UILabel *investTimeLable;
    UILabel *reimburseTimeLable;
    UILabel *rateLable;
    UILabel *moneyLable;
    UILabel *stateLable;
    UIButton *operationButton;
    NSString *BeginTime;
    NSString *EndTime;
    NSInteger PageSize;
}

@end
