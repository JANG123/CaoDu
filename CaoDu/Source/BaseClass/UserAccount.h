//
//  UserAccount.h
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModle;
@interface UserAccount : NSObject

@property (nonatomic,strong)UserModle *aUser;
@property (nonatomic,strong)NSString *WaitingMoney;

+(UserAccount *)shareGetUserAccountDate;
+(void)SetUserAccout:(NSString *)userName PassWord:(NSString *)passWord;
+(NSString *)UserName;
+(NSString *)PassWord;
+(void)deleteUserAccount;

-(void)SetUserInfoWithUser:(UserModle *)user;
@end
