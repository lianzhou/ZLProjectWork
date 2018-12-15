//
//  MKBVersionManager.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//

#import "MKBVersionManager.h"
#import "AFNetworking.h"
#import <ZLCommonsKit/ZLCommonsKit.h>

@implementation MKBVersionManager

ZL_SHARED_INSTANCE_DEFINE(MKBVersionManager)

//获取版本信息
- (void)asyncGetVersionModelSucc:(MKBVersionSucc)succ fail:(MKBUserFail)fail{
    //    if (self.versionModel) {
    //        JZ_BLOCK(succ,self.versionModel);
    //        return;
    //    }
    //    [JZUserHandlerManager checkVersionWithSuccessBlock:^(JZSettingCheckVersionModel *dataModel) {
    //        self.versionModel = dataModel;
    //        JZ_BLOCK(succ,self.versionModel);
    //    } failedBlock:fail];
    
    
    // 获取appStore版本号
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // post请求
    [manager POST:[NSString stringWithFormat:@"%@",APPSTOREAPPIDVERSIONCHECK] parameters:nil constructingBodyWithBlock:^(id  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        // ZL_LOG(@"%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSArray *array = dic[@"results"];
        NSDictionary *dict = [array lastObject];
        NSString *version= dict[@"version"];
        
        //         if( ![self->versonCurrent isEqualToString:version])
        //         typedef enum _NSComparisonResult {
        //             NSOrderedAscending = -1, // < 升序
        //             NSOrderedSame, // = 等于
        //             NSOrderedDescending // > 降序
        //         } NSComparisonResult;版本号:%@ \n ,version
        NSComparisonResult result = [ZL_AppVersion compare: version];
        if (result == NSOrderedAscending){
            NSString *releaseNotes =[NSString stringWithFormat:@"%@",dict[@"releaseNotes"]];
             ZL_BLOCK(succ,version,releaseNotes);
        }
        else{
            //先走升级提示,再获取未领
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSString *releaseNotes =[error localizedDescription];
        ZL_LOG(@"%@", releaseNotes);
        ZL_BLOCK(fail,releaseNotes);
    }];
    
}
@end
