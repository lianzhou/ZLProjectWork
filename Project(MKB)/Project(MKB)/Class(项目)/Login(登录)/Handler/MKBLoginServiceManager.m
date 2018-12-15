//
//  MKBLoginServiceManager.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//

#import "MKBLoginServiceManager.h"
#import "MKBUserManager.h"
@implementation MKBLoginServiceManager

    
//    [params setObject:phone.text forKey:@"mobile"];
//    [params setObject:pwd.text forKey:@"password"];
    
    //登录接口
+ (NSString *)requestLogin:(NSDictionary *)paramsDic withSucess:(void(^)(MKBUserLoginModel *loginModel))successBlock withFailure:(void(^)(NSString *errorStr))failureBlock {
    
   NSString *password = [paramsDic objectForKey:@"password"];
  //  NSMutableDictionary *paramsDicM = [NSMutableDictionary dictionaryWithDictionary:paramsDic];
   // NSString *shaPasswordStr = [ZLIFISNULL(password) sha256String];
   // [paramsDicM setObject:ZLIFISNULL(shaPasswordStr) forKey:@"password"];
    ZLNetWorkCenterCondition * condition = [[ZLNetWorkCenterCondition alloc]init];
    condition.interface = LOGIN_INTERFACE;
    condition.params = paramsDic;
    condition.isLogin = YES;
    return [[ZLNetWorkCenter shareCenter] requestWithCondition:condition withSuccessBlock:^(ZLNetworkTask *task, id dictData, NSInteger statusCode) {
        
        NSLog(@"dictData ------ %@",dictData);
        MKBUserLoginModel *loginModel = [MKBUserLoginModel mj_objectWithKeyValues:dictData];
        if (loginModel.status == 200) {
            MKBUserDataModel *contentModel = loginModel.content;
            
            [ZLAppConfig shareInstance].apiConfigItem.userId = ZLIFISNULL(contentModel.userId);
            [ZLAppConfig shareInstance].apiConfigItem.accessToken = ZLIFISNULL(contentModel.accessToken);
            
            NSString *accountStr = [paramsDic objectForKey:@"username"];
            //            NSString *password = [paramsDic objectForKey:@"password"];
            [ZLUserDefaults setObject:ZLIFISNULL(accountStr) forKey:LOGIN_ACCOUNT];
            
            [ZLUserDefaults setObject:ZLIFISNULL(password) forKey:LOGIN_PASSWORD];
            
            loginModel.content.loginPassword = ZLIFISNULL(password);
            
            loginModel.content.currentAccount = ZLIFISNULL(accountStr);
            
            loginModel.content.loginTime = [NSString stringWithFormat:@"%lld",loginModel.timeStamp];
            
            [[NSUserDefaults standardUserDefaults] setObject:ZLIFISNULL(contentModel.sPic) forKey:LOGIN_USERPHOTO];
               //保存到本地plist 待加
            successBlock(loginModel);
        }else{
            failureBlock([NSString stringWithFormat:@"%@",ZLIFISNULL(loginModel.errorMsg)]);
        }
    } withFaildBlock:^(ZLNetworkTask *task, NSError *error) {
        
        NSString *errorStr = [error localizedDescription];
        failureBlock([NSString stringWithFormat:@"%@",ZLIFISNULL(errorStr)]);
    }];
}
    
    
@end
