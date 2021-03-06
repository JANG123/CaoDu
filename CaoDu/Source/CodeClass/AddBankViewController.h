//
//  AddBankViewController.h
//  CaoDu
//
//  Created by jang on 16/3/25.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedDownBlock)(UIButton *countDownButton,NSInteger tag);
typedef NSString* (^DidChangeBlock)(UIButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(UIButton *countDownButton,int second);
@interface AddBankViewController : UIViewController{
    UITextField *NameTextField;
    UITextField *numTextField;
    UITextField *typeTextField;
    UITextField *telTextField;
    UITextField *codeTextField;

    UIButton *_countDownCode;
    M13Checkbox *leftAlignment;
    UIButton *userButton;
    
    
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
    
    NSString *code;//短信验证码
}

-(void)addToucheHandler:(TouchedDownBlock)touchHandler;

-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;

@end
