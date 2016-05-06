//
//  CertificationViewController.m
//  CaoDu
//
//  Created by jang on 16/3/22.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "CertificationViewController.h"
#import "CerSuccesViewController.h"
@interface CertificationViewController ()
@property (nonatomic,strong)TextTypeView *nameText;
@property (nonatomic,strong)TextTypeView *IDText;
@property (nonatomic,strong)UIButton *certificationButton;
@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请输入手机号" imageName:@"users.png" Interaction:YES];
    [self.view addSubview:_nameText];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45/PxWidth, 45/PxHeight, kScreenWidth - 45/PxWidth, 1)];
    nameLabel.backgroundColor = Color_back;
    [_nameText addSubview:nameLabel];
    _nameText.backgroundColor = [UIColor whiteColor];
    
    _IDText = [[TextTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameText.frame), kScreenWidth - 13/PxWidth, 45/PxWidth) placeholder:@"请输入短信验证码" imageName:@"iconfont-shenfenzheng.png" Interaction:YES];
    [self.view addSubview:_IDText];
    _IDText.backgroundColor = [UIColor whiteColor];
    
    _certificationButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_IDText.frame) + 20/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _certificationButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_certificationButton setTitle:@"验证" forState:UIControlStateNormal];
    [_certificationButton addTarget:self action:@selector(certificationButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_certificationButton];
    [_certificationButton.layer setMasksToBounds:YES];
    [_certificationButton.layer setCornerRadius:5.0];
    
    [self drawNa];
}

-(void)certificationButton:(UIButton *)sender{
    CerSuccesViewController *cv = [[CerSuccesViewController alloc]init];
    [self.navigationController pushViewController:cv animated:YES];
}

-(void)drawNa{
    KFontColor_NavBlackColor
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"实名认证";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view setBackgroundColor:Color_back];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"back.png"]];
    [backButton addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backImage.frame) + 4, 0, CGRectGetWidth(backButton.frame) - CGRectGetMaxX(backImage.frame), 30)];
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor colorWithRed:49/255.0 green:143/255.0 blue:43/255.0 alpha:1.0];
    [backButton addSubview:backLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)leftBar:(UIButton *)sender{
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
