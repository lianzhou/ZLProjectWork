//
//  MKBProgramBaseViewController.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/17.
//  Copyright © 2018 周连. All rights reserved.
//

#import "MKBProgramBaseViewController.h"

@interface MKBProgramBaseViewController ()

@end

@implementation MKBProgramBaseViewController


//通知的统一跳转
- (instancetype)initWithNoticeParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = ZL_KMainColor;
    [self navigationBarBackgroundImageColor:UIColorFromHex(0xffffff)];
    if (self.navigationController.viewControllers.count>1) {
        [self setMyselfBaseNavigationBarLeftItemimage];
    }
    
}

- (void)setMyselfBaseNavigationBarLeftItemimage{
    [self setNavigationBarLeftItemimage:@"wjf_back"];
}

- (void)pushToViewControllerItem:(ViewControllerItem *)item{
    
    UIViewController * viewController = [[NSClassFromString(item.itemName) alloc]init];
    if (!ZLCheckObjectNull(item.params)) {
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

- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
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


- (void)updateTabBarItemBadge:(NSInteger)badge objectAtIndex:(NSUInteger)index{
    NSLog(@"------------------%ld",(long)badge);
    ZLBaseTabBarController * tabBarController = (ZLBaseTabBarController *)self.tabBarController;
    ZLTabBarItem * tabBarItem = [tabBarController.tabBarItems objectAtIndex:index];
    if (badge >0) {
        tabBarItem.badgeStyle = ZLTabItemBadgeStyleNumber;
        tabBarItem.badge = badge;
    }else{
        tabBarItem.badgeStyle = ZLTabItemBadgeStyleHidden;
    }
}
- (void)switchTabBar:(NSUInteger)index{
    ZLBaseTabBarController *main= (ZLBaseTabBarController *) self.navigationController.tabBarController;
    [main setSelectedIndex:index];
    [main setSelectedBarItemIndex:index];
}

- (void)asyncPushToChatViewController:(dispatch_block_t)block{
    if (ZL_IOS8) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
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
