//
//  MyFinancingViewController.m
//  CaoDu
//
//  Created by jang on 16/4/1.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MyFinancingViewController.h"
#import "ScreeningView.h"
#import "GoodViewController.h"
@interface MyFinancingViewController ()<UIGestureRecognizerDelegate,IQActionSheetPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)ScreeningView *sv;
@property (nonatomic,strong)UITableView *dataTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *goodNameTbaleView;

@end

@implementation MyFinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self drawView];
    self.sv = [[ScreeningView alloc]initWithFrame:CGRectMake(0, -170/PxHeight, kScreenWidth, 170/PxHeight)];
    [self.view addSubview:_sv];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    [_sv.starTimeButton addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sv.endTimeButton addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sv.emptyButton addTarget:self action:@selector(emptyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sv.determineButton addTarget:self action:@selector(determineButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    BeginTime = @"";
    EndTime = @"";
    PageSize = 10;
    [self drawTable];
    [self p_data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawNa{
    self.navigationItem.title = @"我的融资";
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
    
    UIButton *rightButton = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"iconfont-shaixuan(1).png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
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
    textLabel.text = @"hi,您还没有融资项目，快去融资吧！";
    [self.view addSubview:textLabel];
    UIButton *invButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(textLabel.frame) + 33/PxHeight, 230/PxWidth, 45/PxHeight);
    [invButton setTitle:@"立即融资" forState:UIControlStateNormal];
    invButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:invButton];
    [invButton addTarget:self action:@selector(invButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)drawTable{
    _goodNameTbaleView =[[UITableView alloc]initWithFrame:CGRectMake(0, 10/PxHeight, kScreenWidth/4, kScreenHeight - 10/PxHeight) style:UITableViewStylePlain];
    _goodNameTbaleView.backgroundColor = Color_back;
    [_goodNameTbaleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_goodNameTbaleView];
    [self setExtraCellLineHidden:_goodNameTbaleView];
    _goodNameTbaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _goodNameTbaleView.dataSource = self;
    _goodNameTbaleView.delegate = self;
    _goodNameTbaleView.userInteractionEnabled = YES;
    [self.view addSubview:_goodNameTbaleView];
    
    _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*1.75, kScreenHeight - 10/PxHeight) style:UITableViewStylePlain];
    _dataTableView.backgroundColor = Color_back;
    [self.view addSubview:_dataTableView];
    [self setExtraCellLineHidden:_dataTableView];
    _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataTableView.dataSource = self;
    _dataTableView.delegate = self;
    _dataTableView.userInteractionEnabled = YES;
    backSCrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(kScreenWidth/4 - 1, 10/PxHeight, kScreenWidth*0.75, kScreenHeight - 10/PxHeight)];
    backSCrollView.contentSize = CGSizeMake(kScreenWidth*1.75, CGRectGetHeight(_dataTableView.frame));
    backSCrollView.showsHorizontalScrollIndicator = NO;
    backSCrollView.showsVerticalScrollIndicator = NO;
    backSCrollView.bounces = NO;
    backSCrollView.userInteractionEnabled = YES;
    [backSCrollView addSubview:_dataTableView];
    [self.view addSubview:backSCrollView];
    [_dataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view bringSubviewToFront:_goodNameTbaleView];
}

-(void)p_data{
    [[UserDataTolls shareGetUserData]MyFinancingJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID BeginTime:BeginTime EndTime:EndTime PageSize:PageSize PassValue:^(NSMutableArray *code) {
        _dataArr = code;
        if (_dataArr.count == 0) {
            _goodNameTbaleView.hidden = YES;
            _dataTableView.hidden = YES;
        }else{
            _goodNameTbaleView.hidden = NO;
            _dataTableView.hidden = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_goodNameTbaleView reloadData];
                [_dataTableView reloadData];
            });
        }
    }];
}

-(void)invButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)rightBar:(UINavigationItem *)sender{
    if (CGRectGetMinY(_sv.frame) == 0) {
        [self emptyButtonAction:nil];
        [UIView animateWithDuration:0.5 animations:^{
            _sv.frame = CGRectMake(0, -170/PxHeight, kScreenWidth, 170/PxHeight);
        }];
    }else{
        [self.view bringSubviewToFront:_sv];
        [UIView animateWithDuration:0.5 animations:^{
            _sv.frame = CGRectMake(0, 0, kScreenWidth, 170/PxHeight);
        }];
    }
    
}

-(void)emptyButtonAction:(UIButton *)sender{
    _sv.starTimeLabel.text = @"--请选择开始时间--";
    _sv.endTimeLabel.text = @"--请选择结束时间--";
}

