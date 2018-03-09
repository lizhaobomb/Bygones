//
//  DiyCodeSitesViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/8.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeSitesViewController.h"
#import "DiyCodeSitesApiManager.h"
#import "DiyCodeSitesCollectionViewCell.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "DiyCodeSitesCollectionHeaderView.h"
#import "Chameleon.h"
#import "DiyCodeWebViewController.h"
#import <SafariServices/SFSafariViewController.h>

static NSString *CellIdentifier = @"SitesCell";
static NSString *ReuseableViewIdentifer = @"ReuseableView";
@interface DiyCodeSitesViewController () <CTAPIManagerCallBackDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) DiyCodeSitesApiManager *sitesApiManager;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *sites;
@end

@implementation DiyCodeSitesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
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
    [self.sitesApiManager loadData];
}

- (void)addSubViews {
    [self.view addSubview:self.collectionView];
}

- (void)setupLayout {
    [self.collectionView fill];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sites.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *sectionSites = self.sites[section][@"sites"];
    
    return sectionSites.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiyCodeSitesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.datas = self.sites[indexPath.section][@"sites"][indexPath.row];
//    cell.backgroundColor = [UIColor randomFlatColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    DiyCodeSitesCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReuseableViewIdentifer forIndexPath:indexPath];
    
    headerView.title = self.sites[indexPath.section][@"name"];
    return headerView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSString *url = self.sites[indexPath.section][@"sites"][indexPath.row][@"url"];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:safariVC animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH-30)/2, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    if (manager == self.sitesApiManager) {
        self.sites = (NSArray *)manager.response.content;
        [self.collectionView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
}

#pragma mark - getters
- (DiyCodeSitesApiManager *)sitesApiManager {
    if (!_sitesApiManager) {
        _sitesApiManager = [[DiyCodeSitesApiManager alloc] init];
        _sitesApiManager.delegate = self;
    }
    return _sitesApiManager;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionViewLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 30);

        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_collectionViewLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.collectionViewLayout = self.collectionViewLayout;
        [_collectionView registerClass:[DiyCodeSitesCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_collectionView registerClass:[DiyCodeSitesCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReuseableViewIdentifer];
    }
    return _collectionView;
}

@end
