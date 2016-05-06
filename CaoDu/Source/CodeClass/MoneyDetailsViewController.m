//
//  MoneyDetailsViewController.m
//  CaoDu
//
//  Created by jang on 16/3/26.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "MoneyDetailsViewController.h"
#import "ScreeningView.h"
@interface MoneyDetailsViewController ()<UIGestureRecognizerDelegate,IQActionSheetPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)ScreeningView *sv;
@property (nonatomic,strong)UIButton *headButton1;
@property (nonatomic,strong)UIButton *headButton2;
@property (nonatomic,strong)UIButton *headButton3;
@property (nonatomic,strong)UILabel *greenLabel1;
@property (nonatomic,strong)UILabel *greenLabel2;
@property (nonatomic,strong)UILabel *greenLabel3;
@property (nonatomic,strong)UITableView *dataTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MoneyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNa];
    [self drawHeadButton];
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
    [self p_data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawNa{
    self.navigationItem.title = @"资金明细";
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

-(void)drawHeadButton{
    _headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton1.backgroundColor = [UIColor whiteColor];
    _headButton1.frame = CGRectMake(0, 0, kScreenWidth/3, 45/PxHeight);
    [_headButton1 setTitle:@"充值记录" forState:UIControlStateNormal];
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
    [_headButton2 setTitle:@"提现记录" forState:UIControlStateNormal];
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
    [_headButton3 setTitle:@"回款记录" forState:UIControlStateNormal];
    [_headButton3 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    _headButton3.titleLabel.font = [UIFont adapterFontOfSize:14.0];
    [_headButton3 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headButton3];
    
    _greenLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton2.frame) - 1, CGRectGetWidth(_headButton1.frame), 1)];
    [_headButton3 addSubview:_greenLabel3];
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
    _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton1.frame) + 10/PxHeight, kScreenWidth, kScreenHeight - CGRectGetMaxY(_headButton1.frame) - 10/PxHeight) style:UITableViewStylePlain];
    _dataTableView.backgroundColor = Color_back;
    [self.view addSubview:_dataTableView];
    [self setExtraCellLineHidden:_dataTableView];
    _dataTableView.dataSource = self;
    _dataTableView.delegate = self;
    [_dataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)p_data{
    [[UserDataTolls shareGetUserData]UserFundListJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID PassValue:^(NSMutableArray *code) {
        _dataArr = code;
        NSMutableArray *tempArr1 = [NSMutableArray array];
        NSMutableArray *tempArr2 = [NSMutableArray array];
        tempArr1 = _dataArr[0];
        tempArr2 = _dataArr[1];
        if (tempArr1.count == 0) {
            [self drawTable];
            _dataTableView.hidden = YES;
        }else{
            [self drawTable];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_dataTableView reloadData];
        });
    }];
}

-(void)invButtonAction:(UIButton *)sender{
    MainTabController *mainTC = [[MainTabController alloc]init];
    mainTC.selectedIndex = 1;
    [self.navigationController presentViewController:mainTC animated:YES completion:nil];
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
        [[UserDataTolls shareGetUserData]UserFundListJsonWithClientId:[UserAccount shareGetUserAccountDate].aUser.ClientID BeginTime:_sv.starTimeLabel.text EndTime:_sv.endTimeLabel.text PassValue:^(NSMutableArray *code) {
            _dataArr = code;
            NSMutableArray *tempArr1 = [NSMutableArray array];
            NSMutableArray *tempArr2 = [NSMutableArray array];
            tempArr1 = _dataArr[0];
            tempArr2 = _dataArr[1];
            if (isSelected==1) {
                if (tempArr1.count==0) {
                    _dataTableView.hidden = YES;
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_dataTableView reloadData];
                    });
                }
            }
            if (isSelected==2) {
                if (tempArr2.count==0) {
                    _dataTableView.hidden = YES;
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_dataTableView reloadData];
                    });
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataTableView reloadData];
            });
        }];
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

