//
//  UIFont+size.m
//  CaoDu
//
//  Created by jang on 16/4/8.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "UIFont+size.h"

@implementation UIFont (size)

+ (UIFont *)adapterFontOfSize:(CGFloat)fontSize{
    if (kScreenWidth > 375) {
        fontSize = fontSize * 1;
    }
    return [UIFont systemFontOfSize:fontSize];
}

@end
