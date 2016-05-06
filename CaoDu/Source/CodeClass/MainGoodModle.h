//
//  MainGoodModle.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainGoodModle : NSObject
@property (nonatomic,strong)NSString *GoodsName;//项目名
@property (nonatomic,strong)NSString *ID;//项目ID
@property (nonatomic,strong)NSString *BorrowingRate;//利率
@property (nonatomic,strong)NSString *minPrice;//最小可投
@property (nonatomic,strong)NSString *Price;//最大可投
@property (nonatomic,strong)NSString *Timelimit;//最大可投
@property (nonatomic,assign)double rate;
@end
