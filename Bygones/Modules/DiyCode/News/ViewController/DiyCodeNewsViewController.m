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

@interface DiyCodeNewsViewController ()<CTAPIManagerCallBackDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DiyCodeNewsApiManager *newsApiManager;
@property (nonatomic, strong) NSArray *news;
@property (nonatomic, strong) UITableView *table;
@end

@implementation DiyCodeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    [self.newsApiManager loadData];
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

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidFailed:(CTAPIBaseManager * _Nonnull)manager {
    
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager * _Nonnull)manager {
    if (manager == self.newsApiManager) {
        self.news = (NSArray *)manager.response.content;
        [self.table reloadData];
    }}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *news = self.news[indexPath.row];
    cell.textLabel.text = news[@"title"];
    return cell;
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
    }
    return _table;
}




@end
