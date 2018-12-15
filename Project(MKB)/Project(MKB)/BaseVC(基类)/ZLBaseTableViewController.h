//
//  JZBaseTableViewController.h
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/8.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZProgramBaseViewController.h"

@interface JZBaseTableViewController : JZProgramBaseViewController<UITableViewDataSource,UITableViewDelegate> 

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
//加载tableView
- (void)createJZTableView;

- (void)addRefreshHeaderWithTable;

- (void)pulldownRefresh;

- (void)endRefreshing;
@end
