//
//  GoodViewController.m
//  CaoDu
//
//  Created by jang on 16/3/16.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "GoodViewController.h"
#import "GoodView.h"
#import "GoodDetailsView.h"
#import "GoodTableViewCell.h"
#import "DetailTitleView.h"
#import "GoodNumTableViewCell.h"
#import "BuyViewController.h"
#import "AttentionView.h"

@interface GoodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)GoodView *gv;
@property (nonatomic,strong)DetailTitleView *dtView;
@property (nonatomic,strong)UITableView *goodTbaleView;
@property (nonatomic,strong)UIButton *goodButton;
@property (nonatomic,strong)GoodDetailModle *aGoodDetail;
@property (nonatomic,strong)NSMutableArray *dataArr3;
@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation GoodViewController

-(void)loadView{
    self.gv = [[GoodView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _gv;
    [self p_data];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNavigation];
    [self drawTitleButton];
    [self drawTable];
    [self drawButton];
    self.gv.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_goodButton.frame) - 40);
    [self.gv addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(p_data) dateKey:@"mjScorll"];
    _dataArr3 = [NSMutableArray array];
    [_dataArr3 addObject:@"测试"];
    isSelect = 1;

}

-(void)drawNavigation{
    self.navigationItem.title = @"项目详情";
    KFontColor_NavBlackColor
    UIButton *backButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"矩形-15-拷贝-6.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = Color_back;
}

-(void)drawTitleButton{
    _dtView = [[DetailTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_gv.gdVC.frame) + 10/PxHeight, kScreenWidth, 47/PxHeight)];
    
    _dtView.backgroundColor = [UIColor whiteColor];
    [_dtView.headButton1 setTitleColor:Font_SELECT_Color forState:UIControlStateNormal];
    _dtView.label1.backgroundColor = Font_SELECT_Color;
  
    [_dtView.headButton2 setTitleColor:Font_Color forState:UIControlStateNormal];
    _dtView.label2.backgroundColor = [UIColor whiteColor];
   
    [_dtView.headButton4 setTitleColor:Font_Color forState:UIControlStateNormal];
    _dtView.label3.backgroundColor = [UIColor whiteColor];
    [_dtView.headButton1 addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dtView.headButton2 addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dtView.headButton3 addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dtView];
}

- (void)p_setupProgressHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.minSize = CGSizeMake(130, 130);
    _hud.mode = MBProgressHUDModeText;
    _hud.margin = 10.f;
    _hud.removeFromSuperViewOnHide = YES;
    UIImageView *hudBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 130)];
    hudBackImage.center = _hud.center;
    hudBackImage.image = [UIImage imageNamed:@"取消关注-1.png"];
    [_hud addSubview:hudBackImage];
    [_hud hide:YES afterDelay:3];
}

-(void)drawTable{
    
    _goodTbaleView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_dtView.frame), kScreenWidth, 250/PxHeight)];
    [self.view addSubview:_goodTbaleView];
    _goodTbaleView.delegate = self;
    _goodTbaleView.dataSource = self;
    _goodTbaleView.backgroundColor = [UIColor whiteColor];
    [self.goodTbaleView registerClass:[GoodTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.goodTbaleView registerClass:[GoodNumTableViewCell class] forCellReuseIdentifier:@"cellNum"];
    [self setExtraCellLineHidden:self.goodTbaleView];
}

