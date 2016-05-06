//
//  MainViewController.m
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MainViewController.h"
#import "ModuleView.h"
#import "AnnounceTableViewController.h"
#import "GoodViewController.h"
@interface MainViewController ()
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)NSMutableArray *mainGoodArr;
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 110);
    self.view = _scrollView;
    
    
    [self.view addSubview:[[UIView alloc] init]];
    self.view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    [self drawNavigation];
    [self drawCycleScrollView];
    
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainCycleScrollView.frame), kScreenWidth,kScreenHeight - CGRectGetMaxY(_mainCycleScrollView.frame) - 110)];
    _carousel.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeLinear;
    
    [self.view addSubview:_carousel];
    _imageArr = [NSMutableArray array];
    _mainGoodArr = [NSMutableArray array];
    
    //数据刷新
    [self.scrollView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(p_data) dateKey:@"mjScorll"];
    //加载数据
    [self p_data];
    
}

-(void)drawNavigation{
    [self.navigationItem setTitle:@"首页"];
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"mess.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"mess1.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)drawCycleScrollView{
    if (_imageArr.count == 0) {
        // 主循环滚动图
        NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"banner01.jpg"],[UIImage imageNamed:@"banner2.jpg"], nil];
        _mainCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150/PxHeight) imagesGroup:tempArr];
        [self.view addSubview:_mainCycleScrollView];
    }else{
        
        _mainCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150/PxHeight) imageURLStringsGroup:_imageArr];
        [self.view addSubview:_mainCycleScrollView];
    }
}

-(void)leftBar:(UIBarButtonItem *)sender{
    AnnounceTableViewController *annVC = [[AnnounceTableViewController alloc]init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:annVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)p_data{
    [[MainDateTolls shareGetMainDateTollsDate]cycleScrollWithMainDateTollsPassValue:^(NSArray *code) {
        _imageArr = [NSMutableArray arrayWithArray:code];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawCycleScrollView];
        });
    }];
    
    [[MainDateTolls shareGetMainDateTollsDate]GetAllRaiseWithMainDateTollsPassValue:^(NSArray *code) {
        _mainGoodArr = [NSMutableArray arrayWithArray:code];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.carousel reloadData];
            [self.scrollView.header endRefreshing];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark -iCarouselDelegate
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _mainGoodArr.count;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

    MainGoodModle *mainGood = _mainGoodArr[index];
    _moduleView1 = [[ModuleView alloc]initWithFrame:CGRectMake(0, 0, 305/PxWidth, CGRectGetHeight(_carousel.frame) - 20/PxHeight)];
    _moduleView1.goodsNameLabel.text = [NSString stringWithFormat:@"%@",mainGood.GoodsName];
    _moduleView1.rateNumLabel.text = [NSString stringWithFormat:@"%@",mainGood.BorrowingRate];
    _moduleView1.sumPriceLabel2.text = [NSString stringWithFormat:@"%@",mainGood.Price];
    _moduleView1.timelimitLabel2.text = [NSString stringWithFormat:@"%@",mainGood.Timelimit];
    _moduleView1.sellOutPriceLabel2.text = [NSString stringWithFormat:@"%@",mainGood.minPrice];
    _moduleView1.goodButton.tag = 200+index;
    
    _moduleView1.radialView.progressTotal = 100;
    _moduleView1.radialView.progressCounter = (NSInteger)(mainGood.rate *100);
    [_moduleView1.goodButton addTarget:self action:@selector(goodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moduleView1.layer setMasksToBounds:YES];
    [_moduleView1.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    return _moduleView1;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.03;
    }
    
    if (option==iCarouselOptionVisibleItems) {
        return value * 1.03;
    }
    return value;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

-(void)goodButtonAction:(UIButton *)sender{
    MainGoodModle *mainGood = _mainGoodArr[sender.tag - 200];
    GoodViewController *gv = [[GoodViewController alloc]init];
    gv.goodID = mainGood.ID;
    [self.navigationController pushViewController:gv animated:YES];
}

-(void)NETStatusChanged:(NSNotification *)sender
{
    //实例化一个网络判断工具的对象
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    
    
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        [[NSUserDefaults standardUserDefaults] setValue:@"WIFI" forKey:@"NETStatus"];
        NSLog(@"当前网络状态是---WIFI");
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"3G" forKey:@"NETStatus"];
        NSLog(@"当前网络状态是---3G");
    }else if (ability.currentReachabilityStatus == NotReachable)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"无网络" forKey:@"NETStatus"];
        NSLog(@"当前未连接网络---");
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
