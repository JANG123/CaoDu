//
//  AnnounceDetailViewController.m
//  CaoDu
//
//  Created by jang on 16/3/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "AnnounceDetailViewController.h"

@interface AnnounceDetailViewController ()<UIWebViewDelegate>

@end

@implementation AnnounceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self drawNavigation];
    [self drawDetailView];
}


- (void)drawNavigation{
    self.navigationItem.title = @"公告详情";
    
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"矩形-15-拷贝-6.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiangtianchong.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = Color_back;
}

-(void)drawDetailView{
    UIView *datailView = [[UIView alloc]initWithFrame:CGRectMake(0, 11/PxHeight, kScreenWidth, kScreenHeight-11/PxHeight)];
    datailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datailView];
    //公告名
    UILabel *datailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/PxWidth, 10/PxHeight, kScreenWidth - 130/PxWidth, 20/PxHeight)];
    datailNameLabel.text = _aNews.Title;
    datailNameLabel.numberOfLines = 0;
    datailNameLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    datailNameLabel.font = [UIFont adapterFontOfSize: 17.0];
    [datailView addSubview:datailNameLabel];
    
    
    NSDictionary *dict = @{NSFontAttributeName :[UIFont adapterFontOfSize:18.0]};
    
    CGRect rect = [_aNews.Title boundingRectWithSize:CGSizeMake(CGRectGetWidth(datailNameLabel.frame)-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGRect tempRect1 = datailNameLabel.frame;
    tempRect1.size.height = rect.size.height;
    datailNameLabel.frame = tempRect1;
    
    
    //日期
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 110/PxWidth, 10/PxHeight, 85/PxWidth, 17/PxHeight)];
    dateLabel.text = _aNews.timeStr;
    dateLabel.textAlignment = NSTextAlignmentRight;
    dateLabel.textColor = [UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1];
    dateLabel.font = [UIFont adapterFontOfSize: 12.0];
    [datailView addSubview:dateLabel];

    
    UIWebView *dataileWebView = [[UIWebView alloc]initWithFrame:CGRectMake(20/PxWidth, CGRectGetHeight(datailNameLabel.frame) + 15/PxHeight, kScreenWidth - 40/PxWidth, CGRectGetHeight(datailView.frame) - CGRectGetHeight(datailNameLabel.frame) - 30/PxHeight)];
    dataileWebView.backgroundColor = [UIColor whiteColor];
    dataileWebView.delegate = self;
    dataileWebView.scalesPageToFit =NO;
    NSString *tempString = [NSString importStyleWithHtmlString:_aNews.NContent];
    //baseURL可以让界面加载的时候按照本地样式去加载
    NSURL *basrUrl = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
    [dataileWebView loadHTMLString:tempString baseURL:basrUrl];
    [datailView addSubview:dataileWebView];
}


-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBar:(UINavigationItem *)sender{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    NSString *jsPath = [[NSBundle mainBundle]pathForResource:@"js" ofType:@"txt"];
//    NSString *jsStr = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
//    
//    [webView stringByEvaluatingJavaScriptFromString:jsStr];
//    [webView stringByEvaluatingJavaScriptFromString:@"AutoResizeAllImage(320);"];
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
