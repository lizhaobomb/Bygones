//
//  DiyCodeTopicDetailWebCell.m
//  Bygones
//
//  Created by lizhao on 2018/3/14.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicDetailWebCell.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeTopicDetailWebCell()<WKUIDelegate, WKNavigationDelegate>

@end

@implementation DiyCodeTopicDetailWebCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

- (void)setupLayout {
    [self.webView fill];
}

- (void)addSubviews {
    [self.contentView addSubview:self.webView];
}

#pragma mark - getters
- (void)setHtml:(NSString *)html {
    if (html.length && ![_html isEqualToString:html]) {
        _html = html;
        
        [self.webView loadHTMLString:html baseURL:nil];
        [self addSubviews];
    }
}

- (WKWebView *)webView {
    if (!_webView) {
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    }
    return _webView;
}

@end
