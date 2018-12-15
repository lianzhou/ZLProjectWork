//
//  MKBLoginModel.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/17.
//  Copyright © 2018 周连. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKBUserDataModel;

@interface MKBUserLoginModel : ZLBaseDataModel

@property (nonatomic, strong) MKBUserDataModel *content;

@end


@interface MKBUserDataModel : NSObject
//ID号
@property (nonatomic, copy) NSString          *sExueCode;
//手机号
@property (nonatomic, copy) NSString          *sPhone;
//婚姻状况
@property (nonatomic, copy) NSString          *sMaritalStatus;
//出生日期
@property (nonatomic, copy) NSString          *sBirth;
//地区
@property (nonatomic, copy) NSString          *sAreaName;
//图片
@property (nonatomic, copy) NSString          *sPic;
//证件类型
@property (nonatomic, copy) NSString          *sCertificateType;
//省
@property (nonatomic, copy) NSString          *sProvinceName;
//市
@property (nonatomic, copy) NSString          *sCityName;
//用户名称
@property (nonatomic, copy) NSString          *sName;
//性别
@property (nonatomic, copy) NSString          *ssex;
//userID
@property (nonatomic, copy) NSString          *pId;
//证件号
@property (nonatomic, copy) NSString          *sCertificateNumber;
//登录时间
@property (nonatomic, copy) NSString          *loginTime;
//省id
@property (nonatomic, copy) NSString          *provinceId;
//市id
@property (nonatomic, copy) NSString          *cityId;
//区id
@property (nonatomic, copy) NSString          *areaId;
//userId
@property (nonatomic, copy) NSString          *userId;
//token
@property (nonatomic, copy) NSString          *accessToken;
//登录密码
@property (nonatomic, copy) NSString          *loginPassword;

//是否是第一次登陆 1表示是    0表示不是
@property (nonatomic, copy) NSString          *isFirstLogin;
#pragma mark -添加字段

//数据库主键
@property (nonatomic, copy) NSString          *currentAccount;

@end
