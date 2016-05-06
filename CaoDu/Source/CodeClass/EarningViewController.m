//
//  EarningViewController.m
//  CaoDu
//
//  Created by jang on 16/3/26.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "EarningViewController.h"
@interface EarningViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *dataTableView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UILabel *allMoneyText;
@property (nonatomic,strong)UILabel *allNumText;
@property (nonatomic,strong)NSString *locationString;

@property (strong,nonatomic) UIPickerView *datePicker;
@property (strong,nonatomic) UIView*timeSelectView;
@property (strong,nonatomic) UIButton *timeButtonLabel;
@property (strong,nonatomic) UIButton *cancelSelectTimeButton;
@property (strong,nonatomic) UIButton *determineSelectTimeButton;
@property (strong,nonatomic) NSMutableArray *myArray1;
@property (strong,nonatomic) NSMutableArray *myArray;
@property (strong,nonatomic) NSString  *timeSelectedString;
@property (strong,nonatomic) NSString  *str10;
@property (strong,nonatomic) NSString  *str11;
@end

@implementation EarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self drawView];
    _dataArr = [NSMutableArray array];
    [self p_datePick];
//    [self.view addSubview:self.timeButtonLabel];
//    [self.view addSubview:self.timeSelectView];
    
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr =[dateformatter stringFromDate:senddate];
    [self p_dataWithDate:dateStr];
}

-(void)p_datePick{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月"];
    self.str10 = [formatter stringFromDate:[NSDate date]];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy年"];
    self.str11 = [formatter1 stringFromDate:[NSDate date]];
    self.timeSelectedString = [NSString stringWithFormat:@"%@%@",self.str11,self.str10];
    //设置pickerview初始默认
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"MM"];
    NSString *str111 = [formatter2 stringFromDate:[NSDate date]];
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
    [formatter3 setDateFormat:@"yyyy"];
    NSString *str222 = [formatter3 stringFromDate:[NSDate date]];
    int a = [str111 intValue];
    int b = [str222 intValue];
    [self.datePicker selectRow:a-1 inComponent:1 animated:NO];
    [self.datePicker selectRow:b-1900 inComponent:0 animated:NO];
}

