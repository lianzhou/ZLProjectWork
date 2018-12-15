//
//  MKBVersionUpdateTool.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//

#import "MKBVersionUpdateTool.h"
#import "MKBVersionUpdateView.h"

@implementation MKBVersionUpdateTool

+ (void)showUpdateViewOnSpaceController{
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.updateModel && delegate.updateModel.versionNumber.length >0){
        
        if (delegate.hasShowNormalUpdateView == NO) {
            delegate.hasShowNormalUpdateView = YES;
            MKBVersionUpdateView * updateView = [[MKBVersionUpdateView alloc] initWithVersionModel:delegate.updateModel];
            [updateView show];
        }
    }
}

+ (void)showUpdateViewOnSettingController{
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.updateModel && delegate.updateModel.versionNumber.length >0){
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [ZLAlertHUD alertShowTitle:[NSString stringWithFormat:@"当前版本号为 %@,是否更新至%@版本?",app_Version,delegate.updateModel.versionNumber] message:@"" cancelButtonTitle:@"暂不升级" otherButtonTitle:@"立即升级" continueBlock:^{
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", delegate.updateModel.updateUrl]];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[ UIApplication sharedApplication] openURL :url];
            }
        }];
        
    }
}



@end
