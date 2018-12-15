//
//  ViewController.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/15.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import "ViewController.h"
#import "JJOptionView.h"
#import "JJSearchOptionView.h"

@interface ViewController ()<JJOptionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *scView=[[UIView alloc]init];
    scView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scView];
    [scView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.height.mas_equalTo(100);
    }];
    
    
    JJOptionView *view = [[JJOptionView alloc] init];
    view.cornerRadius=0;
    
    view.dataSource = @[@"111",@"222",@"333",@"444",@"555"];
    view.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex) {
       // NSLog(@"%@",optionView);
        NSLog(@"%ld",selectedIndex);
    };
    [scView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    JJSearchOptionView *view1 = [[JJSearchOptionView alloc] init];
    view1.dataSource = @[@"1",@"22",@"213",@"432",@"462",@"872",@"298",@"245",@"20",@"20567"];
    view1.selectedBlock = ^(JJSearchOptionView * _Nonnull optionView, NSString * _Nonnull selctedString, NSInteger selectedIndex) {
       NSLog(@"%@",selctedString);
       NSLog(@"%ld",selectedIndex);
    };
    [scView addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.mas_equalTo(0);
         make.top.mas_equalTo(view.mas_bottom).mas_offset(10);
         make.height.mas_equalTo(40);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
