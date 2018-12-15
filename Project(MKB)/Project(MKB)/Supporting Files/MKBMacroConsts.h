//
//  MKBMacroConsts.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/17.
//  Copyright © 2018 周连. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - API

//TODO:周连
//是否自动登录
static NSString *const AUTOMATIC_LOGIN = @"User/login";
//自动登录或手动登录
static NSString *const ADVERT_IS_MOTION_LONGIN = @"ADVERT_IS_MOTION_LONGIN";
//自动登录或手动登录
static NSString *const ADVERT_IS_LAUNCHANIMATION_END = @"ADVERT_IS_LaunchAnimation_end";

static NSString *const LOGINUSERINFORMATION = @"UserLoginInformation"; //用户登录的信息

static NSString *const LOGIN_ACCOUNT = @"Login_Account";//账号的存储

static NSString *const LOGIN_PASSWORD = @"Login_Password";//密码的存储

static NSString *const LOGIN_USERPHOTO = @"Login_User_Photo";//头像的存储
//登陆成功后返回的数据
static NSString *const LOGIN_SUCCESS_INFORMATION = @"Login_Success_Information";
//登陆成功后的用户的个人信息
static NSString *const USER_PERSONAL_INFORMATION = @"User_Personal_Information";


static NSString *const LOGIN_INTERFACE =@"UserInfo/LoginAccount";

static NSString *const kAppVersion = @"appVersion";

@interface MKBMacroConsts : NSObject

@end


#define  ZL_KDefaultBlueColor UIColorFromRGB(0x0093e8)
#define  ZL_KDefaultOangeColor UIColorFromRGB(0xff6f26)

#define  ZL_KDefaultBorderColor UIColorFromRGB(0xcccccc).CGColor
#define  ZL_KDefaultNavLineColor UIColorFromRGB(0xdddddd).CGColor
#define  ZL_KDefaultCellLineColor UIColorFromRGB(0xebebeb).CGColor

#define ZL_Page @"1"
#define ZL_Rows @"10"

#pragma mark - 本地存储
static NSString *const ACTIVESYSTEM_SYSTEMTIME = @"ActiveSystem_systemTime";
static NSString *const SYSTEMACTIVE_SYSTEMTIME = @"SystemActive_systemTime";
static NSString *const OFFLINETIME_SYSTEMTIME = @"OfflineTime_systemTime";
static NSString *const OPEN_CLASS_SHOW_MEMBER =  @"Open_Class_Show_Member";
static NSString *const UPLOADTIME_SYSTEMTIME = @"uploadTime_systemTime";
static NSString *const SPACE_SEYSTEMTIME = @"uploadTime_time";

static NSString *const ZL_IM_OFFNETWORK_TIP  = @"世界上最遥远的距离就是没网！检查设置";

#pragma mark - 配置

#ifdef DEBUG

//苹果ID
#define applestoreid 1320753024
//苹果版本更新地址
#define APPSTOREAPPIDVERSIONCHECK [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%d",applestoreid]

#else



#endif

/**
 页面类型
 */
typedef NS_ENUM(NSInteger,ZLPageServiceType) {
    ZLPageSerivceTypeFindPassWord = 0,//找回密码
    ZLPageSerivceTypeChangePhoneNumber,//更改手机号
    ZLPageServicePasswordTypeResetPassword,//重置密码
};

/*跳转类型*/
typedef NS_ENUM(NSInteger, kZLPushType) {
    kZLPushTypeController     = 0,//跳转Controller
    kZLPushTypeInWeb          = 1,//跳转内链
    kZLPushTypeOutWeb         = 2,//跳转外链
};

extern NSString * ZL_NoticeMethods[];      /* 通知的KEY */
/* 通知的KEY */
typedef NS_ENUM(NSUInteger, ZLNotificationType) {
    
    ZLNotificationTypeUnknow = 0,     //未知
    ZLNotificationStoreReloadPoint,   //刷新积分商城的积分
};



