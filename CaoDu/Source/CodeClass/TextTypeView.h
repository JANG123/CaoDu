//
//  TextTypeView.h
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTypeView : UIView

@property (nonatomic,strong)UITextField *typeTextField;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)textLable imageName:(NSString *)imageName Interaction:(BOOL)interaction;

//获取输入框的内容
- (NSString *)inputFieldText;

//设置输入框内容
-(void)outputFileText:(NSString *)text;

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate;

//textfield回收键盘
- (void)recyleKeyboard;

@end
