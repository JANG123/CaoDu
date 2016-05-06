//
//  FinancingViewController.h
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@interface FinancingViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate>{
    UIPickerView *picker;
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    UIAlertController *alert;
    
    BOOL isSelect;
    
    NSString *pickType;
    
    NSInteger GoodsID;
    
    NSInteger Timelimit;
    
    NSMutableArray *timeArr;
    
    UITextField *beforeTextField;
}

- (void) buttobClicked: (id)sender;

@end