-(void)determineButtonAction:(UIButton *)sender{
    if ([_sv.starTimeLabel.text isEqualToString:@"--请选择开始时间--"]) {
        [self p_showAlertView:@"请选择开始时间" message:nil];
    }else if([_sv.endTimeLabel.text isEqualToString:@"--请选择结束时间--"])
    {
        [self p_showAlertView:@"请选择结束时间" message:nil];
    }else{
        BeginTime = _sv.starTimeLabel.text;
        EndTime = _sv.endTimeLabel.text;
        [self p_data];
        [self emptyButtonAction:nil];
        [UIView animateWithDuration:0.5 animations:^{
            _sv.frame = CGRectMake(0, -170/PxHeight, kScreenWidth, 170/PxHeight);
        }];
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(id)sender
{
    CGPoint point = [sender locationInView:self.view];
    if (point.y < 170/PxHeight) {
        
    }else{
        [self emptyButtonAction:nil];
        [UIView animateWithDuration:0.5 animations:^{
            _sv.frame = CGRectMake(0, -170/PxHeight, kScreenWidth, 170/PxHeight);
        }];
    }
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


-(void)datePickerAction:(UIButton *)sender{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
    if (sender == _sv.starTimeButton) {
        [picker setTag:1];
    }else{
        [picker setTag:2];
    }
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    NSDate *date = (NSDate *)titles[0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    if (pickerView.tag == 1) {
        _sv.starTimeLabel.text = [dateformatter stringFromDate:date];
    }else{
        _sv.endTimeLabel.text = [dateformatter stringFromDate:date];
    }
    
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
    return 40/PxHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyFinancingModle *myFinancing = [[MyFinancingModle alloc]init];

    UIColor *fontColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    UIFont *lableFont = [UIFont adapterFontOfSize:12.0];
    myFinancing = _dataArr[indexPath.row];
    NSString *operation = [NSString string];
    if ([tableView isEqual:_goodNameTbaleView]) {
        cell.textLabel.font = lableFont;
        cell.textLabel.textColor = fontColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:applyTimeLable];
        cell.textLabel.text = myFinancing.GoodsName;
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
        }
        if ([myFinancing.State isEqualToString:@"招标中"]) {
            operation = @"查看详情";
        }else{
            operation = @"等待审核";
        }
        NSMutableArray *textArr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@",[self returnUploadETime:myFinancing.CreateTime]],[NSString stringWithFormat:@"%@",myFinancing.FundRate],myFinancing.Price,[NSString stringWithFormat:@"%@",[self returnUploadETime:myFinancing.StartTime]],[NSString stringWithFormat:@"%@",[self returnUploadETime:myFinancing.StopTime]],myFinancing.State,operation,nil];
        UIView *cellView = [self returnViewWithHeight:40/PxHeight Font:lableFont Color:fontColor textArr:textArr IndexPath:1];
        [cell.contentView addSubview:cellView];
        
        UIButton *operationCellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        operationCellButton.frame = CGRectMake(CGRectGetWidth(cell.frame) - kScreenWidth*0.3, 0, kScreenWidth*0.3, CGRectGetHeight(cell.frame));
        [operationCellButton setTitle:[NSString stringWithFormat:@"%@",operation] forState:UIControlStateNormal];
        operationCellButton.titleLabel.font = lableFont;
        [operationCellButton setTitleColor:fontColor forState:UIControlStateNormal];
        operationCellButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        operationCellButton.tag = 300+indexPath.row;
        [operationCellButton addTarget:self action:@selector(operationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:operationCellButton];
        
    }
    UILabel *leanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 39/PxHeight, kScreenWidth*2, 1)];
    leanLabel.backgroundColor = Color_back;;
    [cell.contentView addSubview:leanLabel];

    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_goodNameTbaleView]) {
        UIView *tempView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 35/PxHeight)];
        goodNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 35/PxHeight)];
        goodNameLable.text = @"项目名称";
        goodNameLable.font = [UIFont adapterFontOfSize:13.0];
        goodNameLable.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
        goodNameLable.textAlignment = NSTextAlignmentCenter;
        [tempView addSubview:goodNameLable];
        UILabel *leanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35/PxHeight, kScreenWidth/4, 1)];
        leanLabel.backgroundColor = Color_back;
        [tempView addSubview:leanLabel];
        tempView.backgroundColor = [UIColor whiteColor];
        return tempView;
    }else if ([tableView isEqual:_dataTableView]) {
        UIColor *fontColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
        UIFont *lableFont = [UIFont adapterFontOfSize:13.0];
        NSMutableArray *textArr = [NSMutableArray arrayWithObjects:@"申请日期",@"年化收益",@"金额(元)",@"投资开始日期",@"还款开始日期",@"状态",@"操作", nil];
        UIView *tempView = [self returnViewWithHeight:35/PxHeight Font:lableFont Color:fontColor textArr:textArr IndexPath:0];
        UILabel *leanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35/PxHeight, kScreenWidth*2, 1)];
        leanLabel.backgroundColor = Color_back;
        [tempView addSubview:leanLabel];
        tempView.backgroundColor = [UIColor whiteColor];
        return tempView;
    }
    return nil;
}


