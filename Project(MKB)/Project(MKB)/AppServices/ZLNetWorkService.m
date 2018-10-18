//
//  ZLNetWorkService.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/15.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import "ZLNetWorkService.h"
//#import "ZLLoginServiceManager.h"
//#import "ZLWebViewController.h"

@interface ZLNetWorkService ()<ZLNetWorkTaskProtocol>

@end

@implementation ZLNetWorkService
- (void)automaticRefreshTokenOnNetWorkManager:(ZLNetWorkManager *)workManager task:(ZLNetworkTask *)task successBlock:(ZLRequestSuccessBlock)successBlock failureBlock:(ZLRequestFailureBlock)failureBlock{

    NSString * phoneStr    = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ACCOUNT];
    NSString * passwordStr =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PASSWORD];
    if (ZLStringIsNull(phoneStr) || ZLStringIsNull(passwordStr)) {
        return;
    }
    
    
    NSMutableDictionary *requestHeaderDicM = [NSMutableDictionary dictionaryWithDictionary:task.requestHeaders];
    [requestHeaderDicM addEntriesFromDictionary:[ZLNetWorkCenter authenticationDictionary]];
    task.requestHeaders = requestHeaderDicM;
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    NSString *shaPassWStr = [ZLIFISNULL(passwordStr) sha256String];
    [paramsDic setObject:ZLIFISNULL(phoneStr) forKey:@"username"];
    [paramsDic setObject:ZLIFISNULL(shaPassWStr) forKey:@"password"];

    ZLNetWorkCenterCondition * condition = [[ZLNetWorkCenterCondition alloc]init];
    condition.interface = @"";
    condition.params = paramsDic;
    condition.isLogin = YES;
    [[ZLNetWorkCenter shareCenter] requestWithCondition:condition withSuccessBlock:^(ZLNetworkTask *task1, id dictData, NSInteger statusCode) {

//        ZLUserLoginModel *loginModel = [ZLUserLoginModel mj_objectWithKeyValues:dictData];
//        if (loginModel.status == 200) {
//            ZLUserDataModel *contentModel = loginModel.content;
//
//            loginModel.content.loginPassword = ZLIFISNULL(passwordStr);
//
//            loginModel.content.currentAccount = ZLIFISNULL(phoneStr);
//
//            loginModel.content.loginTime = [NSString stringWithFormat:@"%lld",loginModel.timeStamp];
//
//            [ZLAppConfig shareInstance].apiConfigItem.userId = ZLIFISNULL(contentModel.userId);
//            [ZLAppConfig shareInstance].apiConfigItem.accessToken = ZLIFISNULL(contentModel.accessToken);
//            [ZLUserHelper saveUserInfo:contentModel successBlock:^(NSString *urlString) {
//                NSLog(@"urlString --------- %@",urlString);
//            } failedBlock:^(NSString *errorString) {
//                NSLog(@"errorString --------- %@",errorString);
//            }];
////            if ([task.requestHeaders.allKeys containsObject:@"AccessToken"]) {
////
////                 [task.requestHeaders setObject:[ZLAppConfig shareInstance].apiConfigItem.accessToken forKey:@"AccessToken"];
////            }
//            [task.requestHeaders setObject:[ZLAppConfig shareInstance].apiConfigItem.accessToken forKey:@"AccessToken"];
//            [workManager addTask:task];
//        }
        if (successBlock) {
            successBlock(task,dictData,statusCode);
        }
    } withFaildBlock:failureBlock];

}

BOOL isNetWorkManagerMaintain = NO;

- (void)netWorkManagerMaintain:(ZLNetWorkManager *)workManager task:(ZLNetworkTask *)task response:(id)responseObject{
    if (isNetWorkManagerMaintain == YES) {
        return;
    }
    isNetWorkManagerMaintain = YES;
    /*
    [ZLUserHelper LogoutWitnSuccessBlock:^{
       
        NSDictionary * responseDictionary = (NSDictionary *)responseObject;
        if (responseDictionary && [responseDictionary isKindOfClass:[NSDictionary class]]) {
            NSDictionary * contentDictionary = [responseDictionary objectForKey:@"content"];
            if (contentDictionary && [contentDictionary isKindOfClass:[NSDictionary class]]) {
                NSString * path = [NSString stringWithFormat:@"%@",[contentDictionary objectForKey:@"path"]];
                if (!ZLStringIsNull(path) && [path isKindOfClass:[NSString class]]) {
                    
                    ZLWebDataContentModel * webContentModel = [[ZLWebDataContentModel alloc] init];
                    webContentModel.pageTitleStr = @"维护中...";
                    webContentModel.webPageDisplayType = ZLWebPageDisplayTypeNormal;
                    webContentModel.articleHtmlStr = path;

                    ZLWebViewController *wenViewController = [[ZLWebViewController alloc] init];
                    wenViewController.contentModel = webContentModel;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        dispatch_main_async_safe(^{
                            UINavigationController *  navigationController = [[UINavigationController alloc] initWithRootViewController:wenViewController];
                            [[ZLContext shareInstance].currentViewController presentViewController:navigationController animated:YES completion:^{
        
                            }];
                        });
                    });

                }
            }
        }
    }];*/
}
@end
