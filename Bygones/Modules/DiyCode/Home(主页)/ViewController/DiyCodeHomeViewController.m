//
//  DiyCodeHomeViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/7.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeHomeViewController.h"
#import <TYPagerController/TYPagerController.h>
#import <TYPagerController/TYTabPagerBar.h>
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeHomeViewController () <   TYPagerControllerDelegate,
                                            TYPagerControllerDataSource,
                                            TYTabPagerBarDelegate,
                                            TYTabPagerBarDataSource
                                        >
@property (nonatomic, strong) TYPagerController *pageController;
@property (nonatomic, strong) TYTabPagerBar *tabPagerBar;
@end

@implementation DiyCodeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPageController];
    [self addTabPagerBar];
    [self setupLayout];
}


#pragma mark - methods
- (void)addPageController {
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
}

- (void)addTabPagerBar {
    [self.view addSubview:self.tabPagerBar];
}

- (void)setupLayout {
    self.tabPagerBar.ct_width = SCREEN_WIDTH;
    self.tabPagerBar.ct_height = 44;
    self.tabPagerBar.ct_top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    [self.pageController.view fromTheBottom:0 ofView:self.tabPagerBar];
    self.pageController.view.ct_height = CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.tabPagerBar.frame);
    self.pageController.view.ct_width = SCREEN_WIDTH;
}

#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return 3;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    return [[UIViewController alloc] init];
}

#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return 3;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    NSArray *menu = @[@"News",@"Topics",@"Projects"];
    cell.titleLabel.text = menu[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSArray *menu = @[@"News",@"Topics",@"Projects"];
    NSString *title = menu[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [self.pageController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - getters
- (TYPagerController *)pageController {
    if (!_pageController) {
        _pageController = [[TYPagerController alloc] init];
        _pageController.view.backgroundColor = [UIColor blueColor];
        _pageController.dataSource = self;
        _pageController.delegate = self;
    }
    return _pageController;
}

- (TYTabPagerBar *)tabPagerBar {
    if (!_tabPagerBar) {
        _tabPagerBar = [[TYTabPagerBar alloc] init];
        _tabPagerBar.delegate = self;
        _tabPagerBar.dataSource = self;
        [_tabPagerBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _tabPagerBar;
}

@end
