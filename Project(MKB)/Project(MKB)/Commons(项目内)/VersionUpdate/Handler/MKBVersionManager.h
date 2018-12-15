//
//  MKBVersionManager.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^MKBVersionSucc) (NSString * latestedVersion, NSString * succString);

typedef void (^MKBUserFail) (NSString *failString);


@interface MKBVersionManager : NSObject

//单例
ZL_SHARED_INSTANCE_DECLARE(MKBVersionManager)

//获取版本信息
- (void)asyncGetVersionModelSucc:(MKBVersionSucc)succ fail:(MKBUserFail)fail;

@end
