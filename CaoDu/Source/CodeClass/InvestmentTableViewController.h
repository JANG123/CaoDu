//
//  InvestmentTableViewController.h
//  CaoDu
//
//  Created by jang on 16/3/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestmentTableViewController : UITableViewController{
    NSString *goodTypeStr;
    NSString *goodStateStr;
    NSString *timelimitStr;
    NSInteger PageSize;
    NSInteger resultPageSize;
}

@end