-(UIView *)returnViewWithHeight:(CGFloat)height Font:(UIFont *)lableFont Color:(UIColor *)fontColor textArr:(NSMutableArray *)textArr IndexPath:(NSInteger)indexPath{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    applyTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, CGRectGetHeight(headView.frame))];
    applyTimeLable.text = [NSString stringWithFormat:@"%@",textArr[0]];
    applyTimeLable.font = lableFont;
    applyTimeLable.textColor = fontColor;
    applyTimeLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:applyTimeLable];
    
    investTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(applyTimeLable.frame), 0, kScreenWidth/4, CGRectGetHeight(headView.frame))];
    investTimeLable.text = [NSString stringWithFormat:@"%@",textArr[1]];
    investTimeLable.font = lableFont;
    investTimeLable.textColor = fontColor;
    investTimeLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:investTimeLable];
    
    reimburseTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(investTimeLable.frame), 0, kScreenWidth/4, CGRectGetHeight(headView.frame))];
    reimburseTimeLable.text = [NSString stringWithFormat:@"%@",textArr[2]];
    reimburseTimeLable.font = lableFont;
    reimburseTimeLable.textColor = fontColor;
    reimburseTimeLable.textAlignment = NSTextAlignmentCenter;
    reimburseTimeLable.numberOfLines = 0;
    [headView addSubview:reimburseTimeLable];
    
    
    rateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(reimburseTimeLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    rateLable.text = [NSString stringWithFormat:@"%@",textArr[3]];
    rateLable.font = lableFont;
    rateLable.textColor = fontColor;
    rateLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:rateLable];
    
    moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rateLable.frame), 0, kScreenWidth*0.3, CGRectGetHeight(headView.frame))];
    moneyLable.text = [NSString stringWithFormat:@"%@",textArr[4]];
    moneyLable.font = lableFont;
    moneyLable.textColor = fontColor;
    moneyLable.textAlignment = NSTextAlignmentCenter;
    moneyLable.numberOfLines = 0;
    [headView addSubview:moneyLable];
    
    stateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moneyLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    stateLable.text = [NSString stringWithFormat:@"%@",textArr[5]];
    stateLable.font = lableFont;
    if (![textArr[5]isEqualToString:@"状态"]) {
        stateLable.textColor = [UIColor redColor];
    }else{
        stateLable.textColor = fontColor;
    }
    stateLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:stateLable];
    
    if (indexPath == 0) {
        operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        operationButton.frame = CGRectMake(CGRectGetMaxX(stateLable.frame), 0, kScreenWidth*0.3, CGRectGetHeight(headView.frame));
        [operationButton setTitle:[NSString stringWithFormat:@"%@",textArr[6]] forState:UIControlStateNormal];
        operationButton.titleLabel.font = lableFont;
        [operationButton setTitleColor:fontColor forState:UIControlStateNormal];
        operationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:operationButton];
    }
    
    return headView;
}
-(void)operationButtonAction:(UIButton *)sender{

    GoodViewController *gVC = [[GoodViewController alloc]init];
    MyFinancingModle *myFinancing = _dataArr[sender.tag - 300];
    if ([myFinancing.State isEqualToString:@"招标中"]) {
        gVC.goodID = myFinancing.BID;
        [self.navigationController pushViewController:gVC animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:(_dataTableView)]) {
        _goodNameTbaleView.contentOffset = scrollView.contentOffset;
    }
    if ([scrollView isEqual:(_goodNameTbaleView)]) {
        _dataTableView.contentOffset = scrollView.contentOffset;
    }
}

- (NSString *) returnUploadETime:(NSString *)timeStr
{
    if (timeStr.length < 1) {
        return @"--";
    }
    NSArray *parArray = [timeStr componentsSeparatedByString:@"("];
    
    timeStr = [parArray[1] componentsSeparatedByString:@")"][0];
    
    NSTimeInterval timeInterval = [timeStr doubleValue]/1000;
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    return [dateformatter stringFromDate:date2];
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
