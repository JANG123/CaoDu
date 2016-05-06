//
//  FinancingViewController.m
//  CaoDu
//
//  Created by jang on 16/3/14.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "FinancingViewController.h"
#import "FinancingView.h"
#import "FinHeadView.h"
#import "ZoomView.h"
#import "FinanTableViewCell.h"
#import "InfoView.h"
#import "InfoCellView.h"
@interface FinancingViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)FinancingView *fv;
@property (nonatomic,strong)UIView *conditionsView;
@property (nonatomic,strong)UIView *prepareView;
@property (nonatomic,strong)UIView *processView;
@property (nonatomic,strong)NSMutableDictionary *dict;
@property (nonatomic,strong)InfoView *iv;
@property (nonatomic,strong)UIButton *FinanButton;
@property (nonatomic,strong)UIView *pickView;
@end
static  NSString  *titleCellId = @"titleCell";

@implementation FinancingViewController

-(void)loadView{
    self.fv = [[FinancingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _fv;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我要融资";
    [self.view setBackgroundColor:Color_back];

    [self addButtonAction];
    [self drawTableView];
    self.dict = [NSMutableDictionary dictionary];
    [self drawButton];
    timeArr = [NSMutableArray arrayWithObjects:@"1个月",@"2个月",@"3个月",@"半年",@"1年", nil];
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

-(void)drawTableView{
    _iv = [[InfoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_fv.fhView.frame) + 13/PxHeight, kScreenWidth, 395/PxHeight)];
    [self.view addSubview:_iv];
    [_iv.cityView setTextFieldDelegate:self];
    _iv.cityView.inputField.tag = 1001;
    [_iv.nameView setTextFieldDelegate:self];
    [_iv.phoneView setTextFieldDelegate:self];
    [_iv.moneyView setTextFieldDelegate:self];
    [_iv.timeView setTextFieldDelegate:self];
    _iv.timeView.inputField.tag = 1003;
    [_iv.typeView setTextFieldDelegate:self];
    _iv.typeView.inputField.tag = 1002;
    [_iv.checkboxMan addTarget:self action:@selector(checkboxAction:) forControlEvents:UIControlEventTouchUpInside];
    [_iv.checkboxWoman addTarget:self action:@selector(checkboxAction:) forControlEvents:UIControlEventTouchUpInside];
    [_iv.moneyView.inputField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    isSelect = YES;
}

-(void)checkboxAction:(UIButton *)sender{
    sender.backgroundColor = [UIColor colorWithRed:61/255.0 green:157/255.0 blue:57/255.0 alpha:1.0];
    if (sender == _iv.checkboxMan) {
        isSelect = YES;
        _iv.checkboxWoman.backgroundColor = Color_back;
    }else{
        isSelect = NO;
        _iv.checkboxMan.backgroundColor = Color_back;
    }
}

-(void)drawButton{
    _FinanButton = [[UIButton alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_iv.frame) + 10/PxHeight, kScreenWidth - 26/PxWidth, 45/PxHeight)];
    _FinanButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [_FinanButton setTitle:@"提交申请" forState:UIControlStateNormal];
    [self.view addSubview:_FinanButton];
    [_FinanButton.layer setMasksToBounds:YES];
    [_FinanButton.layer setCornerRadius:5.0];
    [_FinanButton addTarget:self action:@selector(finanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.fv.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_FinanButton.frame) +20);
}

-(void)viewWillAppear:(BOOL)animated{
    KFontColor_NavWhite
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_backpress.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)addButtonAction{
    [_fv.fhView.headButton1 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _fv.fhView.headButton1.tag = 101;
    [_fv.fhView.headButton2 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _fv.fhView.headButton2.tag = 102;
    [_fv.fhView.headButton3 addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _fv.fhView.headButton3.tag = 103;
}

-(void)finanButtonAction:(UIButton *)sender{
    if ([UserAccount UserName].length > 1) {
        BondModle *aBond = [[BondModle alloc]init];
        aBond.ClientId = [UserAccount shareGetUserAccountDate].aUser.ClientID;
        aBond.UserName = [_iv.nameView inputFieldText];
        if (isSelect) {
            aBond.UserSex = @"男";
        }else{
            aBond.UserSex = @"女";
        }
        aBond.UserPhone = [_iv.phoneView inputFieldText];;
        aBond.Price = [_iv.moneyView inputFieldText];
        aBond.GoodsName = [_iv.typeView inputFieldText];
        aBond.GoodsID = [NSString stringWithFormat:@"%ld",GoodsID+1];
        aBond.Address = [_iv.cityView inputFieldText];
        aBond.Timelimit = [_iv.timeView inputFieldText];
        
        if ([_iv.cityView inputFieldText].length < 1) {
            [self p_showAlertView:@"请选择所在城市" message:nil];
        }else if([_iv.typeView inputFieldText].length < 1){
            [self p_showAlertView:@"请选择抵押方式" message:nil];
        }else if([_iv.timeView inputFieldText].length < 1){
            [self p_showAlertView:@"请选择借款期限" message:nil];
        }else if([_iv.nameView inputFieldText].length < 1){
            [self p_showAlertView:@"请输入真实姓名" message:nil];
        }else if([_iv.phoneView inputFieldText].length < 1){
            [self p_showAlertView:@"请输入手机号码" message:nil];
        }else if([_iv.moneyView inputFieldText].length < 1){
            [self p_showAlertView:@"请输入申请金额" message:nil];
        }else{
            
            [[TelValiDateTolls shareGetTelValiDate]validateNumWithPhoneNum:[_iv.phoneView inputFieldText] PassValue:^(NSString *string) {
                if ([string isEqualToString:@"格式正确"]) {
                    [[InvestmentDataTolls shareGetInvestmentData]PubLishBondWithID:aBond PassValue:^(NSMutableArray *code) {
                        if ([code[0] isEqualToString: @"0"]) {
                            [self p_showAlertView:@"申请成功！" message:nil];
                        }else{
                            [self p_showAlertView:@"你已申请成功，请等待客服联系" message:nil];
                        }
                        [_iv.cityView outputFileText:@""];
                        [_iv.typeView outputFileText:@""];
                        [_iv.timeView outputFileText:@""];
                        [_iv.nameView outputFileText:@""];
                        [_iv.phoneView outputFileText:@""];
                        [_iv.moneyView outputFileText:@""];
                    }];
                }else{
                    [self p_showAlertView:@"请输入正确手机号" message:nil];
                }
            }];
        }

    }
    else{
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
    _fv.fhView.greenLabel1.backgroundColor = [UIColor whiteColor];
    _fv.fhView.greenLabel2.backgroundColor = [UIColor whiteColor];
    _fv.fhView.greenLabel3.backgroundColor = [UIColor whiteColor];
    [_conditionsView removeFromSuperview];
    [_prepareView removeFromSuperview];
    [_processView removeFromSuperview];
    [_FinanButton removeFromSuperview];
    if (sender == _fv.fhView.headButton1) {
        if ([[self.dict valueForKey:[NSString stringWithFormat:@"%ld",sender.tag-100]] isEqualToString:@"0"]) {
            [self.dict setValue:@"1" forKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
            [_conditionsView removeFromSuperview];
            _iv.frame = CGRectMake(0, 13/PxHeight +CGRectGetMaxY(_fv.fhView.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
        }
        else
        {
            [self.dict setValue:@"0" forKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
            _fv.fhView.greenLabel1.backgroundColor = [UIColor colorWithRed:17/255.0 green:126/255.0 blue:2/255.0 alpha:1];
            [self drawConditionsView];
            _iv.frame = CGRectMake(0, 13/PxHeight +CGRectGetMaxY(_conditionsView.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
        }
        
    }if (sender == _fv.fhView.headButton2) {
        if ([[self.dict valueForKey:[NSString stringWithFormat:@"%ld",sender.tag-100]] isEqualToString:@"0"]) {
            [self.dict setValue:@"1" forKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
            [_prepareView removeFromSuperview];
            _iv.frame = CGRectMake(0, 13/PxHeight +CGRectGetMaxY(_fv.fhView.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
        }
        else
        {
            [self.dict setValue:@"0" forKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
            _fv.fhView.greenLabel2.backgroundColor = [UIColor colorWithRed:17/255.0 green:126/255.0 blue:2/255.0 alpha:1];
            [self drawPrepareView];
            _iv.frame = CGRectMake(0, 13/PxHeight +CGRectGetMaxY(_prepareView.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
        }
        
    }if (sender == _fv.fhView.headButton3) {
        if ([[self.dict valueForKey:[NSString stringWithFormat:@"%ld",sender.tag-100]] isEqualToString:@"0"]) {
            [self.dict setValue:@"1" forKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
            [_processView removeFromSuperview];
            _iv.frame = CGRectMake(0, 13/PxHeight +CGRectGetMaxY(_fv.fhView.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
        }
        else
        {
            [self.dict setValue:@"0" forKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
            _fv.fhView.greenLabel3.backgroundColor = [UIColor colorWithRed:17/255.0 green:126/255.0 blue:2/255.0 alpha:1];
            [self drawProcessView];
            _iv.frame = CGRectMake(0, 13/PxHeight +CGRectGetMaxY(_processView.frame), kScreenWidth, CGRectGetHeight(_iv.frame));
        }
    }
    [self drawButton];
    [self.view bringSubviewToFront:_pickView];
}

-(void)drawConditionsView{
    _conditionsView = [[UIView alloc]initWithFrame:CGRectMake(14/PxWidth, CGRectGetMaxY(_fv.fhView.frame) + 13/PxHeight, kScreenWidth - 28/PxWidth, 105/PxHeight)];
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_conditionsView.frame), CGRectGetHeight(_conditionsView.frame))];
    backImage.image = [UIImage imageNamed:@"申请条件.png"];
    [_conditionsView addSubview:backImage];
    ZoomView *zoom1 = [[ZoomView alloc]initWithFrame:CGRectMake(0, 20/PxHeight, CGRectGetWidth(_conditionsView.frame), 15/PxHeight) placeholder:@"具有中国国籍（港澳台除外）"];
    [_conditionsView addSubview:zoom1];
    
    ZoomView *zoom2 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom1.frame) + 15/PxHeight, CGRectGetWidth(_conditionsView.frame), 15/PxHeight) placeholder:@"具有良好个人信用"];
    [_conditionsView addSubview:zoom2];
    
    ZoomView *zoom3 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom2.frame) + 15/PxHeight, CGRectGetWidth(_conditionsView.frame), 15/PxHeight) placeholder:@"具有可供抵、质押的个人资产（如车辆、房产等）"];
    [_conditionsView addSubview:zoom3];
    [_conditionsView sendSubviewToBack:backImage];
    [self.view addSubview:_conditionsView];
}

-(void)drawPrepareView{
    _prepareView = [[UIView alloc]initWithFrame:CGRectMake(14/PxWidth, CGRectGetMaxY(_fv.fhView.frame) + 13/PxHeight, kScreenWidth - 28/PxWidth, 135/PxHeight)];
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_prepareView.frame), CGRectGetHeight(_prepareView.frame))];
    backImage.image = [UIImage imageNamed:@"资料准备.png"];
    [_prepareView addSubview:backImage];
    
    ZoomView *zoom1 = [[ZoomView alloc]initWithFrame:CGRectMake(0, 20/PxHeight, CGRectGetWidth(_prepareView.frame), 15/PxHeight) placeholder:@"身份证"];
    [_prepareView addSubview:zoom1];
    
    ZoomView *zoom2 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom1.frame) + 15/PxHeight, CGRectGetWidth(_prepareView.frame), 15/PxHeight) placeholder:@"抵、质押无权证明（如机动车登记证、房产证等）"];
    [_prepareView addSubview:zoom2];
    
    ZoomView *zoom3 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom2.frame) + 15/PxHeight, CGRectGetWidth(_prepareView.frame), 15/PxHeight) placeholder:@"个人征信报告"];
    [_prepareView addSubview:zoom3];
    
    ZoomView *zoom4 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom3.frame) + 15/PxHeight, CGRectGetWidth(_prepareView.frame), 15/PxHeight) placeholder:@"平台风控部门要求提供的其他材料"];
    [_prepareView addSubview:zoom4];
    [_prepareView sendSubviewToBack:backImage];
    [self.view addSubview:_prepareView];
}

-(void)drawProcessView{
    _processView = [[UIView alloc]initWithFrame:CGRectMake(14/PxWidth, CGRectGetMaxY(_fv.fhView.frame) + 13/PxHeight, kScreenWidth - 28/PxWidth, 165/PxHeight)];
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_processView.frame), CGRectGetHeight(_processView.frame))];
    backImage.image = [UIImage imageNamed:@"办理流程.png"];
    [_processView addSubview:backImage];
    ZoomView *zoom1 = [[ZoomView alloc]initWithFrame:CGRectMake(0, 20/PxHeight, CGRectGetWidth(_processView.frame), 15/PxHeight) placeholder:@"申请"];
    [_processView addSubview:zoom1];
    
    ZoomView *zoom2 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom1.frame) + 15/PxHeight, CGRectGetWidth(_processView.frame), 15/PxHeight) placeholder:@"审核评估"];
    [_processView addSubview:zoom2];
    
    ZoomView *zoom3 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom2.frame) + 15/PxHeight, CGRectGetWidth(_processView.frame), 15/PxHeight) placeholder:@"签署合同"];
    [_processView addSubview:zoom3];
    
    ZoomView *zoom4 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom3.frame) + 15/PxHeight, CGRectGetWidth(_processView.frame), 15/PxHeight) placeholder:@"办理抵、质押手续"];
    [_processView addSubview:zoom4];
    
    ZoomView *zoom5 = [[ZoomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zoom4.frame) + 15/PxHeight, CGRectGetWidth(_processView.frame), 15/PxHeight) placeholder:@"付款"];
    [_processView addSubview:zoom5];
    [_processView sendSubviewToBack:backImage];
    [self.view addSubview:_processView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)drawPick{
    _pickView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 216/PxHeight, kScreenWidth, 216/PxHeight)];
    if ([pickType isEqualToString:@"city"]) {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    }
    picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, 166/PxHeight)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
    picker.backgroundColor = Color_back;
    selectedProvince = [province objectAtIndex: 0];
    [_pickView addSubview: picker];
    button = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(picker.frame), kScreenWidth, 50/PxHeight)];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [button addTarget: self action: @selector(buttobClicked:) forControlEvents: UIControlEventTouchUpInside];
    [_pickView addSubview: button];
    [self.view addSubview:_pickView];
    
    [UIView animateWithDuration:0.3 animations:^{
        [[UIApplication sharedApplication].keyWindow addSubview:_pickView];
    }];
    _fv.scrollEnabled = NO;
    self.tabBarController.tabBar.hidden = YES;

}



