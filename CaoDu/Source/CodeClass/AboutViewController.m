//
//  AboutViewController.m
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "AboutViewController.h"
#import "IntroductionView.h"
#import "CertificateView.h"
#import "PolicyView.h"
#import "lawView.h"

@interface AboutViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    IntroductionView *iv = [IntroductionView contentIntroductionView];
    CertificateView *cv = [CertificateView contentCertificateView];
    PolicyView *pv = [PolicyView contentPolicyView];
    lawView *lv = [lawView contentlawView];
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 4; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        switch (i) {
            case 0:
                [segmentButton setTitle:[NSString stringWithFormat:@"公司简介"] forState:UIControlStateNormal];
                break;
            case 1:
                [segmentButton setTitle:[NSString stringWithFormat:@"公司证件"] forState:UIControlStateNormal];
                break;
            case 2:
                [segmentButton setTitle:[NSString stringWithFormat:@"政策法规"] forState:UIControlStateNormal];
                break;
            case 3:
                [segmentButton setTitle:[NSString stringWithFormat:@"法律顾问"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [buttonArray addObject:segmentButton];
    }
    HHHorizontalPagingView *pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:nil headerHeight:0 segmentButtons:buttonArray segmentHeight:60 contentViews:@[iv, cv, pv,lv]];
    [self.view addSubview:pagingView];
    [self drawNavigation];
    
}

-(void)drawNavigation{
    self.navigationItem.title = @"关于我们";
    KFontColor_NavBlackColor
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"bai-back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = Color_back;
    KFontColor_NavWhite
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];

}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