-(void)drawButton{
    _goodButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_goodTbaleView.frame) + 10/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _goodButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_goodButton setTitle:@"我要投资" forState:UIControlStateNormal];
    [self.view addSubview:_goodButton];
    [_goodButton.layer setMasksToBounds:YES];
    [_goodButton.layer setCornerRadius:5.0];
    [_goodButton addTarget:self action:@selector(goodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)p_data{
    [[InvestmentDataTolls shareGetInvestmentData]BPTIDetailWithID:_goodID ClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID PassValue:^(NSMutableArray *code) {
        _aGoodDetail = [[GoodDetailModle alloc]init];
        _aGoodDetail = code[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            _gv.gdVC.borrowingRateLabel.text = _aGoodDetail.BorrowingRate;
            _gv.gdVC.timelimitLabel.text = _aGoodDetail.Timelimit;
            _gv.gdVC.totalAmountLabel.text = _aGoodDetail.SumPrice;
            _gv.gdVC.goodsNameLabel.text = _aGoodDetail.GoodsName;
            _gv.gdVC.moneyLabel.text = [NSString stringWithFormat:@"剩余投标金额:%@，每百元收益",_aGoodDetail.remainAmount];
            _gv.gdVC.earningsLabel.text = _aGoodDetail.BorrowingRateMoney;
            [_gv.gdVC textWidth:_gv.gdVC.moneyLabel.text Text2:_gv.gdVC.earningsLabel.text];
            _gv.gdVC.typeLabel.text = _aGoodDetail.RepaymentType;
            _gv.gdVC.minPriceLable.text = _aGoodDetail.minPrice;
            _gv.gdVC.maxPriceLable.text = _aGoodDetail.Price;
            _gv.gdVC.timeRemainingLabel.text = @"---";
            _gv.gdVC.radialView.progressTotal = 100.0;
            if ([_aGoodDetail.absolutely doubleValue] *100.0 > 0) {
                _gv.gdVC.radialView.progressCounter = [_aGoodDetail.absolutely doubleValue] *100.0;
            }else{
                _gv.gdVC.radialView.progressCounter = -100;
            }
            
            _gv.gdVC.investmentLabel.text = [NSString stringWithFormat:@"%.0f%%",[_aGoodDetail.absolutely doubleValue] * 100];
            _gv.gdVC.timeRemainingLabel.text = _aGoodDetail.endTime;
            UIButton *rightButton = self.navigationItem.rightBarButtonItem.customView;
            if ([_aGoodDetail.IsAttention integerValue] == 1) {
                isAttentionBool = YES;
                [rightButton setImage:[UIImage imageNamed:@"已关注.png"] forState:UIControlStateNormal];
            }else{
                isAttentionBool = NO;
                [rightButton setImage:[UIImage imageNamed:@"取消关注.png"] forState:UIControlStateNormal];
            }
            [_gv.header endRefreshing];
            [self.goodTbaleView reloadData];
        });
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whiteColor.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBar:(UINavigationItem *)sender{
    if ([UserAccount UserName].length > 1) {
        NSString *IsAttention = [NSString string];
        if (isAttentionBool) {
        IsAttention = @"false";
        }else{
        IsAttention = @"true";
        }
        [[InvestmentDataTolls shareGetInvestmentData]AttentionCollectionWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID RID:_aGoodDetail.RID IsIsAttention:IsAttention PassValue:^(NSMutableArray *code) {
            NSLog(@"%@",code[0]);
            UIButton *rightButton = self.navigationItem.rightBarButtonItem.customView;
            if ([code[0] integerValue] == 0) {
                isAttentionBool = !isAttentionBool;
                [self p_data];
                if (isAttentionBool) {
                    [rightButton setImage:[UIImage imageNamed:@"已关注.png"] forState:UIControlStateNormal];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    AttentionView *view = [[AttentionView alloc]initWithFrame:CGRectMake(0, -40, 270, 90)];
                    [alertController.view addSubview:view];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道啦！" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:okAction];
                    [UIView appearance].tintColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
                    [self presentViewController:alertController animated:YES completion:nil];
                }else{
                 [rightButton setImage:[UIImage imageNamed:@"取消关注.png"] forState:UIControlStateNormal];
                 [self p_setupProgressHud];
                }
            }
        }];
    }else{
    [self alertLogin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goodButtonAction:(UIButton *)sender{
    if ([UserAccount UserName].length > 1) {
    BuyViewController *bv = [[BuyViewController alloc]init];
    bv.aGoodDetail = _aGoodDetail;
    [self.navigationController pushViewController:bv animated:YES];
    }else{
        [self alertLogin];
    }
}

-(void)alertLogin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lv animated:YES];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [UIView appearance].tintColor = Color_Alert;
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (isSelect == 1) {
        return 3;
    }if(isSelect == 2) {
        return 2;
    }if(isSelect == 3) {
        return _dataArr3.count;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(void)ButtonAction:(UIButton *)sender{
    [_dtView.headButton1 setTitleColor:Font_Color forState:UIControlStateNormal];
    [_dtView.headButton2 setTitleColor:Font_Color forState:UIControlStateNormal];
    [_dtView.headButton3 setTitleColor:Font_Color forState:UIControlStateNormal];
    //[_dtView.headButton4 setTitleColor:Font_Color forState:UIControlStateNormal];
    _dtView.label1.backgroundColor = [UIColor whiteColor];
    _dtView.label2.backgroundColor = [UIColor whiteColor];
    _dtView.label3.backgroundColor = [UIColor whiteColor];
    //_dtView.label4.backgroundColor = [UIColor whiteColor];
    if (sender == _dtView.headButton1) {
        isSelect = 1;
        [_dtView.headButton1 setTitleColor:Font_SELECT_Color forState:UIControlStateNormal];
        _dtView.label1.backgroundColor = Font_SELECT_Color;
        _dataArr3 = [NSMutableArray array];
        [_dataArr3 addObject:@"测试"];
        [self.goodTbaleView reloadData];
    }
    if (sender == _dtView.headButton2) {
        isSelect = 2;
        [_dtView.headButton2 setTitleColor:Font_SELECT_Color forState:UIControlStateNormal];
        _dtView.label2.backgroundColor = Font_SELECT_Color;
        _dataArr3 = [NSMutableArray array];
        [_dataArr3 addObject:@"测试"];
        [self.goodTbaleView reloadData];
    }
    if (sender == _dtView.headButton3) {
        isSelect = 3;
        [_dtView.headButton3 setTitleColor:Font_SELECT_Color forState:UIControlStateNormal];
        _dtView.label3.backgroundColor = Font_SELECT_Color;
        [[InvestmentDataTolls shareGetInvestmentData]BRaiseListWithID:_goodID PassValue:^(NSMutableArray *code) {
            _dataArr3 = code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.goodTbaleView reloadData];
            });
        }];
    }
//    if (sender == _dtView.headButton4) {
//        isSelect = NO;
//        [[InvestmentDataTolls shareGetInvestmentData]GetRepaymentPlanWithRepaymentDate:_aGoodDetail.RepaymentDate FundRate:_aGoodDetail.FundRate Timelimit:_aGoodDetail.TimelimitUrl Price:_aGoodDetail.PriceUrl PassValue:^(NSMutableArray *code) {
//            
//        }];
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *detailStr = [NSString string];
    if (isSelect == 3) {
        return 35/PxHeight;
    }else if (isSelect == 1) {
        if (indexPath.row == 0) {
            
            detailStr = _aGoodDetail.GoodsDescription;
        }
        if (indexPath.row == 1) {
            detailStr = _aGoodDetail.BondData;
        }
        if (indexPath.row == 2) {
            detailStr = _aGoodDetail.Remark;
        }
    }else if (isSelect == 2){
        if (indexPath.row == 0) {
            detailStr = _aGoodDetail.Repayment;
        }
        if (indexPath.row == 1) {
            detailStr = _aGoodDetail.RiskControl;
        }
    }
        
    CGRect rect = [detailStr boundingRectWithSize:CGSizeMake(kScreenWidth - 36/PxHeight, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil];

    if (rect.size.height + 40/PxHeight < 100/PxHeight) {
        return 100/PxHeight;
    }
    return rect.size.height + 40/PxHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *titleStr = [NSString string];
    NSString *detailStr = [NSString string];
    if (isSelect == 1) {
        if (indexPath.row == 0) {
            titleStr = @"项目介绍";
            detailStr = _aGoodDetail.GoodsDescription;
        }
        if (indexPath.row == 1) {
            titleStr = @"资金用途";
            detailStr = _aGoodDetail.BondData;
        }
        if (indexPath.row == 2) {
            titleStr = @"借款人信息";
            detailStr = _aGoodDetail.Remark;
        }
        
        GoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLabel.text = titleStr;
        cell.detailsLabel.text = detailStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (isSelect == 2){
        if (indexPath.row == 0) {
            titleStr = @"还款来源";
            detailStr = _aGoodDetail.Repayment;
        }
        if (indexPath.row == 1) {
            titleStr = @"风险控制";
            detailStr = _aGoodDetail.RiskControl;
        }
        GoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLabel.text = titleStr;
        cell.detailsLabel.text = detailStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        GoodNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellNum" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.textLabel1.text = @"投标人";
            cell.textLabel2.text = @"投标期限";
            cell.textLabel3.text = @"投标金额";
            cell.textLabel4.text = @"预计收益";
        }else{
            NSArray *cellArr = _dataArr3[indexPath.row - 1];
            cell.textLabel1.text =[NSString stringWithFormat:@"%@",cellArr[0]];
            cell.textLabel2.text =[NSString stringWithFormat:@"%@天",cellArr[1]];
            cell.textLabel3.text =[NSString stringWithFormat:@"%@元",cellArr[2]];
            NSString *money = cellArr[3];
            cell.textLabel4.text =[NSString stringWithFormat:@"%.2f元",[money doubleValue]];
        }
        return cell;
    }
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
