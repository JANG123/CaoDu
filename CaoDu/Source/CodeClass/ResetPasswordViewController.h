//
//  ResetPasswordViewController.h
//  CaoDu
//
//  Created by jang on 16/3/18.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchedDownBlock)(UIButton *countDownButton,NSInteger tag);
typedef NSString* (^DidChangeBlock)(UIButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(UIButton *countDownButton,int second);
@interface ResetPasswordViewController : UIViewController{
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
    
    NSString *registCode;//短信验证码
}

-(void)addToucheHandler:(TouchedDownBlock)touchHandler;

-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;
@end