-(void)headButtonAction:(UIButton *)sender{
    [_headButton1 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton2 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headButton3 setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _greenLabel1.backgroundColor = [UIColor whiteColor];
    _greenLabel2.backgroundColor = [UIColor whiteColor];
    _greenLabel3.backgroundColor = [UIColor whiteColor];
    
    if (sender == _headButton1) {
        isSelected = 1;
        [_headButton1 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel1.backgroundColor = Color_Cyan;
        
        NSMutableArray *tempArr = [NSMutableArray array];
        tempArr = _dataArr[0];
        if (tempArr.count > 0) {
            _dataTableView.hidden = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataTableView reloadData];
            });
        }else{
            _dataTableView.hidden = YES;
        }
    }if (sender == _headButton2) {
        isSelected = 2;
        [_headButton2 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel2.backgroundColor = Color_Cyan;
        NSMutableArray *tempArr = [NSMutableArray array];
        tempArr = _dataArr[1];
        if (tempArr.count > 0) {
            _dataTableView.hidden = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataTableView reloadData];
            });
        }else{
            _dataTableView.hidden = YES;
        }
    }if (sender == _headButton3) {
        isSelected = 3;
        [_headButton3 setTitleColor:Color_Cyan forState:UIControlStateNormal];
        _greenLabel3.backgroundColor = Color_Cyan;
//        NSMutableArray *tempArr = [NSMutableArray array];
//        tempArr = _dataArr[1];
//        if (tempArr.count > 0) {
//            [self drawTable];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_dataTableView reloadData];
//            });
//        }else{
            _dataTableView.hidden = YES;
//        }
    }
    //dispatch_async(dispatch_get_main_queue(), ^{
        //[_dataTableView reloadData];
    //});
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

    NSMutableArray *tempArr = [NSMutableArray array];
    if (_dataArr.count >1) {
        if (isSelected == 1) {
            tempArr = _dataArr[0];
        }else if (isSelected == 2){
            tempArr = _dataArr[1];
        }else{
        
        }
    }
    return tempArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35/PxHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40/PxHeight;
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
    MoneyModle *aMoney = [[MoneyModle alloc]init];
    if (_dataArr.count >1) {
        if (isSelected == 1) {
            tempArr = _dataArr[0];
        }else if (isSelected == 2){
            tempArr = _dataArr[1];
        }
        UIColor *fontColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
        UIFont *lableFont = [UIFont adapterFontOfSize:12.0];
        aMoney = tempArr[indexPath.row];
        
        NSMutableArray *textArr = [NSMutableArray arrayWithObjects:aMoney.HappenMoney,[NSString stringWithFormat:@"%@",[self returnUploadETime:aMoney.CreateTime]],aMoney.IOpId,aMoney.Context, nil];
        UIView *cellView = [self returnViewWithHeight:40/PxHeight Font:lableFont Color:fontColor textArr:textArr];
        [cell addSubview:cellView];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIColor *fontColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    UIFont *lableFont = [UIFont adapterFontOfSize:13.0];
    NSMutableArray *textArr = [NSMutableArray arrayWithObjects:@"金额(元)",@"时间",@"类型",@"备注", nil];
    UIView *tempView = [self returnViewWithHeight:35/PxHeight Font:lableFont Color:fontColor textArr:textArr];
    UILabel *leanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35/PxHeight, kScreenWidth, 1)];
    leanLabel.backgroundColor = Color_back;;
    [tempView addSubview:leanLabel];
    tempView.backgroundColor = [UIColor whiteColor];
    return tempView;
}

-(UIView *)returnViewWithHeight:(CGFloat)height Font:(UIFont *)lableFont Color:(UIColor *)fontColor textArr:(NSMutableArray *)textArr{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    //headView.backgroundColor = [UIColor whiteColor];
    goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, CGRectGetHeight(headView.frame))];
    goodsNameLable.text = [NSString stringWithFormat:@"%@",textArr[0]];
    goodsNameLable.font = lableFont;
    goodsNameLable.textColor = fontColor;
    goodsNameLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:goodsNameLable];
    
    priceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNameLable.frame), 0, kScreenWidth/4, CGRectGetHeight(headView.frame))];
    priceLable.text = [NSString stringWithFormat:@"%@",textArr[1]];
    priceLable.font = lableFont;
    priceLable.textColor = fontColor;
    priceLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:priceLable];
    
    fundRateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame), 0, kScreenWidth/5, CGRectGetHeight(headView.frame))];
    fundRateLable.text = [NSString stringWithFormat:@"%@",textArr[2]];
    fundRateLable.font = lableFont;
    fundRateLable.textColor = fontColor;
    fundRateLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fundRateLable];
    
    timelimitLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fundRateLable.frame), 0, kScreenWidth*0.3, CGRectGetHeight(headView.frame))];
    timelimitLable.text = [NSString stringWithFormat:@"%@",textArr[3]];
    timelimitLable.font = lableFont;
    timelimitLable.textColor = fontColor;
    timelimitLable.textAlignment = NSTextAlignmentCenter;
    timelimitLable.numberOfLines = 0;
    [headView addSubview:timelimitLable];
    
    return headView;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
