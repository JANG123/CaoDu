//
//  TMyInvestmentableViewCell.m
//  CaoDu
//
//  Created by jang on 16/4/15.
//  Copyright © 2016年 jang. All rights reserved.
//

#import "TMyInvestmentableViewCell.h"

@implementation TMyInvestmentableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.backgroundColor = Color_back;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150/PxHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(13/PxWidth, 14/PxHeight, 25/PxWidth, 16/PxHeight)];
    [logoImageView setImage:[UIImage imageNamed:@"logo-1.png"]];
    [backView addSubview:logoImageView];
    
    _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame) + 5/PxWidth, CGRectGetMinY(logoImageView.frame), 98/PxWidth, CGRectGetHeight(logoImageView.frame))];
    _goodsNameLabel.text = @"车";
    _goodsNameLabel.font = [UIFont adapterFontOfSize:14.0];
    _goodsNameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [backView addSubview:_goodsNameLabel];
    
    _EndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMinY(_goodsNameLabel.frame), kScreenWidth/2 - 13, CGRectGetHeight(_goodsNameLabel.frame))];
    _EndTimeLabel.textAlignment = NSTextAlignmentRight;
    NSString *textStr = [NSString stringWithFormat:@"返本日期:2016-04-11"];
    _EndTimeLabel.attributedText = [self AddAttributeText:textStr];
    _EndTimeLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_EndTimeLabel];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(13/PxWidth, 40/PxHeight - 20, kScreenWidth, 20)];
    [backView addSubview:imageView1];
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, kScreenWidth - 26/PxWidth, 1)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {2,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
    CGContextAddLineToPoint(line, kScreenWidth - 26/PxWidth, 20.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
    
    _PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(imageView1.frame), kScreenWidth/2 - 13/PxWidth, 25/PxHeight)];
    textStr = [NSString stringWithFormat:@"投资金额(元):10000"];
    _PriceLabel.attributedText = [self AddAttributeText:textStr];
    _PriceLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_PriceLabel];
    
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PriceLabel.frame), CGRectGetMinY(_PriceLabel.frame), CGRectGetWidth(_PriceLabel.frame), CGRectGetHeight(_PriceLabel.frame))];
    textStr = [NSString stringWithFormat:@"投资进度:2.62%%"];
    _progressLabel.attributedText = [self AddAttributeText:textStr];
    _progressLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_progressLabel];
    
    _FundRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_PriceLabel.frame), CGRectGetMaxY(_PriceLabel.frame), kScreenWidth/2 - CGRectGetMinX(_PriceLabel.frame), 25/PxHeight)];
    textStr = [NSString stringWithFormat:@"年化收益:10000"];
    _FundRateLabel.attributedText = [self AddAttributeText:textStr];
    _FundRateLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_FundRateLabel];
    
    _TimelimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FundRateLabel.frame), CGRectGetMinY(_FundRateLabel.frame), CGRectGetWidth(_FundRateLabel.frame), CGRectGetHeight(_FundRateLabel.frame))];
    textStr = [NSString stringWithFormat:@"投资进度:2.62%%"];
    _TimelimitLabel.attributedText = [self AddAttributeText:textStr];
    _TimelimitLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_TimelimitLabel];
    
    _RepaymentTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_FundRateLabel.frame), CGRectGetMaxY(_FundRateLabel.frame), kScreenWidth/2 - CGRectGetMinX(_FundRateLabel.frame), 25/PxHeight)];
    textStr = [NSString stringWithFormat:@"投资金额(元):10000"];
    _RepaymentTypeLabel.attributedText = [self AddAttributeText:textStr];
    _RepaymentTypeLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_RepaymentTypeLabel];
    
    _wCreateTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_RepaymentTypeLabel.frame), CGRectGetMinY(_RepaymentTypeLabel.frame), CGRectGetWidth(_RepaymentTypeLabel.frame), CGRectGetHeight(_RepaymentTypeLabel.frame))];
    textStr = [NSString stringWithFormat:@"投资进度:2.62%%"];
    _wCreateTimeLabel.attributedText = [self AddAttributeText:textStr];
    _wCreateTimeLabel.font = [UIFont adapterFontOfSize:11.0];
    [backView addSubview:_wCreateTimeLabel];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(13/PxWidth, CGRectGetMaxY(_wCreateTimeLabel.frame) - 18, kScreenWidth, 20)];
    [backView addSubview:imageView2];
    UIGraphicsBeginImageContext(imageView2.frame.size);   //开始画线
    [imageView2.image drawInRect:CGRectMake(0, 0, kScreenWidth - 26/PxWidth, 1)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGContextRef line1 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1].CGColor);
    CGContextSetLineDash(line1, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line1, 0.0, 20.0);    //开始画线
    CGContextAddLineToPoint(line1, kScreenWidth - 26/PxWidth, 20.0);
    CGContextStrokePath(line1);
    imageView2.image = UIGraphicsGetImageFromCurrentImageContext();
    
    _ExpectProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView2.frame), kScreenWidth - 13/PxWidth, CGRectGetHeight(_wCreateTimeLabel.frame))];
    textStr = [NSString stringWithFormat:@"预计收益:10000元"];
    NSArray *arr = [textStr componentsSeparatedByString:@":"];
    NSString *strF = [NSString stringWithFormat:@"%@",arr[0]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:textStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1] range:NSMakeRange(0,strF.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(strF.length + 1 ,textStr.length - strF.length - 2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] range:NSMakeRange(textStr.length - 1,1)];
    _ExpectProfitLabel.attributedText = str;
    _ExpectProfitLabel.font = [UIFont adapterFontOfSize:11.0];
    _ExpectProfitLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_ExpectProfitLabel];

    
}

-(NSMutableAttributedString *)AddAttributeText:(NSString *)text{
    NSArray *arr = [text componentsSeparatedByString:@":"];
    NSString *strF = [NSString stringWithFormat:@"%@",arr[0]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1] range:NSMakeRange(0,strF.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] range:NSMakeRange(strF.length + 1 ,text.length - strF.length - 1)];
    return str;
}

@end
