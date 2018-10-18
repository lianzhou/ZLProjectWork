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

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   
    
    ZLAPIConfigItem * item     = [[ZLAPIConfigItem alloc]init];
    item.environmentDictionary =
    @{[NSNumber numberWithInteger:ZLNetEnvironmentTypeFormal]:@"http://api.teach.ZLexueyun.com/",
      [NSNumber numberWithInteger:ZLNetEnvironmentTypeTest]:@"http://test.teach.juziwl.cn/",
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
    [self.window makeKeyAndVisible];
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
  //  [super applicationWillEnterForeground:application];
    
    [self _getVersionData];
    
}

- (void)_getVersionData{
    
    // 判断是否有版本更新
    
//    [[JZUserManager sharedInstance] asyncGetVersionModelSucc:^(JZSettingCheckVersionModel *versionModel) {
//
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//
//        NSString * minimumVersion = versionModel.sMinVersion;
//        NSString * latestedVersion = versionModel.sVersion;
//        NSString * url = versionModel.sUrl;
//        NSString * desc = versionModel.sDesc;
//        //强制升级
//        if ([minimumVersion compare:currentVersion options:(NSNumericSearch)] == NSOrderedDescending) {
//
//            self.updateModel = [[JZVersionUpdateModel alloc] init];
//            self.updateModel.versionNumber = latestedVersion;
//            self.updateModel.updateDesc = desc;
//            self.updateModel.updateUrl = url;
//            self.updateModel.isForcedUpdate = YES;
//
//            //普通升级
//        }else if ([latestedVersion compare:currentVersion options:(NSNumericSearch)] == NSOrderedDescending){
//
//            self.updateModel = [[JZVersionUpdateModel alloc] init];
//            self.updateModel.versionNumber = latestedVersion;
//            self.updateModel.updateUrl = url;
//            self.updateModel.updateDesc = desc;
//
//        }
//
//    } fail:^(NSString *failString) {
//
//    }];
}


@end
