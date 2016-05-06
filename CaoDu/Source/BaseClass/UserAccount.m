//
//  UserAccount.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "UserAccount.h"
#define kUserPassword @"userPassword"
#define kUserName @"kUserName"
static UserAccount *uData;
@implementation UserAccount

+(UserAccount *)shareGetUserAccountDate{
    static dispatch_once_t once_token;
    if (uData == nil) {
        dispatch_once(&once_token, ^{
            uData = [[UserAccount alloc]init];
        });
    }
    return uData;
}

+(void)SetUserAccout:(NSString *)userName PassWord:(NSString *)passWord{
    [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:kUserPassword];
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)UserName{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserName];
}
+(NSString *)PassWord{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserPassword];
}
+(void)deleteUserAccount{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:kUserPassword];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)SetUserInfoWithUser:(UserModle *)user{
    _aUser = [[UserModle alloc]init];
    _aUser = user;
}

@end
