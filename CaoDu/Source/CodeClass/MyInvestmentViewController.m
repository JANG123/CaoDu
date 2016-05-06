//
//  MyInvestmentViewController.m
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MyInvestmentViewController.h"
#import "TMyInvestmentableViewCell.h"
@interface MyInvestmentViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIButton *headButton1;
@property (nonatomic,strong)UIButton *headButton2;
@property (nonatomic,strong)UILabel *greenLabel1;
@property (nonatomic,strong)UILabel *greenLabel2;
@property (nonatomic,strong)UITableView *dataTableView;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UIButton *dateButton;
@property (nonatomic,strong)NSString *locationString;

@property (strong,nonatomic) UIPickerView *datePicker;
@property (strong,nonatomic) UIView*timeSelectView;
@property (strong,nonatomic) NSMutableArray *myArray1;
@property (strong,nonatomic) NSMutableArray *myArray;
@property (strong,nonatomic) NSString  *timeSelectedString;
@property (strong,nonatomic) NSString  *str10;
@property (strong,nonatomic) NSString  *str11;
@end

@implementation MyInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray array];
    [self drawNa];
    [self drawHeadButton];
    [self drawView];
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr =[dateformatter stringFromDate:senddate];
    [self p_dataWithDate:dateStr];
    [self p_datePick];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [[UserDataTolls shareGetUserData]MyInvestmentJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID  BeginTime:@"" EndTime:@"" PassValue:^(NSMutableArray *code) {
        _dataArr = code;
        NSMutableArray *tempArr1 = [NSMutableArray array];
        NSMutableArray *tempArr2 = [NSMutableArray array];
        tempArr1 = _dataArr[0];
        tempArr2 = _dataArr[1];
        if (tempArr1.count == 0 && tempArr2.count == 0) {
            _dateButton.hidden = YES;
            _dateLabel.hidden = YES;
            logoImageView.hidden = NO;
            textLabel.hidden = NO;
            invButton.hidden = NO;
        }else{
            [[UserDataTolls shareGetUserData]MyInvestmentJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID  BeginTime:beginTime EndTime:dateStr PassValue:^(NSMutableArray *code) {
                _dataArr = code;
                NSMutableArray *tempArr1 = [NSMutableArray array];
                NSMutableArray *tempArr2 = [NSMutableArray array];
                tempArr1 = _dataArr[0];
                tempArr2 = _dataArr[1];
                if (tempArr1.count == 0 && tempArr2.count == 0) {
                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) + 50/PxHeight, kScreenWidth, kScreenHeight - CGRectGetMaxY(_dateLabel.frame) - 54)];
                    view.backgroundColor = Color_back;
                    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150/PxHeight, kScreenWidth, 20)];
                    promptLabel.font = [UIFont adapterFontOfSize:13.0];
                    promptLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
                    promptLabel.text = @"您本月暂无投资记录，快去投资吧！";
                    promptLabel.textAlignment = NSTextAlignmentCenter;
                    [view addSubview:promptLabel];
                    [self.view addSubview:view];
                    UIButton *promptButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    promptButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(promptLabel.frame) + 10/PxHeight, 230/PxWidth, 45/PxHeight);
                    [promptButton setTitle:@"立即投资" forState:UIControlStateNormal];
                    promptButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
                    [view addSubview:promptButton];
                    [promptButton addTarget:self action:@selector(invButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                }else{
                    [self drawTable];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_dataTableView reloadData];
                });
            }];
            
        }
    }];
    
    
}

-(void)drawNa{
    self.navigationItem.title = @"投资项目";
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

-(void)drawHeadButton{
    _headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton1.backgroundColor = [UIColor whiteColor];
    _headButton1.frame = CGRectMake(0, 0, kScreenWidth/2, 45/PxHeight);
    [_headButton1 setTitle:@"投标中" forState:UIControlStateNormal];
    _headButton1.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton1 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    isSelected = YES;
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
    [_headButton2 setTitle:@"已完成" forState:UIControlStateNormal];
    [_headButton2 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    _headButton2.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton2 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton2];
    
    _greenLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton2 addSubview:_greenLabel2];
    
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月/YYYY年"];
    _locationString =[dateformatter stringFromDate:senddate];
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_headButton1.frame), kScreenWidth/2, 50/PxHeight)];
    _dateLabel.attributedText = [self dateLabelAttributedString:_locationString];
    [self.view addSubview:_dateLabel];
    
    _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dateButton.frame = CGRectMake(kScreenWidth - 36/PxWidth, CGRectGetMaxY(_headButton2.frame) + 15/PxHeight, 23/PxWidth, 23/PxHeight);
    [_dateButton addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dateButton setBackgroundImage:[UIImage imageNamed:@"时间列表.png"] forState:UIControlStateNormal];
    [self.view addSubview:_dateButton];
}

