
//
//  ZLNavigationService.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/15.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import "ZLNavigationService.h"


@interface ZLNavigationService ()<ZLModuleProtocol>

@end
@implementation ZLNavigationService
- (void)configNavigation:(ZLBaseNavigationController *)navigationController{
    
    UIColor * themeColor = UIColorHex(0xffffff);
    UIFont  * themeFont  = ZL_KDefaultBoldFont(17);
    UIFont  * itemFont  = ZL_KDefaultFont(15);
    
    UINavigationBar * navigationBar = navigationController.navigationBar;
    navigationBar.tintColor = [UIColor whiteColor];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:themeColor] forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setShadowImage:[[UIImage alloc] init]];

    NSMutableDictionary * navigationBarAttributes = [@{} mutableCopy];
    navigationBarAttributes[NSForegroundColorAttributeName] = UIColorFromRGB(0x333333);
    navigationBarAttributes[NSFontAttributeName]            = themeFont;
    [navigationBar setTitleTextAttributes:navigationBarAttributes];
        
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    [item setTintColor:UIColorFromRGB(0x333333)];
    NSMutableDictionary * itemAttributes = [@{} mutableCopy];
    itemAttributes[NSForegroundColorAttributeName] = UIColorFromRGB(0x666666);
    itemAttributes[NSFontAttributeName]            = itemFont;
    [item setTitleTextAttributes:itemAttributes forState:UIControlStateNormal];
    
}
@end
