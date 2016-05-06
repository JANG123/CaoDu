//
//  UserViewController.m
//  CaoDu
//
//  Created by jang on 16/3/18.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "UserViewController.h"
#import "UserCollectionViewCell.h"
#import "SettingTableViewController.h"
#import "TopUpViewController.h"
#import "TopUpMoneyViewController.h"
#import "TopSucssViewController.h"
#import "ExtViewController.h"
#import "AddBankViewController.h"
#import "MyInvestmentViewController.h"
#import "EarningViewController.h"
#import "FocusonViewController.h"
#import "MoneyDetailsViewController.h"
#import "RedPacketsViewController.h"
#import "MyFinancingViewController.h"
#import "InviteViewController.h"
@interface UserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *classCollectView;
@property (weak, nonatomic) IBOutlet UIImageView *moneyImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic,strong)UIImageView *erweimaImage;
@property (nonatomic,strong)UILabel *availableMoney;
@property (nonatomic,strong)UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UIImageView *textImageView;
@property (weak, nonatomic) IBOutlet UILabel *renzhengLabel;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImageView;
@property (nonatomic,strong)UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //KVO刷新资金数据
    [[UserAccount shareGetUserAccountDate] addObserver:self forKeyPath:@"WaitingMoney" options:NSKeyValueObservingOptionNew context:nil];
    [self drawNavigation];
    [self p_setUpView];
    [self p_Collection];
    //加载数据
    [self p_data];
    // Do any additional setup after loading the view from its nib.
}

//KVO刷新资金数据
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self p_data];
}

-(void)p_data{
    if ([UserAccount UserName].length > 1) {
        _infoLabel.hidden = NO;
        _availableMoney.hidden = NO;
        _totalMoney.hidden = NO;
        _renzhengLabel.hidden = NO;
        _renzhengImageView.hidden = NO;
        _loginButton.hidden = YES;
    _infoLabel.text = [NSString stringWithFormat:@"%@  %@",[UserAccount shareGetUserAccountDate].aUser.Name, [UserAccount shareGetUserAccountDate].aUser.Tel];
    _availableMoney.text = [NSString stringWithFormat:@"%@",[UserAccount shareGetUserAccountDate].aUser.MyFund];
    _totalMoney.text = [NSString stringWithFormat:@"%@",[UserAccount shareGetUserAccountDate].aUser.WaitingMoney];
    //[((UIScrollView *)self.view).header endRefreshing];
    }else{
        _infoLabel.hidden = YES;
        _availableMoney.hidden = YES;
        _totalMoney.hidden = YES;
        _renzhengLabel.hidden = YES;
        _renzhengImageView.hidden = YES;
        _loginButton.hidden = NO;
    }
}

