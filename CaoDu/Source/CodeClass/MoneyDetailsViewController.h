//
//  MoneyDetailsViewController.h
//  CaoDu
//
//  Created by jang on 16/3/26.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyDetailsViewController : UIViewController{
    NSInteger isSelected;
    UIView *headView;
    UILabel *goodsNameLable;
    UILabel *priceLable;
    UILabel *fundRateLable;
    UILabel *timelimitLable;
    UILabel *repaymentTypelable;
}

@end
