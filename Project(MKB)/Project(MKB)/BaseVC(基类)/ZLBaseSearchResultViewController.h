//
//  JZBaseSearchResultViewController.h
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/11.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZBaseTableViewController.h"


@class JZBaseSearchViewController;
@interface JZBaseSearchResultViewController : JZBaseTableViewController<UISearchResultsUpdating,UISearchBarDelegate,UISearchDisplayDelegate>



@property(nonatomic,strong)JZBaseSearchViewController *searchViewController;

@property(nonatomic,strong)NSMutableArray *searchDataSource;

- (void)dismissSearchController;

@end