-(void)drawNavigation{
    
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"iconfont-sitting.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    self.navigationItem.title = @"我的账户";
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark --UIButtonAction

-(void)rightButton:(UIButton *)sender{
    if ([UserAccount UserName].length > 1) {
    SettingTableViewController *stVC = [[SettingTableViewController alloc]init];
    [self.navigationController pushViewController:stVC animated:YES];
    }else{
        [self p_showAlertView:@"请登录" message:nil];
    }
}

-(void)p_setUpView{
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(CGRectGetMinX(_infoLabel.frame), CGRectGetMinY(_infoLabel.frame), CGRectGetWidth(_infoLabel.frame), CGRectGetHeight(_renzhengLabel.frame) + CGRectGetHeight(_infoLabel.frame) + 12);
    _loginButton.backgroundColor = [UIColor clearColor];
    UILabel *loginLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_loginButton.frame), CGRectGetHeight(_loginButton.frame))];
    loginLabel.textAlignment = NSTextAlignmentLeft;
    loginLabel.text = @"点击登录";
    loginLabel.textColor = [UIColor whiteColor];
    [_loginButton addSubview:loginLabel];
    [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _erweimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 104/PxWidth, 31/PxHeight, 43, 43)];
    [_erweimaImage setImage:[UIImage imageNamed:@"erweima.png"]];
    [self.view addSubview:_erweimaImage];
    
    
    UILabel *availableText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, CGRectGetHeight(_moneyImageView.frame)/2)];
    availableText.text = @"可用金额（元）";
    availableText.textAlignment = NSTextAlignmentCenter;
    availableText.font = [UIFont adapterFontOfSize:12.0];
    availableText.textColor = [UIColor whiteColor];
    [_moneyImageView addSubview:availableText];
    
    UILabel *totalText = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, CGRectGetHeight(_moneyImageView.frame)/2)];
    totalText.text = @"待收总额（元）";
    totalText.textAlignment = NSTextAlignmentCenter;
    totalText.font = [UIFont adapterFontOfSize:12.0];
    totalText.textColor = [UIColor whiteColor];
    [_moneyImageView addSubview:totalText];
    
    _availableMoney = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_moneyImageView.frame)/2, kScreenWidth/2, CGRectGetHeight(_moneyImageView.frame)/2)];
    _availableMoney.text = @"0.00";
    _availableMoney.textAlignment = NSTextAlignmentCenter;
    _availableMoney.font = [UIFont adapterFontOfSize:18.0];
    _availableMoney.textColor = [UIColor whiteColor];
    [_moneyImageView addSubview:_availableMoney];
    
    _totalMoney = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetHeight(_moneyImageView.frame)/2, kScreenWidth/2, CGRectGetHeight(_moneyImageView.frame)/2)];
    _totalMoney.text = @"0.00";
    _totalMoney.textAlignment = NSTextAlignmentCenter;
    _totalMoney.font = [UIFont adapterFontOfSize:18.0];
    _totalMoney.textColor = [UIColor whiteColor];
    [_moneyImageView addSubview:_totalMoney];
    
    _textImageView.userInteractionEnabled = YES;
    
    UIButton *topUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    topUpButton.frame = CGRectMake(0, 0, kScreenWidth/2, CGRectGetHeight(_textImageView.frame));
    topUpButton.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [topUpButton setTitle:@"充值" forState:UIControlStateNormal];
    [topUpButton setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topUpButton addTarget:self action:@selector(topUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_textImageView addSubview:topUpButton];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 5, 1, CGRectGetHeight(_textImageView.frame) - 10)];
    lineLabel.backgroundColor = Color_back;
    [_textImageView addSubview:lineLabel];
    
    UIButton *extractButton = [UIButton buttonWithType:UIButtonTypeSystem];
    extractButton.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, CGRectGetHeight(_textImageView.frame));
    extractButton.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [extractButton setTitle:@"提现" forState:UIControlStateNormal];
    [extractButton setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [extractButton addTarget:self action:@selector(extractButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_textImageView addSubview:extractButton];
}

//登录
-(void)loginButtonAction{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:lv animated:YES];
}

-(void)topUpButtonAction:(UIButton *)sender{
    if ([UserAccount UserName].length > 1) {
    [[UserDataTolls shareGetUserData]SelectBankWithPassValue:^(NSMutableArray *code) {
//        if (code.count > 0) {
            TopUpMoneyViewController *tv = [[TopUpMoneyViewController alloc]init];
            [self.navigationController pushViewController:tv animated:YES];
//        }else{
//            TopUpViewController *tv = [[TopUpViewController alloc]init];
//            [self.navigationController pushViewController:tv animated:YES];
//        }
    }];}else{
        [self p_showAlertView:@"请登录" message:nil];
    }
}

-(void)extractButtonAction:(UIButton *)sender{
    if ([UserAccount UserName].length > 1) {
    ExtViewController *ev = [[ExtViewController alloc]init];
    [self.navigationController pushViewController:ev animated:YES];
    }else{
        [self p_showAlertView:@"请登录" message:nil];
    }
}

-(void)p_Collection{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [self.view addSubview:_classCollectView];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _classCollectView.dataSource=self;
    _classCollectView.delegate=self;
    
    //注册Cell，必须要有
    [_classCollectView registerClass:[UserCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UserCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.logoImageView setImage:[UIImage imageNamed:[self collectCellImage:indexPath]]];
    cell.textLable.text = [self collectCellText:indexPath];
    
    
    [self drawLine:indexPath.row];
    return cell;
}

-(NSString *)collectCellText:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
            return @"银行卡";
        }else if(indexPath.row == 1){
            return @"我的投资";
        }else if(indexPath.row == 2){
            return @"我的融资";
        }else if (indexPath.row == 3){
            return @"收益/回款";
        }else if (indexPath.row == 4) {
            return @"关注的项目";
        }else if(indexPath.row == 5){
            return @"资金明细";
        }else if(indexPath.row == 6){
            return @"邀请好友";
        }else if(indexPath.row == 7){
            return @"我的红包";
        }
    return @"";
}

