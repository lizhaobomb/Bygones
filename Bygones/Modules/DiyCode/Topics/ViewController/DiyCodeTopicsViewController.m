//
//  DiyCodeTopicsViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/8.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicsViewController.h"
#import "DiyCodeTopicsApiManager.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "MJRefresh.h"
@interface DiyCodeTopicsViewController ()<CTAPIManagerCallBackDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) DiyCodeTopicsApiManager *topicsApiManager;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) UITableView *topicsTable;
@end

@implementation DiyCodeTopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTable];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupLayout];
}

#pragma mark - methods
- (void)loadData {
    [self.topicsApiManager loadData];
}

- (void)loadNextPage {
    [self.topicsApiManager loadNextPage];
}

- (void)addTable {
    [self.view addSubview:self.topicsTable];
}

- (void)setupLayout {
    [self.topicsTable fill];
}

- (void)endLoading {
    [self.topicsTable.mj_header endRefreshing];
    [self.topicsTable.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TopicsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic[@"title"];
    return cell;
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    if (manager == self.topicsApiManager) {
        self.topics = (NSArray *)manager.response.content;
        [self.topicsTable reloadData];
        [self endLoading];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    [self endLoading];
}

#pragma mark - getters
- (DiyCodeTopicsApiManager *)topicsApiManager {
    if (!_topicsApiManager) {
        _topicsApiManager = [[DiyCodeTopicsApiManager alloc] init];
        _topicsApiManager.delegate = self;
    }
    return _topicsApiManager;
}

- (UITableView *)topicsTable {
    if (!_topicsTable) {
        _topicsTable = [[UITableView alloc] init];
        _topicsTable.delegate = self;
        _topicsTable.dataSource = self;
        _topicsTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        
        _topicsTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadNextPage];
        }];
        ((MJRefreshAutoNormalFooter*)_topicsTable.mj_footer).automaticallyRefresh = NO;
    }
    return _topicsTable;
}

@end