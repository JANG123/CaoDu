//
//  AppDelegate.m
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainTabController.h"

@interface AppDelegate ()
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self NetWorkStatue];
    if ([UserAccount UserName].length > 1) {
        if ([PasswordAccount isOnWithNeedPassword] == NO) {
            MainTabController *mainTC = [[MainTabController alloc]init];
            self.window.rootViewController = mainTC;
        }else{
            GestureViewController *ges = [[GestureViewController alloc] initWithCaseMode:VerifyMode];
            [PasswordAccount needPasswordIsOn:YES];
            ges.isFormer = YES;
            ges.isLogin = YES;
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:ges];
        }
    }else{
        MainTabController *mainTC = [[MainTabController alloc]init];
        self.window.rootViewController = mainTC;
    }

    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;
    
    //[NSThread sleepForTimeInterval:3.0];//设置启动页面时间
    return YES;
}

-(void)root
{
    MainTabController *mainTC = [[MainTabController alloc]init];
    mainTC.isSetting = [PasswordAccount isOnWithNeedPassword];
    self.window.rootViewController = mainTC;
}


-(void)NetWorkStatue{
    //实例化一个网络判断工具的对象
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        [[NSUserDefaults standardUserDefaults] setValue:@"WIFI" forKey:@"NETStatus"];
        NSLog(@"当前网络状态是WIFI");
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"3G" forKey:@"NETStatus"];
        NSLog(@"当前网络状态是3G");
    }else if (ability.currentReachabilityStatus == NotReachable)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"无网络" forKey:@"NETStatus"];
        NSLog(@"当前未连接网络");
    }
    
    [ability startNotifier];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NETStatusChanged:) name:kReachabilityChangedNotification object:ability];
}

-(void)NETStatusChanged:(NSNotification *)sender
{
    //实例化一个网络判断工具的对象
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    
    
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        [[NSUserDefaults standardUserDefaults] setValue:@"WIFI" forKey:@"NETStatus"];
        NSLog(@"当前网络状态是WIFI");
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"3G" forKey:@"NETStatus"];
        NSLog(@"当前网络状态是3G");
    }else if (ability.currentReachabilityStatus == NotReachable)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"无网络" forKey:@"NETStatus"];
        NSLog(@"当前未连接网络");
    }
}

//-(void)root
//{
//    GestureSettingViewController *sett = [[GestureSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    NSString *pa = [PasswordAccount password];
//    NSLog(@"-----%@",pa);
//    sett.isSetting = [PasswordAccount isOnWithNeedPassword];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:sett];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    NSString *CurrentSelectedCViewController = NSStringFromClass([[self getVisibleViewControllerFrom:self.window.rootViewController] class]);
    
    if (![CurrentSelectedCViewController isEqualToString:@"GestureViewController"]) {
        if ([PasswordAccount isOnWithNeedPassword] == YES) {
            GestureViewController *ges = [[GestureViewController alloc] initWithCaseMode:VerifyMode];
            ges.isFormer = YES;
            ges.isLogin = NO;
            ges.EnterBackground = @"EnterBackground";
            [navigationController pushViewController:ges animated:YES];
//            _timer =
        }
    }
}

- (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