-(NSString *)collectCellImage:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return @"iconfont-xinyongqiafenqi.png";
    }else if(indexPath.row == 1){
        return @"iconfont-weixuanzhongyuanquan.png";
    }else if(indexPath.row == 2){
        return @"iconfont-rongzizonge.png";
    }else if (indexPath.row == 3){
        return @"iconfont-17jiekuanjiluicon01z.png";
    }else if (indexPath.row == 4) {
        return @"iconfont-weixuanzhongyuanquan(1).png";
    }else if(indexPath.row == 5){
        return @"iconfont-servicequanqiutongjia-拷贝.png";
    }else if(indexPath.row == 6){
        return @"iconfont-31haoyou(1)";
    }else if(indexPath.row == 7){
        return @"iconfont-hongbao.png";
    }
    return @"";
}

-(void)drawLine:(NSInteger)row{
    CGSize contentSize = _classCollectView.contentSize;
    if(didAddSperateVerticalLine == NO) {
        UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(contentSize.width/3 - 0.5, 0, 1, contentSize.height)];
        verticalLine.backgroundColor = [UIColor lightGrayColor];//colorWithRed:225/225.0f green:227/225.0f blue:233/225.0f alpha:1.0];
        verticalLine.alpha = 0.35;
        [_classCollectView addSubview:verticalLine];
        
        UIView *verticalLine2 = [[UIView alloc]initWithFrame:CGRectMake(contentSize.width*2/3 - 0.5, 0, 1, contentSize.height)];
        verticalLine2.backgroundColor = [UIColor lightGrayColor];//colorWithRed:225/225.0f green:227/225.0f blue:233/225.0f alpha:1.0];
        verticalLine2.alpha = 0.35;
        [_classCollectView addSubview:verticalLine2];
        
        didAddSperateVerticalLine = YES;
    }
    
    UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_classCollectView.frame)/3 * row , contentSize.width, 1)];//每一个cell的framee是 17.00, 10.00, 160.00, 160.00  ,
    horizontalLine.backgroundColor = [UIColor lightGrayColor];
    horizontalLine.alpha = 0.35;
    [_classCollectView addSubview:horizontalLine];
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(_classCollectView.frame)/3, CGRectGetHeight(_classCollectView.frame)/3);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark --UICollectionViewDelegate


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserAccount UserName].length > 1) {
    if (indexPath.row == 0) {
        AddBankViewController *av = [[AddBankViewController alloc]init];
        [self.navigationController pushViewController:av animated:YES];
    }else if(indexPath.row == 1){
        MyInvestmentViewController *mv = [[MyInvestmentViewController alloc]init];
        [self.navigationController pushViewController:mv animated:YES];
    }else if(indexPath.row == 2){
        MyFinancingViewController *mv = [[MyFinancingViewController alloc]init];
        [self.navigationController pushViewController:mv animated:YES];
    }else if (indexPath.row == 3){
        EarningViewController *ev = [[EarningViewController alloc]init];
        [self.navigationController pushViewController:ev animated:YES];
    }else if (indexPath.row == 4) {
        FocusonViewController *fv = [[FocusonViewController alloc]init];
        [self.navigationController pushViewController:fv animated:YES];
    }else if(indexPath.row == 5){
        MoneyDetailsViewController *mv = [[MoneyDetailsViewController alloc]init];
        [self.navigationController pushViewController:mv animated:YES];
    }else if(indexPath.row == 6){
        InviteViewController *iv = [[InviteViewController alloc]init];
        [self.navigationController pushViewController:iv animated:YES];
    }else if(indexPath.row == 7){
        RedPacketsViewController *rv = [[RedPacketsViewController alloc]init];
        [self.navigationController pushViewController:rv animated:YES];
    }
    }else{
        [self p_showAlertView:@"请登录" message:nil];
    }


}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
