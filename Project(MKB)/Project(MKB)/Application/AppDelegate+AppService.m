//
//  AppDelegate+AppService.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "PPNetworkHelper.h"

@implementation AppDelegate (AppService)


#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:@"KNotificationLoginStateChange"
                                               object:nil];
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:@"KNotificationNetWorkStateChange"
                                               object:nil];
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =ZL_WhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = ZL_WhiteColor;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}


#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
   // BOOL loginSuccess = [notification.object boolValue];
    
}


#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {//有网络
        [ZLAlertHUD showTipTitle:@"有网络"];
        
    }else {//登陆失败加载登陆页面控制器
        // [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
          [ZLAlertHUD showTipTitle:@"网络状态不佳"];
    }
}


#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    /* 打开调试日志 */
    //[[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    // [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
    
    [self configUSharePlatforms];
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
    /* 设置微信的appKey和appSecret */
    // [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    // [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    //    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    //    if (!result) {
    //        // 其他如支付等SDK的回调
    //    }
    
    //    return result;
    
    return NO;
}

#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                ZL_LOG(@"网络环境：未知网络");
                // 无网络
            case PPNetworkStatusNotReachable:
                ZL_LOG(@"网络环境：无网络");
                ZL_PostNotification(@"KNotificationNetWorkStateChange", @NO);
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                ZL_LOG(@"网络环境：手机自带网络");
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                ZL_LOG(@"网络环境：WiFi");
                ZL_PostNotification(@"KNotificationNetWorkStateChange", @YES);
                break;
        }
        
    }];
    
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end
