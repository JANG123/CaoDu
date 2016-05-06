//
//  URLHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里是URL信息

#ifndef Project_URLHeader_h
#define Project_URLHeader_h

//接口
#define URL_api @"http://foragegrass.wowzb.net/"

//首页广告显示接口
#define URL_AdvertiseList @"MobileAPI/Home/AdvertiseList"
//返回值：items，ReturnValue，error

//首页统计数据接口
#define URL_HomeStatistics @"MobileAPI/Home/HomeStatistics"
//返回值：items，error
//
//
//首页预热项目投资接口
#define URL_GetPreheartBPTI @"MobileAPI/Home/GetPreheartBPTI"
//可选参数：int  PageIndex=1，int  PageSize=5
//返回值：items，ReturnValue，error
//
//
//首页火热项目投资接口
#define URL_GetHotBPTI @"MobileAPI/Home/GetHotBPTI"
//可选参数：int  PageIndex=1，int  PageSize=5
//返回值：items，ReturnValue，error
//
//

#define URL_RaisePTI @"RaisePTI/GetAllRaise"

//首页查询商品接口
#define URL_GetAllRaise @"MobileAPI/Home/GetAllRaise"
//可选参数：string  UserID=””,string  GoodsType=””, int  Timelimit = -0, string  State = "", int PageIndex = 1, int  PageSize = 5, bool  IsRecommended = false
//返回值：items，ReturnValue，RowCount，error
//
//
//公告查询接口
#define URL_SelectNews @"MobileAPI/Home/SelectNews"
//必填参数：int？Id
//可选参数：int  PageIndex=1，int  PageSize=5
//返回值：items，error
//
//
//我要融资接口
#define URL_PubLishBond @"MobileAPI/BPTI/PubLishBond"
//必填参数：string  ClientId, string  UserName, string  UserSex, string  UserPhone, decimal? Price, string  GoodsName, int?  GoodsID, string  Address, int?  Timelimit
//返回值：ReturnValue，error
//
//
//抵押方式查询接口
#define URL_SelectAdminByCondition @"MobileAPI/BPTI/SelectAdminByCondition"
//必填参数：string  AreaName
//返回值：items，ReturnValue，error
//
//
//商品详情跳转接口
#define URL_BPTIDetail @"MobileAPI/BPTI/BPTIDetail"
//必填参数：int?  BID
//可选参数：int  ClientId=”0”
//返回值：items，error
//
//
//项目投资记录接口
#define URL_BRaiseList @"MobileAPI/BPTI/BRaiseList"
//必填参数：int?  BID
//返回值：items，error
//
//
//投资下单接口
#define URL_Investment @"MobileAPI/BPTI/Investment"
//必填参数：int? RID, decimal? Payment, decimal? AllProfit, string Pwd, string ClientId
//返回值：ReturnValue，error
//
//
//下单确认页面接口
#define URL_AffirmInvest @"MobileAPI/BPTI/AffirmInvest"
//必填参数：int? RID, decimal? Money, string GoodsName, decimal? BorrowingRate, decimal? Timelimit, int? BID, decimal? SumPrice, decimal? Price
//返回值：items，error
//
//
//获取还款计划接口
#define URL_GetRepaymentPlan @"MobileAPI/BPTI/GetRepaymentPlan"
//必填参数：string RepaymentDate, decimal? FundRate, int? Timelimit, decimal? Price
//返回值：items，error
//
//
//根据商品编号查询商品图片接口
#define URL_SelectByResources @"MobileAPI/BPTI/SelectByResources"
//必填参数：int? ResourcesID
//返回值：items，error
//
//
//用户登录接口
#define URL_Login @"MobileAPI/ClientInfo/Login"
//必填参数：string ClientID, string PassWord, string IP, string w_Address
//返回值：ReturnValue，items，error
//
//
//用户注册接口
#define URL_InsertClientInfo @"MobileAPI/CLientInfo/InsertClientInfo"
//必填参数：string InviteCode, string PassWord, string Tel
//返回值：ReturnValue，error
//
//
//用户登录历史查询接口
#define URL_SelectLoginHistory @"MobileAPI/ClientInfo/SelectLoginHistory"
//必填参数：string ClientId, string Tel
//可选参数：int PageIndex=1，int PageSize=5
//返回值：items，ReturnValue，ReturnCount，error
//
//
//账号认证接口
#define URL_UpdateAuthentication @"MobileAPI/ClientInfo/UpdateAuthentication"
//必填参数：int? ClientId, string Email, string Tel, string w_Tel, string w_Email
//返回值：Authentication，ReturnValue，error
//
//
//密码找回接口
#define URL_UserPassFind @"MobileAPI/ClientInfo/UserPassFind"
//必填参数：string UserId, string Password, string NewPassword
//返回值：ReturnValue，error
//
//
//修改密码接口
#define URL_UserPass @"MobileAPI/ClientInfo/UserPass"
//必填参数：string ClientId, string Password, string NewPassword
//返回值：ReturnValue，error
//
//
//重置密码接口
#define URL_ResetPassword @"MobileAPI/ClientInfo/ResetPassword"
//必填参数：string Tel, string Email, string NewPassword
//返回值：ReturnValue，error
//
//
//查询收益/回款接口
#define URL_EarningsJson @"MobileAPI/ClientInfo/EarningsJson"
//必填参数：string ClientId
//可选参数：int PageIndex, int PageSize, string BeginTime, string EndTime, string GoodsName, string State
//返回值：items,RowCOunt，TotalPage，Next，PreviousPage，error
//
//
//我的投资接口
#define URL_MyInvestmentJson @"MobileAPI/ClientInfo/MyInvestmentJson"
//必填参数：string ClientId
//可选参数：int PageIndex, int PageSize, string BeginTime, string EndTime, string GoodsName, string State
//返回值：items，RowCount，TotalPage，Next，PreviousPage，error
//
//
//手机号验证接口
#define URL_TelValidate @"MobileAPI/ClientInfo/TelValidate"
//必填参数：string TelName
//返回值：Success，TelNum，error
//
//
//判断手机号和邮箱的格式接口
#define URL_ValidateNum @"MobileAPI/ClientInfo/ValidateNum"
//必填参数：string Account
//返回值，msg，error
//
//
//修改用户手机号接口
#define URL_UpdateTel @"MobileAPI/CLientInfo/UpdateTel"
//必填参数：string ClientId，string UserTel
//返回参数：error，ReturnValue
//
//
//邮箱验证接口
#define URL_EmailValidate @"MobileAPI/ClientInfo/EmailValidate"
//必填参数：string UserEmail
//返回参数：Success，EmailNum,error
//
//
//我的银行卡接口
#define URL_MyBankListJson @"MobileAPI/ClientInfo/MyBankListJson"
//必填参数：string ClientId,int ?Id
//返回值：items，error
//
//
//添加我的银行卡接口
#define URL_MyBankAddJson @"MobileAPI/ClientInfo/MyBankAddJson"
//必填参数：string ClientId，string CarType，string CarNumber，int？ BankID
//返回值：ReturnHID，ReturnValue，error
//
//
//查询所有银行接口
#define URL_SelectBank @"MobileAPI/CLientInfo/SelectBank"
//返回值：items,error
//
//
//根据银行卡号判断归属地接口
#define URL_GetBankName @"MobileAPI/ClientInfo/GetBankName"
//必填参数：string BankName
//返回值：Name,error
//
//
//关注和取消关注接口
#define URL_AttentionCollection @"MobileAPI/ClientInfo/AttentionCollection"
//必填参数：string ClientId，int? RID，bool IsIsAttention
//返回值：ReturnValue，error
//
//
//获取关注的项目
#define URL_AttentionProjectJson @"MobileAPI/ClientInfo/AttentionProjectJson"
//必填参数：string ClientId
//可选参数：int PageIndex，int PageSize，string State，int? Timelimit
//返回值：items，RowCount，TotalPage，Next，PreviousPage，error
//
//
//提现、充值接口
#define URL_UserFundJson @"MobileAPI/UserFund/UserFundJson"
//必填参数：string ClientId,string UserPass，decimal？Money，int？type
//返回值：ReturnValue，error
//
//
//资金记录接口
#define URL_UserFundListJson @"MobileAPI/UserFund/UserFundListJson"
//必填参数：string ClientId，string Flag，int？ID
//可选参数：string BeginTime，string EndTime，int PageIndex=1，int PageSize=5
//返回值：items，RowCount，TotalPage，Next，PreviousPage，error
//
//
//资金管理查询接口
#define URL_SelectUserFund @"MobileAPI/UserFund/SelectUserFund"
//必填参数：string UserTel
//返回值：items，error
//
//
//修改资金密码接口
#define URL_UserFundpass @"MobileAPI/UserFund/UserFundpass"
//必填参数：string ClientId，string Password，string NewPassword
//返回值：ReturnValue，error
//
//
//资金密码重置接口
#define URL_ResetFundpass @"MobileAPI/UserFund/ResetFundpass"
//必填参数：string UserId，string NewPassword
//返回值：ReturnValue，error
//
//
//投资收益接口
#define URL_MyPersonal @"MobileAPI/UserFund/MyPersonal"
//必填参数：string ClientId
//返回值：items,error
//
//
//个人中心查询投资项目最近n次派息/返本
#define URL_GetLately @"MobileAPI/UserFund/GetLately"
//必填参数：string ClientId
//返回值：RowCount,error
//
//
//每天的利润，走势图接口
#define URL_MyEverydayProfit @"MobileAPI/UserFund/MyEverydayProfit"
//必填参数：string ClientId
//可选参数：int？DayOfWeek，string Datetime
//返回值：items，error

//我的融资接口
#define URL_MyFinancingJson @"MobileAPI/ClientInfo/MyFinancingJson"
//必填参数String ClientId
//可选参数String BeginTime，String EndTime，int PageIndex=1，int PageSize=10
//返回值：items，Next， ReturnValue， PreviousPage， TotalPage，RowCount

/**
 * 客服电话
 */
#define URL_Phone @"tel://18337109530"

#endif