-(NSMutableAttributedString *)dateLabelAttributedString:(NSString *)dataStr{
    NSArray *arr = [dataStr componentsSeparatedByString:@"月"];
    NSString *strF = [NSString stringWithFormat:@"%@",arr[0]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dataStr];
    
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:16.0],NSFontAttributeName,nil];
    [str addAttributes:attributeDict range:NSMakeRange(0,strF.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] range:NSMakeRange(0,strF.length)];
    attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                     [UIFont systemFontOfSize:11.0],NSFontAttributeName,nil];
    [str addAttributes:attributeDict range:NSMakeRange(strF.length ,dataStr.length - strF.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(strF.length ,dataStr.length - strF.length)];
    return str;
}

-(void)drawView{
    logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 145/PxWidth)/2, 112/PxHeight, 145/PxWidth, 125/PxHeight)];
    logoImageView.image = [UIImage imageNamed:@"小羊.png"];
    [self.view addSubview:logoImageView];
    textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 24/PxHeight, kScreenWidth, 20/PxHeight)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont adapterFontOfSize:13.0];
    textLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    textLabel.text = @"hi,您还没有投标项目，快去投资吧！";
    [self.view addSubview:textLabel];
    invButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invButton.frame = CGRectMake((kScreenWidth - 230/PxWidth)/2, CGRectGetMaxY(textLabel.frame) + 33/PxHeight, 230/PxWidth, 45/PxHeight);
    [invButton setTitle:@"立即投资" forState:UIControlStateNormal];
    invButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [self.view addSubview:invButton];
    [invButton addTarget:self action:@selector(invButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    logoImageView.hidden = YES;
    textLabel.hidden = YES;
    invButton.hidden = YES;
}

-(void)drawTable{
    _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) + 50/PxHeight, kScreenWidth, kScreenHeight - CGRectGetMaxY(_dateLabel.frame) - 54) style:UITableViewStylePlain];
    _dataTableView.backgroundColor = Color_back;
    [self.view addSubview:_dataTableView];
    [self setExtraCellLineHidden:_dataTableView];
    _dataTableView.dataSource = self;
    _dataTableView.delegate = self;
    [self.dataTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_dataTableView registerClass:[TMyInvestmentableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)headButtonAction:(UIButton *)sender{
    [_headButton1 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton2 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _greenLabel1.backgroundColor = [UIColor whiteColor];
    _greenLabel2.backgroundColor = [UIColor whiteColor];

    if (sender == _headButton1) {
        isSelected = YES;
        [_headButton1 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel1.backgroundColor = Color_Cyan;
        
    }if (sender == _headButton2) {
        isSelected = NO;
        [_headButton2 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel2.backgroundColor = Color_Cyan;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_dataTableView reloadData];
    });
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

    NSMutableArray *tempArr = [NSMutableArray array];
    if (_dataArr.count >1) {
        if (isSelected) {
            tempArr = _dataArr[0];
        }else{
            tempArr = _dataArr[1];
        }
    }
    return tempArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160/PxHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMyInvestmentableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[TMyInvestmentableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *tempArr = [NSMutableArray array];
    MyInvestmentModle *aInvestment = [[MyInvestmentModle alloc]init];
    if (_dataArr.count >1) {
        if (isSelected) {
            tempArr = _dataArr[0];
        }else{
            tempArr = _dataArr[1];
        }
        aInvestment = tempArr[indexPath.row];
        cell.goodsNameLabel.text = aInvestment.GoodsName;
        cell.EndTimeLabel.attributedText = [cell AddAttributeText:aInvestment.EndTime];
        cell.PriceLabel.attributedText = [cell AddAttributeText:aInvestment.MyPrice];
        cell.FundRateLabel.attributedText = [cell AddAttributeText:aInvestment.FundRate];
        cell.RepaymentTypeLabel.attributedText = [cell AddAttributeText:aInvestment.RepaymentType];
        cell.TimelimitLabel.attributedText = [cell AddAttributeText:aInvestment.Timelimit];
        cell.wCreateTimeLabel.attributedText = [cell AddAttributeText:aInvestment.wCreateTime];
        double progress = [aInvestment.SumPrice doubleValue]/[aInvestment.Price doubleValue] * 100;
        cell.progressLabel.attributedText = [cell AddAttributeText:[NSString stringWithFormat:@"投资进度:%.2f",progress]];
        NSString *textStr = aInvestment.ExpectProfit;
        NSArray *arr = [textStr componentsSeparatedByString:@":"];
        NSString *strF = [NSString stringWithFormat:@"%@",arr[0]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:textStr];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1] range:NSMakeRange(0,strF.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(strF.length + 1 ,textStr.length - strF.length - 2)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] range:NSMakeRange(textStr.length - 1,1)];
        cell.ExpectProfitLabel.attributedText = str;
        
    }
    return cell;
}


-(void)datePickerAction:(UIButton *)sender{
    [self.view addSubview:self.timeSelectView];
    [UIView animateWithDuration:0.3 animations:^{
        self.timeSelectView.frame = CGRectMake(0, kScreenHeight-274, kScreenWidth, 210);
    }];
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
    
    
    NSDateFormatter *labelFormatter = [[NSDateFormatter alloc] init];
    [labelFormatter setLocale:[NSLocale currentLocale]];
    [labelFormatter setDateFormat:@"MM月/yyyy年"];
    NSString *labelstr = [labelFormatter stringFromDate:inputDate];
    
    _dateLabel.attributedText = [self dateLabelAttributedString:labelstr];
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
