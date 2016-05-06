//
//  LoginView.h
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView *headBackImage;
@property (nonatomic,strong)UIImageView *logoImage;
@property (nonatomic,strong)UIImageView *textImage;
@property (nonatomic,strong)TextTypeView *userNameTextFiel;
@property (nonatomic,strong)TextTypeView *passWordTextFiel;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *registeredButton;
@property (nonatomic,strong)UIButton *forgotButton;
@property (nonatomic,strong)UIButton *returnButton;
@end
