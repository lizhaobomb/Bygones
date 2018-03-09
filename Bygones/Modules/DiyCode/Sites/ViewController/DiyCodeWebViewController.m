//
//  DiyCodeWebViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeWebViewController.h"
#import <WebKit/WKWebView.h>
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeWebViewController ()
@property (nonatomic, strong) WKWebView *wkwebView;
@end

@implementation DiyCodeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupLayout];
}

#pragma mark - methods
- (void)addSubViews {
    [self.view addSubview:self.wkwebView];
}

- (void)setupLayout {
    [self.wkwebView fill];
}

#pragma mark - getters
- (WKWebView *)wkwebView {
    if (!_wkwebView) {
        _wkwebView = [[WKWebView alloc] init];
    }
    return _wkwebView;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
@end
