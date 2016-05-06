//
//  MainTabController.m
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MainTabController.h"
#import "PasswordAccount.h"
#import "GestureViewController.h"
@interface MainTabController ()<UITabBarControllerDelegate>{
    MainViewController *mainViewController;
    InvestmentTableViewController *investmentViewController;
    FinancingViewController *financingController;
    UserViewController *userViewController;
    MoreViewController *moreViewController;
}
@end

@implementation MainTabController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self drawTabBarView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[LoginRegistDateTolls shareGetLoginRegistDate]LoginWithTel:[UserAccount UserName] PassWord:[UserAccount PassWord]LoginRegistPassValue:^(NSString *code) {
        
    }];
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [UIView appearance].tintColor = Color_Alert;
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)reloadView
{
    _isSetting = [PasswordAccount isOnWithNeedPassword];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawTabBarView{
    
    //设置字体颜色
    UIColor *titleNormalColor = [UIColor blackColor];
    UIColor *titleSelectedColor = [UIColor colorWithRed:50/255.0 green:150/255.0 blue:40/255.0 alpha:1];;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleNormalColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleSelectedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    UIOffset offset;
    offset.vertical = -3;
    
    //视图控制器
    mainViewController = [[MainViewController alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:1];
    item1.image = [[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//忽略tabBar.tintColor
    item1.selectedImage = [[UIImage imageNamed:@"home1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item1 setTitlePositionAdjustment:offset];
    mainViewController.tabBarItem = item1;
    
    
    investmentViewController = [[InvestmentTableViewController alloc] init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"投资" image:nil tag:2];
    item2.image = [[UIImage imageNamed:@"tmoney.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"tmoney1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item2 setTitlePositionAdjustment:offset];
    investmentViewController.tabBarItem = item2;
    
    financingController = [[FinancingViewController alloc] init];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"融资" image:nil tag:3];
    item3.image = [[UIImage imageNamed:@"money.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"money1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item3 setTitlePositionAdjustment:offset];
    financingController.tabBarItem = item3;
    
    userViewController = [[UserViewController alloc] init];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"账号" image:nil tag:4];
    item4.image = [[UIImage imageNamed:@"user.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"user1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item4 setTitlePositionAdjustment:offset];
    userViewController.tabBarItem = item4;
    
    moreViewController = [[MoreViewController alloc] init];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"更多" image:nil tag:5];
    item5.image = [[UIImage imageNamed:@"more.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.selectedImage = [[UIImage imageNamed:@"more1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item5 setTitlePositionAdjustment:offset];
    moreViewController.tabBarItem = item5;
    //导航栏
    self.navBarController1 = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.navBarController2 = [[UINavigationController alloc] initWithRootViewController:investmentViewController];
    self.navBarController3 = [[UINavigationController alloc] initWithRootViewController:financingController];
    self.navBarController4 = [[UINavigationController alloc] initWithRootViewController:userViewController];
    self.navBarController5 = [[UINavigationController alloc] initWithRootViewController:moreViewController];
    
    
    if(SystemVersion >= 7.0){
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
    //有导航栏
    self.viewControllers = [NSArray arrayWithObjects:self.navBarController1,self.navBarController2,self.navBarController3,self.navBarController4,self.navBarController5, nil];
    
    
    
    //放它管理的controller
    //self.viewControllers = @[mainViewController,investmentViewController,financingController,userViewController,moreViewController];
    
    self.delegate = self;
    self.selectedIndex = 0;//设置启动时第一次显示的UI
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
