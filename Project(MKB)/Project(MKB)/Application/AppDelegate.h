//
//  AppDelegate.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/15.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *myWindow;

 

//@property (nonatomic, strong) NSDate * trackStartTime;
//
//// 版本更新数据
//@property (nonatomic, strong) JZVersionUpdateModel * updateModel;

@property (nonatomic, assign) BOOL hasShowNormalUpdateView;

@end

