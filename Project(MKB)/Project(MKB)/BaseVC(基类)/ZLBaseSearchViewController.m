//
//  JZBaseSearchViewController.m
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/8.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZBaseSearchViewController.h"
#import "JZBaseSearchResultViewController.h"


@interface JZBaseSearchViewController ()<UISearchControllerDelegate>


@end

@implementation JZBaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    JZBaseNavigationController *chatNav = (JZBaseNavigationController *)[JZContext shareInstance].currentViewController.navigationController;
    if ([[JZContext shareInstance].currentViewController.navigationController isKindOfClass:[JZBaseNavigationController class]]) {
        chatNav.jz_isNoUseGesture = [NSNumber numberWithBool:YES];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    JZBaseNavigationController *chatNav = (JZBaseNavigationController *)[JZContext shareInstance].currentViewController.navigationController;
    if ([[JZContext shareInstance].currentViewController.navigationController isKindOfClass:[JZBaseNavigationController class]]) {
        chatNav.jz_isNoUseGesture = [NSNumber numberWithBool:NO];
    }
}
- (Class)searchResultControllerClass
{
    return [JZBaseSearchResultViewController class];
}
- (NSString *)searchBarPlaceholder{
    return @"搜索";
}
- (BOOL)searchBarCornerRadius{
    return YES;
}
- (void)addSearchBarToView{
    self.tableView.tableHeaderView = self.searchBar;
}
- (void)addSearchController
{ 
    self.searchResultViewController = [[[self searchResultControllerClass] alloc]init];
    
    CGFloat deviceVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (deviceVersion >= 8.0) {
        self.baseSearchController = [[UISearchController alloc]initWithSearchResultsController:self.searchResultViewController];
        self.baseSearchController .delegate = self;
        self.baseSearchController.searchResultsUpdater = self.searchResultViewController;
        [self.baseSearchController.searchBar sizeToFit];    //必须要让searchBar自适应才会显示
        self.baseSearchController.searchBar.delegate = self.searchResultViewController;
        self.baseSearchController.searchBar.placeholder = [self searchBarPlaceholder];
        [self.baseSearchController.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];//关闭系统自动大写功能
        self.baseSearchController.searchBar.backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xf5f5f5)];
        self.baseSearchController.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
        
        UITextField *searchField = [self.baseSearchController.searchBar valueForKey:@"searchField"];
        if (searchField) {
            searchField.font = KDefaultFont(13.0f);
            searchField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lce_chat_icon_serach"]];
        }
        if ([self searchBarCornerRadius]) {
            if (searchField) {
                [searchField setBackgroundColor:[UIColor whiteColor]];
                if (JZ_IOS11) {
                    searchField.layer.cornerRadius = 19.0f;
                }else{
                    searchField.layer.cornerRadius = 14.0f;
                }
                searchField.layer.masksToBounds = YES;
            }
        }
        self.searchBar = self.baseSearchController.searchBar;
        
        [self addSearchBarToView];
        
    }else{
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        searchBar.backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xf5f5f5)];
        [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [searchBar sizeToFit];
        searchBar.placeholder = [self searchBarPlaceholder];
        searchBar.delegate = self.searchResultViewController;
        self.searchBar = searchBar;
        
        [self addSearchBarToView];
        
        JZDeprecatedSelectorLeakWarning(
                                        self.baseSearchDisController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
                                        self.baseSearchDisController.searchResultsDataSource = self.searchResultViewController;
                                        self.baseSearchDisController.searchResultsDelegate = self.searchResultViewController;
                                        self.baseSearchDisController.delegate = self.searchResultViewController;
                                        
                                        self.baseSearchDisController.searchResultsTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
                                        );
        
        
    }
    
    self.definesPresentationContext = YES;
    self.searchResultViewController.searchViewController = self;
    
    
}



- (void)willPresentSearchController:(UISearchController *)searchController
{
//    [self.view addSubview:[JZFlurBackView sharenInstance].blurBackView];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
//    [[JZFlurBackView sharenInstance].blurBackView removeFromSuperview];
}


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

