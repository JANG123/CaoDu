//
//  InvestmentViewController.m
//  CaoDu
//
//  Created by jang on 16/4/6.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InvestmentViewController.h"
#import "InvestmentTableViewCell.h"
#import "GoodViewController.h"
#import "FilterView.h"
@interface InvestmentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)FilterView *fv;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *headButton1;
@property (nonatomic,strong)UIButton *headButton2;
@property (nonatomic,strong)UIButton *headButton3;
@property (nonatomic,strong)UIButton *headButton4;
@property (nonatomic,strong)UILabel *greenLabel1;
@property (nonatomic,strong)UILabel *greenLabel2;
@property (nonatomic,strong)UILabel *greenLabel3;
@property (nonatomic,strong)UILabel *greenLabel4;
@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)UIView *backgroundView1;
@end

@implementation InvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    [self p_view];
    [self p_data];
    [self addButtonAction];
    goodTypeStr = @"";
    goodStateStr = @"";
    timelimitStr = @"-1";
    
}

-(void)p_view{
    self.navigationItem.title = @"我要投资";
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"椭圆-9.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = Color_back;
    [self drawTypeButton];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame), kScreenWidth,CGRectGetMinY(self.tabBarController.tabBar.frame) - CGRectGetMaxY(_headButton1.frame) - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[InvestmentTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(p_data) dateKey:@"mjScorll"];
    [self.view addSubview:_tableView];
    

    _fv = [[FilterView alloc]initWithFrame:CGRectMake(kScreenWidth *4/7, CGRectGetMaxY(_headButton1.frame) - CGRectGetHeight(_tableView.frame), kScreenWidth *3/7, CGRectGetHeight(_tableView.frame))];
    [self.view addSubview:_fv];
    [self.view sendSubviewToBack:_fv];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [_backgroundView removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        _fv.frame = CGRectMake(kScreenWidth *4/7, CGRectGetMaxY(_headButton1.frame) - CGRectGetHeight(_tableView.frame), kScreenWidth *3/7, CGRectGetHeight(_tableView.frame));
        [self.view sendSubviewToBack:_fv];
    }];
}

-(void)rightBar:(UINavigationItem *)sender{
    if (CGRectGetMinY(_fv.frame) < CGRectGetMinY(_headButton1.frame)) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = CGRectMake(0, 64 + CGRectGetMaxY(_headButton1.frame), kScreenWidth *4/7, CGRectGetHeight(_tableView.frame));
        _backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
        _backgroundView.alpha = 0.4;
        //[self.view.window addSubview:_backgroundView];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.view bringSubviewToFront:_fv];
            _fv.frame = CGRectMake(kScreenWidth *4/7, CGRectGetMaxY(_headButton1.frame), kScreenWidth *3/7, CGRectGetHeight(_tableView.frame));
            
        }];
    }else{
        [_backgroundView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _fv.frame = CGRectMake(kScreenWidth *4/7, CGRectGetMaxY(_headButton1.frame) - CGRectGetHeight(_tableView.frame), kScreenWidth *3/7, CGRectGetHeight(_tableView.frame));
            [self.view sendSubviewToBack:_fv];
        }];
    }
    
}

