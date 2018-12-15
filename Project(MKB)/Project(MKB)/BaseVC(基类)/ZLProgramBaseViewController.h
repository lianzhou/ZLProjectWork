//
//  JZProgramBaseViewController.h
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/12.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import <JZCommonsKit/JZCommonsKit.h>
#import "JZReminderView.h"

/**
 * 跳转传参 
 */
@interface ViewControllerItem : NSObject

@property (nonatomic, copy)   NSString * itemName;
@property (nonatomic, strong) NSMutableDictionary * params;

- (instancetype)initWithItemName:(NSString *)itemName;
@end

@interface JZProgramBaseViewController : JZBaseViewController

@property (nonatomic, strong) JZReminderView *reminderView;

#pragma mark -IM
- (void)updateTabBarItemBadge:(NSInteger)badge objectAtIndex:(NSUInteger)index;
- (void)pushToChatViewControllerWith:(IMAUser *)user withController:(UIViewController *)viewCtrl;

- (void)pushToChatViewControllerWith:(IMAUser *)user;
- (void)pushToViewControllerItem:(ViewControllerItem *)item;

- (void)switchTabBar:(NSUInteger)index;

//通知的统一跳转
- (instancetype)initWithNoticeParams:(NSDictionary *)params;

@end
