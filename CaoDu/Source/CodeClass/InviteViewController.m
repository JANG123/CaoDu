//
//  InviteViewController.m
//  CaoDu
//
//  Created by jang on 16/3/29.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteView.h"
#import "barcodeView.h"
@interface InviteViewController ()
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *bannerImageView;
@property (nonatomic,strong)InviteView *iv;
@property (nonatomic,strong)barcodeView *bv;
@property (assign)BOOL isSelected;
@end

@implementation InviteViewController

-(void)loadView{
    _scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = _scrollView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self drawNa];
    
    _bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 105/PxHeight)];
    _bannerImageView.image = [UIImage imageNamed:@"banner.png"];
    [self.view addSubview:_bannerImageView];
    _bannerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerAction:)];
    [_bannerImageView addGestureRecognizer:singleTap];
    
    _bv = [[barcodeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bannerImageView.frame) + 10/PxHeight, kScreenWidth, 0)];
    [self.view addSubview:_bv];

    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;

    _iv = [[InviteView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bv.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_bv.frame) - rectStatus.size.height - rectNav.size.height)];
    [self.view addSubview:_iv];
    _isSelected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)drawNa{
    self.navigationItem.title = @"邀请好友";
    [self.view setBackgroundColor:Color_back];
    
    KFontColor_NavBlackColor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 10, 17)];
    [backImage setImage:[UIImage imageNamed:@"矩形-15-拷贝-6.png"]];
    [backButton addSubview:backImage];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bannerAction:(id)sender{
    if (_isSelected) {
        _bv.frame =CGRectMake(0, CGRectGetMaxY(_bannerImageView.frame) + 10/PxHeight, kScreenWidth, 345/PxHeight);
        CGRect rectNav = self.navigationController.navigationBar.frame;
        _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_iv.frame) + 340/PxHeight - rectNav.size.height);
    }else{
        _bv.frame =CGRectMake(0, CGRectGetMaxY(_bannerImageView.frame) + 10/PxHeight, kScreenWidth, 0);
        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    _iv.frame = CGRectMake(0, CGRectGetMaxY(_bv.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
    _isSelected = !_isSelected;
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
