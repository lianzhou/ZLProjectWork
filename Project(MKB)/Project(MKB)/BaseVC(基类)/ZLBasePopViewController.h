//
//  JZBasePopViewController.h
//  eStudy(comprehensive)
//
//  Created by li_chang_en on 2017/12/3.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZProgramBaseViewController.h"

@interface JZBasePopViewController : JZProgramBaseViewController

//是否模糊效果 默认是NO
@property(nonatomic,assign)BOOL blurBackground;

@property (nonatomic, strong,readonly) UIView *blurBackgroundView;

@property(nonatomic, copy) dispatch_block_t dismissViewControllerBlock;
//视图将要出现
- (void)_willPresent;
//视图正在加载
- (void)_onPresent;
//视图已经出现
- (void)_didPresented;
//视图将要消失
- (void)_willDismiss;
//视图正在消失
- (void)_onDismiss;
//视图已经消失
- (void)_didDismiss;

- (void)dismissViewControllerAnimated;
@end
