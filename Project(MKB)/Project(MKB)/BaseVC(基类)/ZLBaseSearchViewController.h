//
//  JZBaseSearchViewController.h
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/8.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZBaseTableViewController.h"
#import "JZBaseSearchResultViewController.h"

@interface JZBaseSearchViewController : JZBaseTableViewController

@property(nonatomic,strong)UISearchController *baseSearchController;
_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
@property(nonatomic,strong)UISearchDisplayController *baseSearchDisController;
_Pragma("clang diagnostic pop")

@property (nonatomic, strong) UISearchBar *searchBar;

@property(nonatomic,strong)JZBaseSearchResultViewController *searchResultViewController;

- (Class)searchResultControllerClass;


- (void)addSearchController;

- (void)willPresentSearchController:(UISearchController *)searchController;
- (void)willDismissSearchController:(UISearchController *)searchController;

@end
