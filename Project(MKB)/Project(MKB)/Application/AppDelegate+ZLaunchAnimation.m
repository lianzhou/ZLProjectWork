//
//  AppDelegate+ZLaunchAnimation.m
//  eStudy
//
//  Created by admin on 2017/12/23.
//  Copyright © 2017年 周连. All rights reserved.
//

#import "AppDelegate+ZLaunchAnimation.h"
#import "LaunchIntroductionView.h"
 
@implementation AppDelegate (ZLaunchAnimation)

- (void)launchAnimation {
    [self showBootLoader];
}

- (void)showBootLoader{
    BOOL isFirstBootLoader = [self isFirstBootLoader];
    if (!isFirstBootLoader) {
        return;
    }
    NSArray * arr = ZL_IPHONE_X ? @[@"x_xcw_guide_1",@"x_xcw_guide_2",@"x_xcw_guide_3",@"x_xcw_guide_4"] : @[@"xcw_guide_1",@"xcw_guide_2",@"xcw_guide_3",@"xcw_guide_4"];
    
    LaunchIntroductionView * introduction = [LaunchIntroductionView sharedWithImages:arr buttonImage:@"xcw_guide_enterBtn" buttonFrame:CGRectMake((SCREEN_WIDTH-176)/2, SCREEN_HEIGHT-45-31, 176, 45)];
    introduction.currentColor = UIColorFromHex(ff6f26);
    introduction.nomalColor = UIColorFromHex(ebebeb);
    
}

#pragma mark - 判断是不是首次登录或者版本更新
-(BOOL )isFirstBootLoader{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}
@end