-(void)p_dataWithDate:(NSString *)dateStr{
    NSArray *beginArr = [dateStr componentsSeparatedByString:@"-"];
    NSString *beginTime = [NSString stringWithFormat:@"%@-%@-01",beginArr[0],beginArr[1]];
    [[UserDataTolls shareGetUserData]EarningsJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID BeginTime:beginTime EndTime:dateStr PassValue:^(NSMutableArray *code) {
        _dataArr = code;
        if (code.count > 0) {
            if (_backView == nil) {
                [self drawTable];
            }
            double allMoney = 0;
            for (NSArray *arr in _dataArr) {
                allMoney = allMoney + [arr[1] doubleValue];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dataTableView reloadData];
                _allMoneyText.text = [NSString stringWithFormat:@"%.2f",allMoney];
                _allNumText.text = [NSString stringWithFormat:@"%lu",_dataArr.count];
            });
        }else{
        _backView.hidden = YES;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)drawNa{
    self.navigationItem.title = @"收益回款";
    [self.view setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0]];
    
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
    textLabel.text = @"hi,您还没有回款记录，快去投资吧！";
    [self.view addSubview:textLabel];
    UIButton *invButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(textLabel.frame) + 33/PxHeight, 230/PxWidth, 45/PxHeight);
    [invButton setTitle:@"立即投资" forState:UIControlStateNormal];
    invButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:invButton];
    [invButton addTarget:self action:@selector(invButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}



-(void)leftBar:(UINavigationItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)invButtonAction:(UIButton *)sender{
    MainTabController *mainTC = [[MainTabController alloc]init];
    mainTC.selectedIndex = 1;
    [self.navigationController presentViewController:mainTC animated:YES completion:nil];
}

-(void)drawTable{
    _backView = [[UIView alloc]initWithFrame:self.view.frame];
    _backView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.view addSubview:_backView];
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(13/PxWidth, 10/PxHeight, kScreenWidth - 26/PxWidth, 100/PxHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [headView.layer setMasksToBounds:YES];
    [headView.layer setCornerRadius:5.0];
    [_backView addSubview:headView];
    
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年MM月"];
    _locationString =[dateformatter stringFromDate:senddate];
    NSString *dataStr = _locationString;
    
    UIImageView *datePickBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), 45/PxHeight)];
    datePickBackImage.image = [UIImage imageNamed:@"收益回收.png"];
    [headView addSubview:datePickBackImage];
    datePickBackImage.userInteractionEnabled = YES;
    
    datePickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    datePickButton.frame = CGRectMake(0, 0, CGRectGetWidth(headView.frame), 45/PxHeight);
    [datePickButton setTitle:dataStr forState:UIControlStateNormal];
    [datePickButton addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [datePickBackImage addSubview:datePickButton];
    
    UILabel *allMoney = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(datePickButton.frame), CGRectGetWidth(headView.frame)/2, 55/PxHeight/3)];
    allMoney.text = @"回款总额（元）";
    allMoney.textColor = Color_Cyan;
    allMoney.font = [UIFont adapterFontOfSize:12.0];
    allMoney.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:allMoney];
    
    _allMoneyText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(allMoney.frame), CGRectGetMaxY(allMoney.frame), CGRectGetWidth(headView.frame)/2, 55/PxHeight/3*2)];
    _allMoneyText.text = @"0";
    _allMoneyText.textColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0];
    _allMoneyText.font = [UIFont adapterFontOfSize:18.0];
    _allMoneyText.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:_allMoneyText];
    
    UILabel *allNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allMoney.frame), CGRectGetMaxY(datePickButton.frame), CGRectGetWidth(headView.frame)/2, CGRectGetHeight(allMoney.frame))];
    allNum.text = @"回款笔数";
    allNum.textColor = Color_Cyan;
    allNum.font = [UIFont adapterFontOfSize:12.0];
    allNum.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:allNum];
    
    _allNumText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(allNum.frame), CGRectGetMaxY(allNum.frame), CGRectGetWidth(headView.frame)/2, CGRectGetHeight(_allMoneyText.frame))];
    _allNumText.text = @"0";
    _allNumText.textColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0];
    _allNumText.font = [UIFont adapterFontOfSize:18.0];
    _allNumText.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:_allNumText];
    
    
    _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(headView.frame), CGRectGetMaxY(headView.frame) + 10/PxHeight, CGRectGetWidth(headView.frame), kScreenHeight - CGRectGetMaxY(headView.frame) - 10/PxHeight) style:UITableViewStylePlain];
    _dataTableView.backgroundColor = [UIColor clearColor];
    _dataTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_backView addSubview:_dataTableView];
    [self setExtraCellLineHidden:_dataTableView];
    _dataTableView.dataSource = self;
    _dataTableView.delegate = self;
    [_dataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
//{
//    NSDate *date = (NSDate *)titles[0];
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY年MM月"];
//    [datePickButton setTitle:[dateformatter stringFromDate:date] forState:UIControlStateNormal];
//}

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
    NSMutableArray *tempArr = [NSMutableArray array];
    UIColor *fontColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    UIFont *lableFont = [UIFont adapterFontOfSize:12.0];
    tempArr = _dataArr[indexPath.row];
    
    NSString *StartTime = [NSString stringWithFormat:@"%@",tempArr[0]];
    NSString *BackMoney = [NSString stringWithFormat:@"%@",tempArr[1]];
    NSString *Price = [NSString stringWithFormat:@"%.2f",[tempArr[2] doubleValue]];
    NSString *AllMoney = [NSString stringWithFormat:@"%.2f",[tempArr[1] doubleValue] + [tempArr[2] doubleValue]];
    
    NSMutableArray *textArr = [NSMutableArray arrayWithObjects:[self returnUploadETime:StartTime],BackMoney,Price,AllMoney, nil];
    UIView *cellView = [self returnViewWithHeight:30/PxHeight Font:lableFont Color:fontColor textArr:textArr];
    [cell addSubview:cellView];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIColor *fontColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    UIFont *lableFont = [UIFont adapterFontOfSize:13.0];
    NSMutableArray *textArr = [NSMutableArray arrayWithObjects:@"时间",@"已经回款(元)",@"待收回款(元)",@"总金额(元)", nil];
    UIView *tempView = [self returnViewWithHeight:35/PxHeight Font:lableFont Color:fontColor textArr:textArr];
    UILabel *leanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35/PxHeight, kScreenWidth, 1)];
    leanLabel.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [tempView addSubview:leanLabel];
    tempView.backgroundColor = [UIColor whiteColor];
    return tempView;
}

