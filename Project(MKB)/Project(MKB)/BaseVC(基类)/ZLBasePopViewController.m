//
//  JZBasePopViewController.m
//  eStudy(comprehensive)
//
//  Created by li_chang_en on 2017/12/3.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZBasePopViewController.h"
#import <JZCommonsKit/PBPresentAnimatedTransitioningController.h>

@interface JZBasePopViewController ()<UIViewControllerTransitioningDelegate>
//默认不加载
@property (nonatomic, strong,readwrite) UIView *blurBackgroundView;

@property (nonatomic,strong) PBPresentAnimatedTransitioningController *transitioningController;

@end

@implementation JZBasePopViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.transitioningDelegate = self;
        self.blurBackground = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0];    
    [self _setupTransitioningController];
}
- (void)_setupTransitioningController {
    @weakify(self);
    self.transitioningController.willPresentActionHandler = ^(UIView *fromView, UIView *toView) {
        @strongify(self);
        [self _willPresent];
    };
    self.transitioningController.onPresentActionHandler = ^(UIView *fromView, UIView *toView) {
        @strongify(self);
        [self _onPresent];
    };
    self.transitioningController.didPresentActionHandler = ^(UIView *fromView, UIView *toView) {
        @strongify(self);
        [self _didPresented];
    };
    self.transitioningController.willDismissActionHandler = ^(UIView *fromView, UIView *toView) {
        @strongify(self);
        [self _willDismiss];
    };
    self.transitioningController.onDismissActionHandler = ^(UIView *fromView, UIView *toView) {
        @strongify(self);
        [self _onDismiss];
    };
    self.transitioningController.didDismissActionHandler = ^(UIView *fromView, UIView *toView) {
        @strongify(self);
        [self _didDismiss];
    };
}
- (void)_willPresent {
    
}
- (void)_onPresent {

}
- (void)_didPresented {
    
}
- (void)_willDismiss {

} 
- (void)_onDismiss {
    
}
- (void)_didDismiss {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissViewControllerAnimated{
    if (self.dismissViewControllerBlock) {
        self.dismissViewControllerBlock();
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 懒加载
- (UIView *)blurBackgroundView {
    if (self.blurBackground) {
        if (!_blurBackgroundView) {
            _blurBackgroundView = [[UIToolbar alloc] initWithFrame:self.view.bounds];
            ((UIToolbar *)_blurBackgroundView).barStyle = UIBarStyleBlack;
            ((UIToolbar *)_blurBackgroundView).translucent = YES;
            _blurBackgroundView.clipsToBounds = YES;
            _blurBackgroundView.multipleTouchEnabled = NO;
            _blurBackgroundView.alpha = 0.0f;
            [_blurBackgroundView jz_setTarget:self action:@selector(dismissViewControllerAnimated)];
        }
    } else {
        if (!_blurBackgroundView) {
            _blurBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
            _blurBackgroundView.backgroundColor = [UIColor blackColor];
            _blurBackgroundView.alpha = 0.0f;
            _blurBackgroundView.clipsToBounds = YES;
            _blurBackgroundView.multipleTouchEnabled = NO;
            [_blurBackgroundView jz_setTarget:self action:@selector(dismissViewControllerAnimated)];
        }
    }
    return _blurBackgroundView;
}
- (PBPresentAnimatedTransitioningController *)transitioningController {
    if (!_transitioningController) {
        _transitioningController = [PBPresentAnimatedTransitioningController new];
    }
    return _transitioningController;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [self.transitioningController prepareForPresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [self.transitioningController prepareForDismiss];
}

@end
