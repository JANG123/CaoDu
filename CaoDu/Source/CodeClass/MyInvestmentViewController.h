//
//  MyInvestmentViewController.h
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInvestmentViewController : UIViewController{
    BOOL isSelected;
    UIView *headView;
    UILabel *goodsNameLable;
    UILabel *priceLable;
    UILabel *fundRateLable;
    UILabel *timelimitLable;
    UILabel *repaymentTypelable;
    UIButton *datePickButton;
    UIImageView * logoImageView;
    UILabel *textLabel;
    UIButton *invButton;
}

@end
