//
//  TelValiDateTolls.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TelValiPassValue)(NSString *string);

@interface TelValiDateTolls : NSObject

@property (nonatomic,strong)NSString *TelNum;

+(TelValiDateTolls *)shareGetTelValiDate;

-(void)validateNumWithPhoneNum:(NSString *)num PassValue:(TelValiPassValue)passValue;

-(void)telValiDataWithPhoneNum:(NSString *)num PassValue:(TelValiPassValue)passValue;
@end
