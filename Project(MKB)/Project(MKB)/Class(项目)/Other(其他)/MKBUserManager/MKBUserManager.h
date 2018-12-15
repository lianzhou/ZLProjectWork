//
//  MKBUserManager.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/23.
//  Copyright © 2018 江苏麦酷博信息科技有限公司. All rights reserved.
//
#import "MKBUserLoginModel.h"

@interface MKBUserManager : NSObject
    
ZL_SHARED_INSTANCE_DECLARE(MKBUserManager);
    
    
    //用户信息
@property (nonatomic, strong) MKBUserDataModel *userModel;
    
@end
