//
//  GesturesDataTolls.m
//  CaoDu
//
//  Created by jang on 16/3/31.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GesturesDataTolls.h"

@implementation GesturesDataTolls
+ (void)applicationWillEnterForeground:(UIApplication *)application NavigationController:(UINavigationController *)navigation{
    if ([PasswordAccount isOnWithNeedPassword] == YES) {
        GestureViewController *ges = [[GestureViewController alloc] initWithCaseMode:VerifyMode];
        [PasswordAccount needPasswordIsOn:YES];
        ges.isFormer = YES;
        ges.isLogin = NO;
        [navigation pushViewController:ges animated:YES];
    }
}
@end
