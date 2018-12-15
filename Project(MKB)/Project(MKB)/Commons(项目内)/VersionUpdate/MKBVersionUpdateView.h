//
//  MKBVersionUpdateView.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKBVersionUpdateModel;
@interface MKBVersionUpdateModel : NSObject

@property (nonatomic, copy) NSString * versionNumber;
@property (nonatomic, copy) NSString * updateDesc;//更新
@property (nonatomic, assign) BOOL isForcedUpdate;//是否强制更新,默认为NO
@property (nonatomic, copy) NSString * updateUrl;//跳转App Store地址

@end


@interface MKBVersionUpdateView : UIView

- (instancetype)initWithVersionModel:(MKBVersionUpdateModel *)model;
- (void)show; 

@end
