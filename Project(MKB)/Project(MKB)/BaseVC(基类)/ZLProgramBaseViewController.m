//
//  JZProgramBaseViewController.m
//  eStudy(parents)
//
//         我有一壶酒,足以慰风尘
//         倾倒江海里,共饮天下人
//
//  Created by 马金丽 on 17/9/8.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZProgramBaseViewController.h"
#import "JZIMChatViewController.h"

@interface JZProgramBaseViewController ()

@end

@implementation JZProgramBaseViewController
//通知的统一跳转
- (instancetype)initWithNoticeParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[JZUserHelper getUserDataType:JZUserDataTypeUserType] isEqualToString:@"4"]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }else{
        if (self.navigationController.childViewControllers.count == 1) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }else{
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = JZ_KMainColor;
    [self navigationBarBackgroundImageColor:[UIColor whiteColor]];
    if (self.navigationController.viewControllers.count>1) {
        [self setMyselfBaseNavigationBarLeftItemimage];
    }

}

- (void)setMyselfBaseNavigationBarLeftItemimage{
    [self setNavigationBarLeftItemimage:@"wjf_back"];
}

- (void)pushToChatViewControllerWith:(IMAUser *)user{
    [self pushToChatViewControllerWith:user withController:self];
}
- (void)pushToViewControllerItem:(ViewControllerItem *)item{
    
    UIViewController * viewController = [[NSClassFromString(item.itemName) alloc]init];
    if (!JZCheckObjectNull(item.params)) {
        if (item.params.count>0) {
            NSDictionary * propertys = item.params;
            [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([self checkIsExistPropertyWithInstance:viewController verifyPropertyName:key]) {
                    [viewController setValue:obj forKey:key];
                }
            }];
        }
    }
    [self pushViewController:viewController];
    
}
- (void)pushViewController:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}


#pragma mark -IM

- (void)pushToChatViewControllerWith:(IMAUser *)user withController:(UIViewController *)viewCtrl
{
    JZBaseNavigationController *curNav = (JZBaseNavigationController *)[[viewCtrl.tabBarController viewControllers] objectAtIndex:viewCtrl.navigationController.tabBarController.selectedIndex];
    
    if (viewCtrl.navigationController.tabBarController.selectedIndex == 3)
    {
        NSMutableArray *array = [[curNav viewControllers] mutableCopy];
        NSMutableArray <UIViewController *>* viewControllersM =[@[] mutableCopy];
        [viewControllersM addObject:[array firstObject]];
        
        JZUserData * userData = [JZUserHelper obtainLoginInformation];
        if ([userData.userType intValue] != 1 && array.count>1) {
            
            [viewControllersM addObject:[array objectAtIndex:1]];
        }
        
        JZIMChatViewController *vc = [[JZIMChatViewController alloc] initWith:user];
        vc.hidesBottomBarWhenPushed = YES;
        [curNav pushViewController:vc animated:YES];
        
        if ([curNav viewControllers].count == 3) {
            return;
        }
        [self asyncPushToChatViewController:^{
            [viewControllersM addObject:vc];
            [self.navigationController setViewControllers:viewControllersM animated:YES];
        }];
    }
    else  {
        NSString *userType =JZIFISNULL( [JZUserHelper getUserDataType:JZUserDataTypeUserType]);
        
        if([userType isEqualToString:@"1"]){
            
            JZBaseNavigationController *chatNav = (JZBaseNavigationController *)[[viewCtrl.tabBarController viewControllers] objectAtIndex:3];
            JZIMChatViewController *vc = [[JZIMChatViewController alloc] initWith:user];
            vc.hidesBottomBarWhenPushed = YES;
            [chatNav pushViewController:vc animated:YES];
            
            [self switchTabBar:3];

            [curNav popToRootViewControllerAnimated:YES];
        }
        else{
            JZBaseNavigationController *chatNav = (JZBaseNavigationController *)[[viewCtrl.tabBarController viewControllers] objectAtIndex:2];
            JZIMChatViewController *vc = [[JZIMChatViewController alloc] initWith:user];
            vc.hidesBottomBarWhenPushed = YES;
            [chatNav pushViewController:vc animated:YES];
        }
    }
}

- (void)updateTabBarItemBadge:(NSInteger)badge objectAtIndex:(NSUInteger)index{
    JZLog(@"----updateTabBarItemBadge--------------%ld",(long)badge);
    JZBaseTabBarController * tabBarController = (JZBaseTabBarController *)self.tabBarController;
    JZTabBarItem * tabBarItem = [tabBarController.tabBarItems objectAtIndex:index];
    if (badge >0) {
        tabBarItem.badgeStyle = JZTabItemBadgeStyleNumber;
        tabBarItem.badge = badge;
    }else{
        tabBarItem.badgeStyle = JZTabItemBadgeStyleHidden;
    }
}
- (void)switchTabBar:(NSUInteger)index{
    JZBaseTabBarController *main= (JZBaseTabBarController *) self.navigationController.tabBarController;
    [main setSelectedBarItemIndex:index];

}

- (void)asyncPushToChatViewController:(dispatch_block_t)block{
    if (JZ_IOS8) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

-(JZReminderView*)reminderView{
    if(!_reminderView){
        _reminderView=[[JZReminderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    }
    return _reminderView;
} 

@end
@implementation ViewControllerItem

- (instancetype)initWithItemName:(NSString *)itemName;
{
    self = [super init];
    if (self) {
        self.itemName = itemName;
    }
    return self;
}

@end

