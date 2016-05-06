//
//  TopUpViewController.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "TopUpViewController.h"
#import "AddBankViewController.h"
@interface TopUpViewController ()

@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawNa];
    [self drawView];
    

}

-(void)drawNa{
    self.navigationItem.title = @"充值";
    [self.view setBackgroundColor:Color_back];
    
    KFontColor_NavBlackColor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"btn_back.png"]];
    [backButton addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backImage.frame) + 4, 0, CGRectGetWidth(backButton.frame) - CGRectGetMaxX(backImage.frame), 30)];
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];;
    [backButton addSubview:backLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)drawView{
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 154/PxWidth)/2, 112/PxHeight, 154/PxWidth, 154/PxWidth)];
    logoImageView.image = [UIImage imageNamed:@"iconfont-ticket.png"];
    [self.view addSubview:logoImageView];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 24/PxHeight, kScreenWidth, 20/PxHeight)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont adapterFontOfSize:13.0];
    textLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    textLabel.text = @"您还没有添加银行卡，快去添加吧";
    [self.view addSubview:textLabel];
    UIButton *addBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(textLabel.frame) + 18/PxHeight, 230/PxWidth, 45/PxHeight);
    [addBankButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
    addBankButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:addBankButton];
    [addBankButton addTarget:self action:@selector(addBankButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addBankButtonAction:(UIButton *)sender{
    AddBankViewController *av = [[AddBankViewController alloc]init];
    [self.navigationController pushViewController:av animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
