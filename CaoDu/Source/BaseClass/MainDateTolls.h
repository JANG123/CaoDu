//
//  MainDateTolls.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^MainDateTollsPassValue)(NSMutableArray *code);
@interface MainDateTolls : NSObject
+(MainDateTolls *)shareGetMainDateTollsDate;

-(void)cycleScrollWithMainDateTollsPassValue:(MainDateTollsPassValue)passVallue;
-(void)GetAllRaiseWithMainDateTollsPassValue:(MainDateTollsPassValue)passVallue;
-(void)SelectNewsWithMainDateTollsPassValue:(MainDateTollsPassValue)passVallue;
@end
