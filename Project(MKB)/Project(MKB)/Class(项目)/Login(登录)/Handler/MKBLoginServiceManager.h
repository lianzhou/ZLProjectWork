//
//  MKBLoginServiceManager.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//
#import "MKBUserLoginModel.h"

@interface MKBLoginServiceManager : NSObject


/**
 登录接口
 
 @param paramsDic 登录参数
 @param successBlock 成功
 @param failureBlock 失败
 @return 返回请求的唯一标示
 */
+ (NSString *)requestLogin:(NSDictionary *)paramsDic
                withSucess:(void(^)(MKBUserLoginModel *loginModel))successBlock
               withFailure:(void(^)(NSString *errorStr))failureBlock;



@end
