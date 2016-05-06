//
//  PickCityViewController.m
//  CaoDu
//
//  Created by jang on 16/3/31.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "PickCityViewController.h"

@interface PickCityViewController ()
@property (nonatomic,strong)UIView *pickView;
@end

@implementation PickCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawPick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawPick{
    _pickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 216/PxHeight)];
    if (pickBool) {
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
    picker.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    selectedProvince = [province objectAtIndex: 0];
    [_pickView addSubview: picker];
    button = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(picker.frame), kScreenWidth, 50/PxHeight)];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:14/255.0 green:103/255.0 blue:26/255.0 alpha:1.0];
    [button addTarget: self action: @selector(buttobClicked:) forControlEvents: UIControlEventTouchUpInside];
    [_pickView addSubview: button];
    [self.view addSubview:_pickView];
    
    //    [UIView animateWithDuration:0.3 animations:^{
    //        _pickView.frame = CGRectMake(0, kScreenHeight - 280/PxHeight, _pickView.frame.size.width, _pickView.frame.size.height);
    //    }];
    //    NSLog(@"%f",CGRectGetMaxY(_pickView.frame));
    //    NSLog(@"%f",kScreenHeight);
    //    _fv.scrollEnabled = NO;
    //    self.tabBarController.tabBar.hidden = YES;
    //    [[UIApplication sharedApplication].keyWindow addSubview:_pickView];
    
    //    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
    //        _pickView.frame = CGRectMake(0, kScreenHeight - 290/PxHeight, _pickView.frame.size.width, _pickView.frame.size.height);
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];
}



#pragma mark- button clicked

- (void) buttobClicked:(id)sender {
    if (pickBool) {
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
        
    }else{
        
    }
    

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
    
}


#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickBool) {
        return 3;
    }else{
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickBool) {
        if (component == PROVINCE_COMPONENT) {
            return [province count];
        }
        else if (component == CITY_COMPONENT) {
            return [city count];
        }
        else {
            return [district count];
        }
    }else{
        return 2;
    }
    
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickBool) {
        if (component == PROVINCE_COMPONENT) {
            return [province objectAtIndex: row];
        }
        else if (component == CITY_COMPONENT) {
            return [city objectAtIndex: row];
        }
        else {
            return [district objectAtIndex: row];
        }
    }else{
        if (row == 0) {
            return @"房";
        }else{
            return @"车";
        }
    }
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickBool) {
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
    if (pickBool) {
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
    if (pickBool) {
        if (component == PROVINCE_COMPONENT) {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3, 30/PxHeight)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [province objectAtIndex:row];
            myView.font = [UIFont systemFontOfSize:14];
            myView.backgroundColor = [UIColor clearColor];
        }
        else if (component == CITY_COMPONENT) {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3, 30/PxHeight)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [city objectAtIndex:row];
            myView.font = [UIFont systemFontOfSize:14];
            myView.backgroundColor = [UIColor clearColor];
        }
        else {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3, 30/PxHeight)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [district objectAtIndex:row];
            myView.font = [UIFont systemFontOfSize:14];
            myView.backgroundColor = [UIColor clearColor];
        }
        
        return myView;
    }else{
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, 30/PxHeight)];
        myView.textAlignment = NSTextAlignmentCenter;
        if (row == 0) {
            myView.text = @"房";
        }else{
            myView.text = @"车";
        }
        
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
        
        return myView;
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
