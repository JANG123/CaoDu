//
//  InvestmentTableViewController.m
//  CaoDu
//
//  Created by jang on 16/3/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "InvestmentTableViewController.h"
#import "InvestmentTableViewCell.h"
#import "GoodViewController.h"
#import "FilterView.h"
@interface InvestmentTableViewController ()
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)FilterView *fv;
@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)UIView *backgroundView1;
@end

@implementation InvestmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我要投资";
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"iconfont-fenlei"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.tableView setBackgroundColor:Color_back];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[InvestmentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(p_headDate)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(p_foodData)];
    
    _fv = [[FilterView alloc]initWithFrame:CGRectMake(kScreenWidth *4/7, -(CGRectGetMinY(self.tabBarController.tabBar.frame) - 64), kScreenWidth *3/7, CGRectGetMinY(self.tabBarController.tabBar.frame) - 64)];
    [self.view addSubview:_fv];
    [self.view sendSubviewToBack:_fv];
    _fv.hidden = YES;
    
    PageSize = 10;
    goodStateStr = @"";
    timelimitStr = @"-1";
    [self p_data];
    _dataArr = [NSMutableArray array];
    [self addButtonAction];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)p_data{
    NSString *userID = [UserAccount shareGetUserAccountDate].aUser.ClientID;
    [[InvestmentDataTolls shareGetInvestmentData]GetAllRaiseWithGoodsType:goodTypeStr Timelimit:timelimitStr State:goodStateStr PageSize:PageSize UserID:userID PassValue:^(NSMutableArray *code) {
        _dataArr = code;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        });
    }];
}

-(void)p_headDate{
    goodStateStr = @"";
    timelimitStr = @"-1";
    PageSize = 10;
    [self p_data];
}

-(void)p_foodData{
    if (PageSize < _dataArr.count +20) {
        PageSize = PageSize + 10;
    }
    [self p_data];
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.selectedIndex = 1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [_backgroundView removeFromSuperview];
    [_backgroundView1 removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        _fv.frame = CGRectMake(kScreenWidth *4/7, - CGRectGetHeight(self.tableView.frame), kScreenWidth *3/7, CGRectGetHeight(self.tableView.frame));
        [self.view sendSubviewToBack:_fv];
        _fv.hidden = YES;
    }];
}

-(void)rightBar:(UINavigationItem *)sender{
    if (CGRectGetMinY(_fv.frame) < 0) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = CGRectMake(0, 64, kScreenWidth *4/7, CGRectGetHeight(_fv.frame) - 48);
        _backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
        _backgroundView.alpha = 0.4;
        [self.view.window addSubview:_backgroundView];
        
        _backgroundView1 = [[UIView alloc] init];
        _backgroundView1.frame = self.tabBarController.tabBar.frame;
        _backgroundView1.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
        _backgroundView1.alpha = 0.4;
        [self.view.window addSubview:_backgroundView1];
        _fv.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view bringSubviewToFront:_fv];
            _fv.frame = CGRectMake(kScreenWidth *4/7, self.tableView.contentOffset.y, kScreenWidth *3/7, CGRectGetHeight(_fv.frame));
            
        }];
    }else{
        [_backgroundView removeFromSuperview];
        [_backgroundView1 removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _fv.frame = CGRectMake(kScreenWidth *4/7, - CGRectGetHeight(_fv.frame), kScreenWidth *3/7, CGRectGetHeight(_fv.frame));
            [self.view sendSubviewToBack:_fv];
            _fv.hidden = YES;
        }];
    }
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
    [_backgroundView1 removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _fv.frame = CGRectMake(kScreenWidth *4/7, - CGRectGetHeight(self.tableView.frame), kScreenWidth *3/7, CGRectGetHeight(self.tableView.frame));
        [self.view sendSubviewToBack:_fv];
        _fv.hidden = YES;
    }];
}

//确定筛选
-(void)determineButtonAction:(UIButton *)sender{
    PageSize = 5;
    resultPageSize = 5;
    [self p_foodData];
    [_backgroundView removeFromSuperview];
    [_backgroundView1 removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _fv.frame = CGRectMake(kScreenWidth *4/7, - CGRectGetHeight(self.tableView.frame), kScreenWidth *3/7, CGRectGetHeight(self.tableView.frame));
        [self.view sendSubviewToBack:_fv];
        _fv.hidden = YES;
    }];
    self.tableView.contentOffset = CGPointMake(0, 0);
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
    headview.backgroundColor = [UIColor clearColor];
    return headview;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodViewController *gVC = [[GoodViewController alloc]init];
    InvestmentModle *Investment = _dataArr[indexPath.row];
    gVC.goodID = Investment.ID;
    [self.navigationController pushViewController:gVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
