//
//  RegSuccessViewController.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "RegSuccessViewController.h"
#import "CertificationViewController.h"
@interface RegSuccessViewController ()
@property (nonatomic,strong)UIImageView *successImage;
@property (nonatomic,strong)UILabel *successLabel;
@property (nonatomic,strong)UIButton *successButton;
@end

@implementation RegSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    _successImage = [[UIImageView alloc]initWithFrame:CGRectMake(127/PxWidth, 35/PxHeight, 121/PxWidth, 121/PxWidth)];
    [_successImage setImage:[UIImage imageNamed:@"rightlogo.png"]];
    [self.view addSubview:_successImage];
    
    _successLabel = [[UILabel alloc]initWithFrame:CGRectMake(100/PxWidth, CGRectGetMaxY(_successImage.frame) + 20/PxHeight, 180/PxWidth, 25/PxWidth)];
    _successLabel.text = @"恭喜，注册成功!";
    _successLabel.font = [UIFont adapterFontOfSize:20.0];
    _successLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    //[_successLabel setImage:[UIImage imageNamed:@"btn_shimrz_pressed-1.png"]];
    _successLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_successLabel];
    
    _successButton = [[UIButton alloc]initWithFrame:CGRectMake(58/PxWidth, CGRectGetMaxY(_successLabel.frame) + 50/PxHeight, 260/PxWidth, 45/PxWidth)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 260/PxWidth, 45/PxWidth)];
    label.text = @"仅一步，请完成实名认证";
    [_successButton addSubview:label];
    label.textColor = [UIColor colorWithRed:49/255.0 green:143/255.0 blue:43/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    [_successButton setImage:[UIImage imageNamed:@"btn_shimrz_pressed-1.png"] forState:UIControlStateNormal];
    [_successButton addTarget:self action:@selector(successButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_successButton];
    
}

-(void)successButton:(UIButton *)sender{
    CertificationViewController *cv = [[CertificationViewController alloc]init];
    [self.navigationController pushViewController:cv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

-(void)drawNa{
    KFontColor_NavBlackColor
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"注册完成";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view setBackgroundColor:Color_back];
    
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"跳过" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0] forState:UIControlStateNormal]; ;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *leftButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 50, 30)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)rightBar:(UINavigationItem *)sender{
    CertificationViewController *cv = [[CertificationViewController alloc]init];
    [self.navigationController pushViewController:cv animated:YES];
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