-(UIView *)returnViewWithHeight:(CGFloat)height Font:(UIFont *)lableFont Color:(UIColor *)fontColor textArr:(NSMutableArray *)textArr{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), height)];
    //headView.backgroundColor = [UIColor whiteColor];
    goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame)/4, CGRectGetHeight(headView.frame))];
    goodsNameLable.text = textArr[0];
    goodsNameLable.font = lableFont;
    goodsNameLable.textColor = fontColor;
    goodsNameLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:goodsNameLable];
    
    priceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNameLable.frame), 0, CGRectGetWidth(headView.frame)/4, CGRectGetHeight(headView.frame))];
    priceLable.text = textArr[1];
    priceLable.font = lableFont;
    priceLable.textColor = fontColor;
    priceLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:priceLable];

    fundRateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame), 0, CGRectGetWidth(headView.frame)/4, CGRectGetHeight(headView.frame))];
    fundRateLable.text = textArr[2];
    fundRateLable.font = lableFont;
    fundRateLable.textColor = fontColor;
    fundRateLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fundRateLable];
    
    timelimitLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fundRateLable.frame), 0, CGRectGetWidth(headView.frame)/4, CGRectGetHeight(headView.frame))];
    timelimitLable.text = textArr[3];
    timelimitLable.font = lableFont;
    timelimitLable.textColor = fontColor;
    timelimitLable.textAlignment = NSTextAlignmentCenter;

    [headView addSubview:timelimitLable];
    return headView;
}

-(UIView *)timeSelectView{
    if (!_timeSelectView) {
        _timeSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 210)];
        _timeSelectView.backgroundColor = [UIColor whiteColor];
        [_timeSelectView addSubview:self.datePicker];
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
        doneButton.frame = CGRectMake(0, CGRectGetHeight(_datePicker.frame), kScreenWidth, 44);
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(determineSelectTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_timeSelectView addSubview:doneButton];
    }
    return _timeSelectView;
}

-(UIPickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 166)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.dataSource = self;
        _datePicker.delegate = self;
    }
    return _datePicker;
}


- (NSString *) returnUploadETime:(NSString *)timeStr
{
    NSArray *parArray = [timeStr componentsSeparatedByString:@"("];
    
    timeStr = [parArray[1] componentsSeparatedByString:@")"][0];
    
    NSTimeInterval timeInterval = [timeStr doubleValue]/1000;
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    return [dateformatter stringFromDate:date2];
}

-(void)datePickerAction:(UIButton *)sender{
    [self.view addSubview:self.timeSelectView];
    [UIView animateWithDuration:0.3 animations:^{
        self.timeSelectView.frame = CGRectMake(0, kScreenHeight-274, kScreenWidth, 210);
    }];
}

-(void)determineSelectTimeButtonAction{
    NSString *timeStr =[NSString stringWithFormat:@"%@%@",self.myArray[[_datePicker selectedRowInComponent: 0]],self.myArray1[[_datePicker selectedRowInComponent: 1]]];
    [datePickButton setTitle:timeStr forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.timeSelectView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 210);
    }];
    
    NSDateFormatter *inputFormatter1 = [[NSDateFormatter alloc] init];
    [inputFormatter1 setDateFormat:@"yyyy年MM月"];
    NSDate*inputDate1  = [inputFormatter1 dateFromString:timeStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:inputDate1];
    NSUInteger numberOfDaysInMonth = range.length;
    
    timeStr = [NSString stringWithFormat:@"%@%lu日",timeStr,numberOfDaysInMonth];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate*inputDate  = [inputFormatter dateFromString:timeStr];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    
    [self p_dataWithDate:str];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        self.str11 = self.myArray[row];
    }else{
        self.str10 = self.myArray1[row];
    }
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"MM"];
    NSString *str111 = [formatter2 stringFromDate:[NSDate date]];
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
    [formatter3 setDateFormat:@"yyyy"];
    NSString *str222 = [formatter3 stringFromDate:[NSDate date]];
    int a = [str111 intValue];
    int b = [str222 intValue];
    int c = [self.str10 intValue];
    int d = [self.str11 intValue];
    if (d>b||(d==b&&c>a)) {
        [self.datePicker selectRow:a-1 inComponent:1 animated:YES];
        [self.datePicker selectRow:b-1900 inComponent:0 animated:YES];
    }
    
    //self.timeSelectedString = [NSString stringWithFormat:@"%@%@",self.str11,self.str10];
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 200;
    }else {
        return 12;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return  self.myArray[row];
    }else {
        return  self.myArray1[row];
    }
}


-(NSMutableArray *)myArray1{
    if (!_myArray1) {
        self.myArray1 = [[NSMutableArray alloc]init];
        for (int i = 1; i<13; i++) {
            NSString *str = [NSString stringWithFormat:@"%d%@",i,@"月"];
            [self.myArray1 addObject:str];
        }
    }
    return _myArray1;
}
-(NSMutableArray *)myArray{
    if (!_myArray) {
        self.myArray = [[NSMutableArray alloc]init];
        for (int i = 1900; i<2100; i++) {
            NSString *str = [NSString stringWithFormat:@"%d%@",i,@"年"];
            [self.myArray addObject:str];
        }
    }
    return _myArray;
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
