//
//  InfoCellView.h
//  CaoDu
//
//  Created by jang on 16/3/17.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCellView : UIView<UITextFieldDelegate>
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,retain,readonly) UITextField *inputField;


//初始化方法，指定label上显示的文字
- (instancetype)initWithFrame:(CGRect)frame titleText:(NSString *)titleText placeholder:(NSString *)placeholderText;

//获取输入框的内容
- (NSString *)inputFieldText;

//设置输入框内容
-(void)outputFileText:(NSString *)text;

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate;

//textfield回收键盘
- (void)recyleKeyboard;


@end
