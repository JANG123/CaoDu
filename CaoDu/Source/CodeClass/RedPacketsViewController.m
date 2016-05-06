//
//  RedPacketsViewController.m
//  CaoDu
//
//  Created by jang on 16/3/29.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "RedPacketsViewController.h"

@interface RedPacketsViewController ()
@property (nonatomic,strong)UIButton *headButton1;
@property (nonatomic,strong)UIButton *headButton2;
@property (nonatomic,strong)UIButton *headButton3;
@property (nonatomic,strong)UILabel *greenLabel1;
@property (nonatomic,strong)UILabel *greenLabel2;
@property (nonatomic,strong)UILabel *greenLabel3;
@end

@implementation RedPacketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self drawHeadButton];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)drawNa{
    self.navigationItem.title = @"红包";
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
    textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 24/PxHeight, kScreenWidth, 20/PxHeight)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont adapterFontOfSize:13.0];
    textLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    textLabel.text = @"您还没有使用过的红包，快去投资吧";
    [self.view addSubview:textLabel];
    UIButton *investButton = [UIButton buttonWithType:UIButtonTypeCustom];
    investButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(textLabel.frame) + 18/PxHeight, 230/PxWidth, 45/PxHeight);
    [investButton setTitle:@"我要投资" forState:UIControlStateNormal];
    investButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:investButton];
    [investButton addTarget:self action:@selector(investButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)investButtonAction:(UIButton *)sender{
    MainTabController *mainTC = [[MainTabController alloc]init];
    mainTC.selectedIndex = 1;
    [self.navigationController presentViewController:mainTC animated:YES completion:nil];
}

-(void)drawHeadButton{
    _headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton1.backgroundColor = [UIColor whiteColor];
    _headButton1.frame = CGRectMake(0, 0, kScreenWidth/3, 45/PxHeight);
    [_headButton1 setTitle:@"未使用" forState:UIControlStateNormal];
    _headButton1.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton1 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton1];
    
    _greenLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton1 addSubview:_greenLabel1];
    [_headButton1 setTitleColor:Color_Cyan forState:UIControlStateNormal];
    _greenLabel1.backgroundColor = Color_Cyan;
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headButton1.frame) - 1, 10/PxHeight, 1, CGRectGetHeight(_headButton1.frame) - 20/PxHeight)];
    label1.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [_headButton1 addSubview:label1];
    
    
    _headButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton2.frame = CGRectMake(CGRectGetMaxX(_headButton1.frame), 0, CGRectGetWidth(_headButton1.frame), CGRectGetHeight(_headButton1.frame));
    _headButton2.backgroundColor = [UIColor whiteColor];
    [_headButton2 setTitle:@"已使用" forState:UIControlStateNormal];
    [_headButton2 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    _headButton2.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton2 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton2];
    
    _greenLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton2 addSubview:_greenLabel2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_headButton2.frame) - 1, 10/PxHeight, 1, CGRectGetHeight(_headButton2.frame) - 20/PxHeight)];
    label2.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [_headButton2 addSubview:label2];
    
    
    _headButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton3.frame = CGRectMake(CGRectGetMaxX(_headButton2.frame), 0, CGRectGetWidth(_headButton2.frame), CGRectGetHeight(_headButton2.frame));
    _headButton3.backgroundColor = [UIColor whiteColor];
    [_headButton3 setTitle:@"已过期" forState:UIControlStateNormal];
    [_headButton3 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    _headButton3.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton3 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton3];
    
    _greenLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton2.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton3 addSubview:_greenLabel3];
}

-(void)headButtonAction:(UIButton *)sender{
    [_headButton1 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton2 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton3 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _greenLabel1.backgroundColor = [UIColor whiteColor];
    _greenLabel2.backgroundColor = [UIColor whiteColor];
    _greenLabel3.backgroundColor = [UIColor whiteColor];
    
    if (sender == _headButton1) {
        
        [_headButton1 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel1.backgroundColor = Color_Cyan;
    }if (sender == _headButton2) {
      
        [_headButton2 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel2.backgroundColor = Color_Cyan;
    }if (sender == _headButton3) {
       
        [_headButton3 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel3.backgroundColor = Color_Cyan;

    }
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
