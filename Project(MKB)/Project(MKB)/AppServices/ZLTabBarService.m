//
//  ZLTabBarService.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/15.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import "ZLTabBarService.h"
@interface ZLTabBarService ()<ZLTabBarProtocol>

@end

@implementation ZLTabBarService


- (NSArray *)tabBarItemsAttributes{
    
    NSDictionary *firstTabBarItemsAttributes  = @{
                                                  ZLTabBarItemController:@"ViewController",
                                                  ZLTabBarItemTitle : @"教学",
                                                  ZLTabBarItemImage : @"tabbar_jiaoxue_normal",
                                                  ZLTabBarItemSelectedImage : @"tabbar_jiaoxue_current",
                                                  ZLTabBarItemSelectedColor : UIColorHex(0x0093e8),
                                                  ZLTabBarItemColor : UIColorHex(0x999999),
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes  = @{
                                                  ZLTabBarItemController:@"ViewController",
                                                  ZLTabBarItemTitle : @"工作台",
                                                  ZLTabBarItemImage : @"tabbar_gongzuotai_normal",
                                                  ZLTabBarItemSelectedImage : @"tabbar_gongzuotai_current",
                                                  ZLTabBarItemSelectedColor : UIColorHex(0x0093e8),
                                                  ZLTabBarItemColor : UIColorHex(0x999999),
                                                  
                                                  };
    NSDictionary *fourthTabBarItemsAttributes  = @{
                                                   ZLTabBarItemController:@"ViewController",
                                                   ZLTabBarItemTitle : @"消息",
                                                   ZLTabBarItemImage : @"tabbar_xiaoxi_normal",
                                                   ZLTabBarItemSelectedImage : @"tabbar_xiaoxi_current",
                                                   ZLTabBarItemSelectedColor : UIColorHex(0x0093e8),
                                                   ZLTabBarItemColor : UIColorHex(0x999999),
                                                   
                                                   };
    
    
    
    NSDictionary *fiveTabBarItemsAttributes = @{
                                                ZLTabBarItemController:@"ViewController",
                                                ZLTabBarItemTitle : @"我的",
                                                ZLTabBarItemImage : @"tabbar_wode_normal",
                                                ZLTabBarItemSelectedImage : @"tabbar_wode_current",
                                                ZLTabBarItemSelectedColor : UIColorHex(0x0093e8),
                                                ZLTabBarItemColor : UIColorHex(0x999999),
                                                };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fiveTabBarItemsAttributes
                                       ];
    
    return tabBarItemsAttributes;
}
- (BOOL)tabBarScaleImageButtonAnimate{
    return NO;
}

- (BOOL)tabBarShowShadowColor{
    return NO;
}

- (NSInteger)selectedBarIndex{
    return 0;
}

- (void)tabBarSelectedIndex:(NSUInteger)selectedIndex completionHandler:(void (^)(BOOL))completionHandler{
    
}

@end
