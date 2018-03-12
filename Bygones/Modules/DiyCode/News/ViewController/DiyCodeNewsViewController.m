//
//  DiyCodeNewsViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/5.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeNewsViewController.h"
#import "DiyCodeNewsApiManager.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "MJRefresh.h"
#import "DiyCodeTopicsCell.h"

@interface DiyCodeNewsViewController ()<CTAPIManagerCallBackDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DiyCodeNewsApiManager *newsApiManager;
@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) UITableView *table;
@end

@implementation DiyCodeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.table fill];
}

#pragma mark - methods
- (void)loadData {
    [self.news removeAllObjects];
    [self.newsApiManager loadData];
}

- (void)loadNext {
    [self.newsApiManager loadNextPage];
}

- (void)endRefresh {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidFailed:(CTAPIBaseManager * _Nonnull)manager {
    [self endRefresh];
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager * _Nonnull)manager {
    [self endRefresh];
    if (manager == self.newsApiManager) {
        [self.news addObjectsFromArray:(NSArray *)manager.response.content];
        [self.table reloadData];
    }}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NewsCell";
    DiyCodeTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DiyCodeTopicsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *news = self.news[indexPath.row];
    cell.datas = news;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DiyCodeTopicsCell cellHeightForDatas:self.news[indexPath.row]];
}

#pragma mark - getters & setters
- (DiyCodeNewsApiManager *)newsApiManager {
    if (!_newsApiManager) {
        _newsApiManager = [[DiyCodeNewsApiManager alloc] init];
        _newsApiManager.delegate = self;
    }
    return _newsApiManager;
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadNext];
        }];
    }
    return _table;
}

- (NSMutableArray *)news {
    if (!_news) {
        _news = [NSMutableArray arrayWithCapacity:4];
    }
    return _news;
}




@end
