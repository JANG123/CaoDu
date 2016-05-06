//
//  LoginRegistDateTolls.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^LoginRegistPassValue)(NSString *code);
@class RegisteredModle;
@interface LoginRegistDateTolls : NSObject

//@property (nonatomic,strong)RegisteredModle *aRegist;

+(LoginRegistDateTolls *)shareGetLoginRegistDate;

//注册
-(void)registWithRegist:(RegisteredModle *)aRegist LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue;

//登录
-(void)LoginWithTel:(NSString *)tel PassWord:(NSString *)pw LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue;

//忘记密码
-(void)ResetPasswordWith:(NSString *)tel PassWord:(NSString *)newPw LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue;

//修改密码
-(void)UserPassWithClientId:(NSString *)ClientId PassWord:(NSString *)Password  NewPassword:(NSString *)NewPassword LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue;

//修改资金密码
-(void)ResetFundpassWithClientId:(NSString *)ClientId NewPassword:(NSString *)NewPassword LoginRegistPassValue:(LoginRegistPassValue)loginRegistPassValue;

//获取我的资金
-(void)MyPersonalWithClientId:(NSString *)ClientId;

@end
