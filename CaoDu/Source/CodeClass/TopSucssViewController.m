//
//  TopSucssViewController.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "TopSucssViewController.h"

@interface TopSucssViewController ()
@property(nonatomic,strong)UILabel *cardLabel1;
@property(nonatomic,strong)UILabel *moneyLabel1;
@end

@implementation TopSucssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self drawView];
}

-(void)drawNa{
    self.navigationItem.title = @"充值详情";
    [self.view setBackgroundColor:Color_back];
    
    KFontColor_NavBlackColor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.hidesBackButton = YES;
    self.tabBarController.tabBar.hidden = YES;
}


-(void)drawView{
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 122/PxWidth)/2, 34/PxHeight, 122/PxWidth, 122/PxWidth)];
    logoImageView.image = [UIImage imageNamed:@"rightlogo.png"];
    [self.view addSubview:logoImageView];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 10/PxHeight, kScreenWidth, 20/PxHeight)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont adapterFontOfSize:20.0];
    //textLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    textLabel.text = @"充值成功";
    [self.view addSubview:textLabel];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textLabel.frame) + 30/PxHeight, kScreenWidth, 90/PxHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, 0, 70/PxWidth, 45/PxHeight)];
    cardLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    cardLabel.font = [UIFont adapterFontOfSize:15.0];
    cardLabel.text = @"储蓄卡";
    [view addSubview:cardLabel];
    
    _cardLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cardLabel.frame), CGRectGetMinY(cardLabel.frame), kScreenWidth - CGRectGetMaxX(cardLabel.frame) - 22/PxWidth, CGRectGetHeight(cardLabel.frame))];
    _cardLabel1.textAlignment = NSTextAlignmentRight;
    _cardLabel1.font = [UIFont adapterFontOfSize:15.0];
    _cardLabel1.text = @"储蓄卡";
    [view addSubview:_cardLabel1];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_cardLabel1.frame)-1, kScreenWidth, 1)];
    label3.backgroundColor = Color_back;
    [view addSubview:label3];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_cardLabel1.frame), 70/PxWidth, 50/PxHeight)];
    moneyLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    moneyLabel.font = [UIFont adapterFontOfSize:15.0];
    moneyLabel.text = @"验证码";
    [view addSubview:moneyLabel];
    
    _moneyLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel.frame), CGRectGetMinY(moneyLabel.frame), kScreenWidth - CGRectGetMaxX(moneyLabel.frame) - 22/PxWidth, CGRectGetHeight(moneyLabel.frame))];
    _moneyLabel1.textAlignment = NSTextAlignmentRight;
    _moneyLabel1.font = [UIFont adapterFontOfSize:15.0];
    _moneyLabel1.text = @"储蓄卡";
    [view addSubview:_moneyLabel1];
    
    
    
    UIButton *susButton = [UIButton buttonWithType:UIButtonTypeCustom];
    susButton.frame = CGRectMake(13/PxWidth, CGRectGetMaxY(view.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight);
    [susButton setTitle:@"确定" forState:UIControlStateNormal];
    susButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:susButton];
    [susButton addTarget:self action:@selector(susButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)susButtonAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