-(void)p_data{
//    [[InvestmentDataTolls shareGetInvestmentData]GetHotBPTIWithPassValue:^(NSMutableArray *code) {
//        _dataArr = code;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            [self.tableView.header endRefreshing];
//        });
//    }];
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.selectedIndex = 1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
}
//添加筛选条件button事件
-(void)addButtonAction{
    [_fv.typeButton0 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.typeButton1 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.typeButton2 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.typeButton3 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton0 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton1 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton2 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton3 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton4 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton5 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.timelimitButton6 addTarget:self action:@selector(timeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fv.determineButton addTarget:self action:@selector(determineButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

//取消筛选
-(void)cancelButtonAction:(UIButton *)sender{
    [_backgroundView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _fv.frame = CGRectMake(kScreenWidth *4/7, CGRectGetMaxY(_headButton1.frame) - CGRectGetHeight(_tableView.frame), kScreenWidth *3/7, CGRectGetHeight(_tableView.frame));
        [self.view sendSubviewToBack:_fv];
    }];
}

//确定筛选
-(void)determineButtonAction:(UIButton *)sender{
//    [[InvestmentDataTolls shareGetInvestmentData]GetAllRaiseWithGoodsType:goodTypeStr Timelimit:timelimitStr State:goodStateStr PassValue:^(NSMutableArray *code) {
//        _dataArr = code;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            [self.tableView.header endRefreshing];
//            [_backgroundView removeFromSuperview];
//            [UIView animateWithDuration:0.3 animations:^{
//                _fv.frame = CGRectMake(kScreenWidth *4/7, CGRectGetMaxY(_headButton1.frame) - CGRectGetHeight(_tableView.frame), kScreenWidth *3/7, CGRectGetHeight(_tableView.frame));
//                [self.view sendSubviewToBack:_fv];
//            }];
//        });
//    }];
}

//项目状态筛选
-(void)selectButtonAction:(UIButton *)sender{
    [_fv.typeButton0 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.typeButton1 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.typeButton2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.typeButton3 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [sender setTitleColor:Color_Cyan forState:UIControlStateNormal];
    if (sender == _fv.typeButton0) {
        goodStateStr = @"";
    }else{
        goodStateStr = sender.titleLabel.text;
    }
}

//项目时间筛选
-(void)timeSelectAction:(UIButton *)sender{
    [_fv.timelimitButton0 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.timelimitButton1 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.timelimitButton2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.timelimitButton3 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_fv.timelimitButton4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.timelimitButton5 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [_fv.timelimitButton6 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [sender setTitleColor:Color_Cyan forState:UIControlStateNormal];
    if (sender == _fv.timelimitButton0) {
        timelimitStr = @"-1";
    }else if(sender == _fv.timelimitButton1){
        timelimitStr = @"0";
    }else{
        timelimitStr = [sender.titleLabel.text componentsSeparatedByString:@"天"][0];
    }
}

-(void)drawTypeButton{
    _headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton1.backgroundColor = [UIColor whiteColor];
    _headButton1.frame = CGRectMake(0, 0, kScreenWidth/4, 45/PxHeight);
    [_headButton1 setTitle:@"全部" forState:UIControlStateNormal];
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
    [_headButton2 setTitle:@"房产" forState:UIControlStateNormal];
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
    [_headButton3 setTitle:@"车" forState:UIControlStateNormal];
    [_headButton3 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    _headButton3.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton3 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton3];
    
    _greenLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton2.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton3 addSubview:_greenLabel3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_headButton3.frame) - 1, 10/PxHeight, 1, CGRectGetHeight(_headButton3.frame) - 20/PxHeight)];
    label3.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [_headButton3 addSubview:label3];
    
    
    _headButton4 = [UIButton buttonWithType:UIButtonTypeSystem];
    _headButton4.frame = CGRectMake(CGRectGetMaxX(_headButton3.frame), 0, CGRectGetWidth(_headButton3.frame), CGRectGetHeight(_headButton3.frame));
    _headButton4.backgroundColor = [UIColor whiteColor];
    [_headButton4 setTitle:@"牧草" forState:UIControlStateNormal];
    [_headButton4 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    _headButton4.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton4 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton4];
    
    _greenLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton3.frame) - 1, CGRectGetWidth(_headButton3.frame), 1)];
    [_headButton4 addSubview:_greenLabel4];
}

//项目分类筛选
-(void)headButtonAction:(UIButton *)sender{
    [_headButton1 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton2 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton3 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton4 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _greenLabel1.backgroundColor = [UIColor whiteColor];
    _greenLabel2.backgroundColor = [UIColor whiteColor];
    _greenLabel3.backgroundColor = [UIColor whiteColor];
    _greenLabel4.backgroundColor = [UIColor whiteColor];
    
    if (sender == _headButton1) {
        [_headButton1 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel1.backgroundColor = Color_Cyan;
    }if (sender == _headButton2) {
        [_headButton2 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel2.backgroundColor = Color_Cyan;
    }if (sender == _headButton3) {
        [_headButton3 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel3.backgroundColor = Color_Cyan;
        
    }if (sender == _headButton4) {
        [_headButton4 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel4.backgroundColor = Color_Cyan;
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10/PxHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122/PxHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InvestmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    InvestmentModle *aInvest = [[InvestmentModle alloc]init];
    aInvest = _dataArr[indexPath.row];
    cell.goodsNameLabel.text = aInvest.GoodsName;
    cell.moneyLabel.text = [NSString stringWithFormat:@"剩余投标金额:%@，每百元收益",aInvest.remainAmount];
    cell.earningsLabel.text = aInvest.BorrowingRateMoney;
    cell.timelimitLabel.text = aInvest.Timelimit;
    cell.borrowingRateLabel.text = aInvest.BorrowingRate ;
    cell.titleLabel.text = aInvest.RepaymentType;
    cell.maxPriceLable.text = [NSString stringWithFormat:@"可投金额%@",aInvest.Price];
    cell.radialView.progressTotal = 100.0;
    if ([aInvest.absolutely doubleValue] *100.0 > 0) {
        cell.radialView.progressCounter = [aInvest.absolutely doubleValue] *100.0;
    }else{
        cell.radialView.progressCounter = -100;
    }
    
    [cell textWidth:cell.moneyLabel.text Text2:cell.earningsLabel.text];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc]initWithFrame:tableView.tableHeaderView.frame];
    headview.backgroundColor = Color_back;
    return headview;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodViewController *gVC = [[GoodViewController alloc]init];
    InvestmentModle *Investment = _dataArr[indexPath.row];
    gVC.goodID = Investment.ID;
    [self.navigationController pushViewController:gVC animated:YES];
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