#pragma mark- button clicked

- (void) buttobClicked:(id)sender {
    if ([pickType isEqualToString:@"city"]) {
        NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
        NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
        NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
        
        NSString *provinceStr = [province objectAtIndex: provinceIndex];
        NSString *cityStr = [city objectAtIndex: cityIndex];
        NSString *districtStr = [district objectAtIndex:districtIndex];
        
        if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
            cityStr = @"";
            districtStr = @"";
        }
        else if ([cityStr isEqualToString: districtStr]) {
            districtStr = @"";
        }
        
        NSString *showMsg = [NSString stringWithFormat: @"%@%@%@", provinceStr, cityStr, districtStr];
        
        [_iv.cityView outputFileText:showMsg];

    }else if ([pickType isEqualToString:@"type"]){
        if ([picker selectedRowInComponent: 0] == 0) {
            [_iv.typeView outputFileText:@"房"];
            GoodsID = 0;
        }else{
            [_iv.typeView outputFileText:@"车"];
            GoodsID = 1;
        }
        
    }else{
        [_iv.timeView outputFileText:timeArr[[picker selectedRowInComponent: 0]]];
    }
    
    [_pickView removeFromSuperview];
    _fv.scrollEnabled = YES;
    self.tabBarController.tabBar.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
    
}


