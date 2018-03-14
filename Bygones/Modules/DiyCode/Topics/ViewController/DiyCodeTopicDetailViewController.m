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
#import <JavaScriptCore/JavaScriptCore.h>
#import "DiyCodeTopicDetailWebCell.h"
#import "DiyCodeTopicTitleCell.h"


@interface DiyCodeTopicDetailViewController ()<CTAPIManagerCallBackDelegate,CTAPIManagerParamSource,
UITableViewDelegate, UITableViewDataSource,WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) DiyCodeTopicDetialApiManager *topicDetailApiManager;
//@property (nonatomic, strong) WKWebView *wkWebview;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic, strong) NSDictionary *responseContent;
//@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation DiyCodeTopicDetailViewController

- (void)dealloc {
//    [self.wkWebview.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initJsContext];
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
- (void)initJsContext {
    [self.jsContext setExceptionHandler:^(JSContext *context, JSValue *exception) {
        NSLog(@"jsContext exception--->:%@",exception.toString);
    }];
    
    //markdown -> html js参考 https://github.com/showdownjs/showdown
    static NSString *js;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        js = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"showdown" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    });
    //加载js
    [self.jsContext evaluateScript:js];
    
    //注入function  markdown -> html，使用时，可以通过 convert('xxx'); 调用
    NSString *jsFunction = @"\
                            function convert(md){\
                                return (new showdown.Converter()).makeHtml(md); \
                            }";
    [self.jsContext evaluateScript:jsFunction];
}

- (void)loadData {
    [self.topicDetailApiManager loadData];
}

- (void)addSubviews {
    [self.view addSubview:self.tableView];
}

- (void)setupLayout {
    [self.tableView fill];
}

- (NSString *)htmlString:(NSString *)md {
    if (!md) {
        return nil;
    }
    JSValue *jsFunctionValue = self.jsContext[@"convert"];
    JSValue *htmlValue = [jsFunctionValue callWithArguments:@[md]];
    
    static NSString *css;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        css = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
    });
    return [NSString stringWithFormat:
            @"<html> \
                <head> \
                    <style>%@</style> \
                </head> \
                <body>%@</body> \
            </html>", css, htmlValue.toString];
}

#pragma mark - UITableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:{
            DiyCodeTopicDetailWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebCell" forIndexPath:indexPath];
            cell.webView.navigationDelegate = self;
            
            cell.html =  [self htmlString:self.responseContent[@"body"]] ?: @"https://lizhaobomb.github.io";
            return cell;
            break;
            
        }
            
        default:{
            DiyCodeTopicTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            cell.datas = self.responseContent;
            return cell;}
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
            return self.webViewHeight;
            break;
            
        default:
            return 100;
            break;
    }
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    return @{@"topicId":self.topicId};
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    if (manager == self.topicDetailApiManager) {
        NSLog(@"%@",manager.response.content);
        self.responseContent = manager.response.content;
//        self.html = [self htmlString:dict[@"body"]];
        [self.tableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
}



#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 计算webView高度
        self.webViewHeight = [result doubleValue] + 20;
        // 刷新tableView
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%@,%@",webView.title,webView.URL.absoluteString);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error--->%@",error.localizedDescription);
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


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DiyCodeTopicTitleCell class] forCellReuseIdentifier:@"TitleCell"];
        [_tableView registerClass:[DiyCodeTopicDetailWebCell class] forCellReuseIdentifier:@"WebCell"];
    }
    return _tableView;
}

- (JSContext *)jsContext {
    if (!_jsContext) {
        _jsContext = [[JSContext alloc] init];
    }
    return _jsContext;
}


@end
