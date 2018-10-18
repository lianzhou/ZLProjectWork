//
//  MKBProgramBaseViewController.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/17.
//  Copyright © 2018 周连. All rights reserved.
//

#import <ZLCommonsKit/ZLCommonsKit.h>

/**
 * 跳转传参
 */
@interface ViewControllerItem : NSObject

@property (nonatomic, copy)   NSString * itemName;
@property (nonatomic, strong) NSMutableDictionary * params;

- (instancetype)initWithItemName:(NSString *)itemName;
@end

@interface MKBProgramBaseViewController : ZLBaseViewController

#pragma mark -IM
- (void)updateTabBarItemBadge:(NSInteger)badge objectAtIndex:(NSUInteger)index;

- (void)pushToViewControllerItem:(ViewControllerItem *)item;

- (void)switchTabBar:(NSUInteger)index;

//通知的统一跳转
- (instancetype)initWithNoticeParams:(NSDictionary *)params;

@end