#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickType isEqualToString:@"city"]) {
     return 3;
   }else if ([pickType isEqualToString:@"type"]){
     return 1;
   }else{
       return 1;
   }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickType isEqualToString:@"city"]) {
        if (component == PROVINCE_COMPONENT) {
            return [province count];
        }
        else if (component == CITY_COMPONENT) {
            return [city count];
        }
        else {
            return [district count];
        }
    }else if ([pickType isEqualToString:@"type"]){
        return 2;
    }else{
        return 5;
    }

}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickType isEqualToString:@"city"]) {
        if (component == PROVINCE_COMPONENT) {
            return [province objectAtIndex: row];
        }
        else if (component == CITY_COMPONENT) {
            return [city objectAtIndex: row];
        }
        else {
            return [district objectAtIndex: row];
        }
    }else if ([pickType isEqualToString:@"type"]){
        if (row == 0) {
            return @"房";
        }else{
        return @"车";
        }
    }else{
        return timeArr[row];
    }

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickType isEqualToString:@"city"]) {
        if (component == PROVINCE_COMPONENT) {
            selectedProvince = [province objectAtIndex: row];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", row]]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *cityArray = [dic allKeys];
            NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;//递减
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;//上升
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i=0; i<[sortedArray count]; i++) {
                NSString *index = [sortedArray objectAtIndex:i];
                NSArray *temp = [[dic objectForKey: index] allKeys];
                [array addObject: [temp objectAtIndex:0]];
            }
            
            
            city = [[NSArray alloc] initWithArray: array];
            
            NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
            district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
            [picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
            [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
            [picker reloadComponent: CITY_COMPONENT];
            [picker reloadComponent: DISTRICT_COMPONENT];
            
        }
        else if (component == CITY_COMPONENT) {
            NSString *provinceIndex = [NSString stringWithFormat: @"%lu", [province indexOfObject: selectedProvince]];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *dicKeyArray = [dic allKeys];
            NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
            NSArray *cityKeyArray = [cityDic allKeys];
            
            district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
            [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
            [picker reloadComponent: DISTRICT_COMPONENT];
        }

    }else{
        
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if ([pickType isEqualToString:@"city"]) {
        return kScreenWidth/3;
    }else{
        return kScreenWidth;
    }
}

//  第component列的行高是多少

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 30/PxHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    if ([pickType isEqualToString:@"city"]) {
        if (component == PROVINCE_COMPONENT) {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3, 30/PxHeight)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [province objectAtIndex:row];
            myView.font = [UIFont adapterFontOfSize:14];
            myView.backgroundColor = [UIColor clearColor];
        }
        else if (component == CITY_COMPONENT) {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3, 30/PxHeight)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [city objectAtIndex:row];
            myView.font = [UIFont adapterFontOfSize:14];
            myView.backgroundColor = [UIColor clearColor];
        }
        else {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3, 30/PxHeight)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [district objectAtIndex:row];
            myView.font = [UIFont adapterFontOfSize:14];
            myView.backgroundColor = [UIColor clearColor];
        }
        
        return myView;
    }else if ([pickType isEqualToString:@"type"]){
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, 30/PxHeight)];
        myView.textAlignment = NSTextAlignmentCenter;
        if (row == 0) {
            myView.text = @"房";
        }else{
            myView.text = @"车";
        }
        
        myView.font = [UIFont adapterFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
        
        return myView;
    }else{
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, 30/PxHeight)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = timeArr[row];
        myView.font = [UIFont adapterFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
        
        return myView;
    }

}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (beforeTextField != nil) {
        if (textField.tag == 1001 || textField.tag == 1002 || textField.tag == 1003) {
            [self textFieldShouldReturn:beforeTextField];
        }
    }
    beforeTextField = textField;
    //如果当前要显示的键盘，那么把UIDatePicker（如果在视图中）隐藏
    if (textField.tag != 1001 && textField.tag != 1002 && textField.tag != 1003) {
        [_pickView removeFromSuperview];
        return YES;
    }
    
    //UIDatePicker以及在当前视图上就不用再显示了
    if (_pickView.superview == nil) {
        [textField resignFirstResponder];
        if (textField.tag == 1001) {
            pickType = @"city";
            //[_iv.cityView outputFileText:@""];
        }else if(textField.tag == 1002){
            pickType = @"type";
            //[_iv.typeView outputFileText:@""];
        }else{
            pickType = @"time";
            //[_iv.timeView outputFileText:@""];
        }

        [self drawPick];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView commitAnimations];
    }
    
    return NO;
}

- (void)textFieldDidChange:(id) sender {
    if (sender == _iv.moneyView.inputField) {
        UITextField *field = (UITextField *)sender;
        NSArray *tempText = [field.text componentsSeparatedByString:@"."];
        if (tempText.count > 1) {
            NSString *numStr = tempText[1];
            if (numStr.length > 2) {
                numStr = [numStr substringToIndex:2];
                _iv.moneyView.inputField.text = [NSString stringWithFormat:@"%@.%@",tempText[0],numStr];
            }
        }
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
