//
//  AppDelegate.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/15.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import "AppDelegate.h"
#import "MKBLoginViewController.h"
#import "ZLNavigationService.h"
#import "ZLNetWorkService.h"
#import "ZLTabBarService.h"

#import "ZLAppDelegate.h"
#import "MKBVersionManager.h"
#import "MKBVersionUpdateTool.h"

#import "AppDelegate+AppService.h"
#import "AppDelegate+ZLaunchAnimation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindow];
    
    [self monitorNetworkStatus];
    
    ZLAPIConfigItem * item     = [[ZLAPIConfigItem alloc]init];
    item.environmentDictionary =
    @{[NSNumber numberWithInteger:ZLNetEnvironmentTypeFormal]:@"http://api.teach.ZLexueyun.com/",
      [NSNumber numberWithInteger:ZLNetEnvironmentTypeTest]:@"http://www.booida.com/index.php?s=AppV1/",
      [NSNumber numberWithInteger:ZLNetEnvironmentTypeLocal]:@"http://192.168.121.37:8080/exue-teach-web/", // 37:8080
      };
    
    
    item.environmentType = ZLNetEnvironmentTypeTest;
    
    ZLAppConfig * appConfig = [ZLAppConfig shareInstance];
    appConfig.apiConfigItem = item;
    appConfig.apiConfigItem.clientType = @"2";
    
    //    [appConfig registedModuleServices: [@[[[ZLPushService alloc]init],[[ZLOtherInitService alloc]init],[[ZLPayService alloc]init],[[ZLUMShareService alloc]init]] mutableCopy]];
    [appConfig registedModuleServices:[@[[[ZLTabBarService alloc]init]] mutableCopy] protocol:@ protocol(ZLTabBarProtocol)];
    [appConfig registedModuleServices:[@[[[ZLNavigationService alloc]init]] mutableCopy] protocol:@protocol(ZLNavigationProtocol)];
    [appConfig registedModuleServices:[@[[[ZLNetWorkService alloc]init]] mutableCopy] protocol:@protocol(ZLNetWorkTaskProtocol)];
    
    //  [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    
    MKBLoginViewController *loginViewController = [[MKBLoginViewController alloc] init];
    ZLBaseNavigationController *baseNavigationController = [[ZLBaseNavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = baseNavigationController;
    
    [self launchAnimation];
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    //  [super applicationWillEnterForeground:application];
    
    // [self _getVersionData];
    
}

/**
 判断是否有版本更新
 */
- (void)_getVersionData{
    
    [[MKBVersionManager shareInstance] asyncGetVersionModelSucc:^(NSString *latestedVersion, NSString *succString) {
        self.updateModel = [[MKBVersionUpdateModel alloc] init];
        self.updateModel.versionNumber = latestedVersion;
        self.updateModel.updateUrl = [NSString stringWithFormat:
                                      @"itms-apps://itunes.apple.com/app/id%d",
                                      applestoreid ];
        self.updateModel.updateDesc = succString;
        
        [MKBVersionUpdateTool showUpdateViewOnSpaceController];
        
    } fail:^(NSString *failString) {
        
    }];
    
}


@end
