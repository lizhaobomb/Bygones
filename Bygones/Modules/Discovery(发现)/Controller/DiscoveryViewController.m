//
//  DiscoveryViewController.m
//  Bygones
//
//  Created by lizhao on 2017/12/15.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiyCodeTopicsApiManager.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiscoveryViewController () <UITableViewDelegate, UITableViewDataSource, CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) DiyCodeTopicsApiManager *manager;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *topics;
@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.table];
    [self.manager loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.table fill];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    NSDictionary *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic[@"title"];
    return cell;
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager * _Nonnull)manager {
    if (manager == self.manager) {
        self.topics = (NSArray *)manager.response.content;
        [self.table reloadData];
        
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager * _Nonnull)manager {
    
}


- (DiyCodeTopicsApiManager *)manager {
    if (!_manager) {
        _manager = [[DiyCodeTopicsApiManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
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
