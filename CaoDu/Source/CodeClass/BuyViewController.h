//
//  BuyViewController.h
//  CaoDu
//
//  Created by jang on 16/3/24.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyViewController : UIViewController{
    UILabel *titleLabel;
    UILabel *rateLabel;
    UILabel *allLabel;
    UILabel *timeLabel;
    UITextField *moneyTextField;
    UITextField *pwTextField;
}
@property (nonatomic,strong)GoodDetailModle *aGoodDetail;
@property (nonatomic,strong)UIButton *buyButton;
@end
