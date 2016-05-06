//
//  FocusonViewController.m
//  CaoDu
//
//  Created by jang on 16/3/26.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FocusonViewController.h"

@interface FocusonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *dataTableView;
@end

@implementation FocusonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    [self drawNa];
    [self drawView];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    
    [[UserDataTolls shareGetUserData]AttentionProjectJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID PassValue:^(NSMutableArray *code) {
        _dataArr = code;
        if (_dataArr.count > 0) {
            [self drawTable];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_dataTableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawNa{
    self.navigationItem.title = @"关注的项目";
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
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 145/PxWidth)/2, 112/PxHeight, 145/PxWidth, 125/PxHeight)];
    logoImageView.image = [UIImage imageNamed:@"小羊.png"];
    [self.view addSubview:logoImageView];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 24/PxHeight, kScreenWidth, 20/PxHeight)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont adapterFontOfSize:13.0];
    textLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    textLabel.text = @"hi,您还没有投标项目，快去投资吧！";
    [self.view addSubview:textLabel];
    UIButton *invButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(textLabel.frame) + 33/PxHeight, 230/PxWidth, 45/PxHeight);
    [invButton setTitle:@"立即投资" forState:UIControlStateNormal];
    invButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:invButton];
    [invButton addTarget:self action:@selector(invButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)drawTable{
    _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10/PxHeight, kScreenWidth, kScreenHeight - 10/PxHeight) style:UITableViewStylePlain];
    _dataTableView.backgroundColor = Color_back;
    [self.view addSubview:_dataTableView];
    [self setExtraCellLineHidden:_dataTableView];
    _dataTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _dataTableView.dataSource = self;
    _dataTableView.delegate = self;
    [_dataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)invButtonAction:(UIButton *)sender{
    MainTabController *mainTC = [[MainTabController alloc]init];
    mainTC.selectedIndex = 1;
    [self.navigationController presentViewController:mainTC animated:YES completion:nil];
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35/PxHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30/PxHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AttentionProjectModle *attention = [[AttentionProjectModle alloc]init];
    UIColor *fontColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    UIFont *lableFont = [UIFont adapterFontOfSize:12.0];
    attention = _dataArr[indexPath.row];
    NSString *prString = [NSString stringWithFormat:@"%.2f%%",[attention.SumPrice doubleValue]/[attention.Price doubleValue] * 100];
    NSString *allMoneyString = [NSString stringWithFormat:@"%.0f万",[attention.Price doubleValue]/10000];
    NSMutableArray *textArr = [NSMutableArray arrayWithObjects:attention.GoodsName,attention.RepaymentType,prString,allMoneyString,@"取消关注", nil];
    UIView *cellView = [self returnViewWithHeight:30/PxHeight Font:lableFont Color:fontColor textArr:textArr  Tag:indexPath.row];
    [cell addSubview:cellView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lu",indexPath.row);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIColor *fontColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    UIFont *lableFont = [UIFont adapterFontOfSize:13.0];
    NSMutableArray *textArr = [NSMutableArray arrayWithObjects:@"项目",@"投资类型",@"投资进度",@"众筹金额",@"取消关注", nil];
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35/PxHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    goodsNameLable.text = textArr[0];
    goodsNameLable.font = lableFont;
    goodsNameLable.textColor = fontColor;
    goodsNameLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:goodsNameLable];
    
    priceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNameLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    priceLable.text = textArr[1];
    priceLable.font = lableFont;
    priceLable.textColor = fontColor;
    priceLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:priceLable];
    
    fundRateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    fundRateLable.text = textArr[2];
    fundRateLable.font = lableFont;
    fundRateLable.textColor = fontColor;
    fundRateLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fundRateLable];
    
    timelimitLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fundRateLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame)/3*2)];
    timelimitLable.text = textArr[3];
    timelimitLable.font = lableFont;
    timelimitLable.textColor = fontColor;
    timelimitLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:timelimitLable];
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fundRateLable.frame), CGRectGetHeight(headView.frame)/3, kScreenWidth/5, CGRectGetHeight(headView.frame)/3*2)];
    moneyLabel.text = @"（万元）";
    moneyLabel.font = [UIFont adapterFontOfSize:9.0];
    moneyLabel.textColor = fontColor;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:moneyLabel];
    
    
    repaymentTypelable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timelimitLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    repaymentTypelable.text = textArr[4];
    repaymentTypelable.font = lableFont;
    repaymentTypelable.textColor = fontColor;
    repaymentTypelable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:repaymentTypelable];
    
    UILabel *leanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35/PxHeight, kScreenWidth, 1)];
    leanLabel.backgroundColor = Color_back;;
    [headView addSubview:leanLabel];
    headView.backgroundColor = [UIColor whiteColor];
    
    return headView;
}

-(UIView *)returnViewWithHeight:(CGFloat)height Font:(UIFont *)lableFont Color:(UIColor *)fontColor textArr:(NSMutableArray *)textArr Tag:(NSInteger)tag{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    goodsNameLable.text = textArr[0];
    goodsNameLable.font = lableFont;
    goodsNameLable.textColor = fontColor;
    goodsNameLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:goodsNameLable];
    
    priceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNameLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    priceLable.text = textArr[1];
    priceLable.font = lableFont;
    priceLable.textColor = fontColor;
    priceLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:priceLable];
    
    fundRateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    fundRateLable.text = textArr[2];
    fundRateLable.font = lableFont;
    fundRateLable.textColor = fontColor;
    fundRateLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fundRateLable];
    
    timelimitLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fundRateLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    timelimitLable.text = textArr[3];
    timelimitLable.font = lableFont;
    timelimitLable.textColor = fontColor;
    timelimitLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:timelimitLable];
    
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionButton.frame = CGRectMake(CGRectGetMaxX(timelimitLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame));
    
    repaymentTypelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    repaymentTypelable.text = textArr[4];
    repaymentTypelable.font = lableFont;
    repaymentTypelable.textColor = Color_Cyan;
    repaymentTypelable.textAlignment = NSTextAlignmentCenter;
    [attentionButton addSubview:repaymentTypelable];
    attentionButton.tag = 500+tag;
    [attentionButton addTarget:self action:@selector(attentionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:attentionButton];
    
    return headView;
}

-(void)attentionButtonAction:(UIButton *)sender{
    AttentionProjectModle *att = _dataArr[sender.tag - 500];
    
    [[UserDataTolls shareGetUserData]AttentionCollectionWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID RID:att.RID IsIsAttention:@"false" PassValue:^(NSMutableArray *code) {
        if ([code[0] integerValue] == 0) {
            [_dataArr removeObjectAtIndex:sender.tag - 500];
            if (_dataArr.count == 0) {
                [_dataTableView removeFromSuperview];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataTableView reloadData];
            });
            [self p_showAlertView:@"已取消关注" message:nil];
        }
    }];
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
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
