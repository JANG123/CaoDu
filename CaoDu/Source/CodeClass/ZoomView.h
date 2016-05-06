//
//  ZoomView.h
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomView : UIView
@property (nonatomic,strong)UILabel *squareLabel;
@property (nonatomic,strong)UILabel *textLabel;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)textLable;

@end
