//
//  JZBaseTableViewController.m
//  eStudy(parents)
//
//  Created by 马金丽 on 17/9/8.
//  Copyright © 2017年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZBaseTableViewController.h"

@interface JZBaseTableViewController ()

@end

@implementation JZBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createJZTableView];
    self.tableView.backgroundColor = JZ_KMainColor;
}
- (void)createJZTableView{
    [self.view addSubview:self.tableView];
}
- (void)addRefreshHeaderWithTable{
    WEAKSELF
    [self.tableView addRefreshHeaderWithNormal:NO Handle:^{
        [weakSelf pulldownRefresh];
    }];

}
- (void)pulldownRefresh{

}
- (void)endRefreshing{
    [self.tableView.JZ_header endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:section];
    return [groupModel getCellCount];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:indexPath.section];
    JZTableViewCellModel *model = [groupModel objectAtIndex:indexPath.row];
    
    if (JZStringIsNull(model.cellClassName)) {
        NSAssert(NO, @"[cell <cellClassName> 为空]");
    }
    Class cellClass = NSClassFromString(model.cellClassName);
    JZBaseTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
    if (!cell) {
        cell = [(JZBaseTableViewCell *)[cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:model.identifier];
    }
    [cell settingModelData:model groupModel:groupModel indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:indexPath.section];
    JZTableViewCellModel *model = [groupModel objectAtIndex:indexPath.row];
    return model.rowHeight <= 0?44:model.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];    
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:indexPath.section];
    JZTableViewCellModel *model = [groupModel objectAtIndex:indexPath.row];
    
    if (model.didSelectRowAtIndexPath) {
        model.didSelectRowAtIndexPath(indexPath);
    }
    [model makeNormalCell:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataSource.count ==0) {
        return 0;
    }
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:section];
    if (groupModel.footerView) {
        return groupModel.footerView.bounds.size.height;
    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataSource.count ==0) {
        return 0.01;
    }
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:section];
    if (groupModel.headerView) {
        return groupModel.headerView.bounds.size.height;
    }
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.dataSource.count ==0) {
        return nil;
    }
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:section];
    if (groupModel.headerView) {
        return groupModel.headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.dataSource.count ==0) {
        return nil;
    }
    JZSectionGroupModel *groupModel = [self.dataSource objectAtIndex:section];
    if (groupModel.footerView) {
        return groupModel.footerView;
    }
    return nil;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:[self tableViewStyle]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionIndexColor = UIColorFromRGB(0x666666);
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle {
    
    return UITableViewStylePlain;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [@[] mutableCopy];
    }
    return _dataSource;
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
