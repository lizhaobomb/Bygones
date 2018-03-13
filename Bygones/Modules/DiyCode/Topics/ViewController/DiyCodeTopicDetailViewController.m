//
//  DiyCodeTopicDetailViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/12.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicDetailViewController.h"
#import "DiyCodeTopicDetialApiManager.h"
#import <WebKit/WebKit.h>
#import <HandyFrame/UIView+LayoutMethods.h>
#import <EFMarkdown/EFMarkdown-Swift.h>
@interface DiyCodeTopicDetailViewController ()<CTAPIManagerCallBackDelegate,CTAPIManagerParamSource,WKNavigationDelegate>
@property (nonatomic, strong) DiyCodeTopicDetialApiManager *topicDetailApiManager;
@property (nonatomic, strong) WKWebView *wkWebview;
@property (nonatomic, strong) EFMarkdownView *makrdownView;
@end

@implementation DiyCodeTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupLayout];
}

#pragma mark - method
- (void)loadData {
    [self.topicDetailApiManager loadData];
}

- (void)addSubviews {
    [self.view addSubview:self.wkWebview];
}

- (void)setupLayout {
    [self.wkWebview fill];
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    return @{@"topicId":self.topicId};
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    if (manager == self.topicDetailApiManager) {
        NSLog(@"%@",manager.response.content);
        NSDictionary *dict = manager.response.content;
        [self.wkWebview loadHTMLString:dict[@"body_html"] baseURL:nil];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

 }

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - getters
- (DiyCodeTopicDetialApiManager *)topicDetailApiManager {
    if (!_topicDetailApiManager) {
        _topicDetailApiManager = [[DiyCodeTopicDetialApiManager alloc] init];
        _topicDetailApiManager.delegate = self;
        _topicDetailApiManager.paramSource = self;
    }
    return _topicDetailApiManager;
}

- (WKWebView *)wkWebview {
    if (!_wkWebview) {
        _wkWebview = [[WKWebView alloc] init];
        _wkWebview.navigationDelegate = self;
    }
    return _wkWebview;
}

//- (EFMarkdownView *)makrdownView {
//    if (!_makrdownView) {
//        _makrdownView = [[EFMarkdownView alloc] init];
//    }
//    return _makrdownView;
//}

@end
