//
//  PickCityViewController.h
//  CaoDu
//
//  Created by jang on 16/3/31.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickCityViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate>{
    UIPickerView *picker;
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    UIAlertController *alert;
    
    BOOL isSelect;
    
    BOOL pickBool;
    
    NSInteger GoodsID;
    
    NSInteger Timelimit;
}

- (void) buttobClicked: (id)sender;


@end
