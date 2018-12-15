//
//  JZBaseSearchResultViewController.m
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/11.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZBaseSearchResultViewController.h"

@interface JZBaseSearchResultViewController ()

@end

@implementation JZBaseSearchResultViewController

- (void)viewDidLoad {
    [self navigationBarBackgroundImageColor:UIColorFromHex(0x00af5b)];
    self.tableView.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    
}

- (void)dismissSearchController {
    [self.searchViewController.searchBar resignFirstResponder];
    self.searchViewController.searchBar.text = @"";
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"点击了搜索$$$搜索内容是:%@",searchBar.text);
}


#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"搜索内容:%@",searchController.searchBar.text);
}




_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchDisplayController setActive:YES animated:YES];
    [searchBar setShowsCancelButton:YES animated:YES];
    for (UIView *subView in [searchBar subviews]) {
        for (UIView *view1 in [subView subviews]) {
            if ([view1 isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view1;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:UIColorFromHex(0x00af5b) forState:UIControlStateNormal];
                
            }
        }
    }
    searchBar.backgroundImage = [UIImage imageWithColor:JZ_KMainColor];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //取消第一响应值,键盘回收,搜索结束
    [searchBar setShowsCancelButton:NO animated:NO];
    [searchBar resignFirstResponder];
    
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"搜索内容%@",searchString);
    return YES;
}
_Pragma("clang diagnostic pop")


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
