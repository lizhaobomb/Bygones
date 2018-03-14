//
//  DiyCodeTopicDetailWebCell.h
//  Bygones
//
//  Created by lizhao on 2018/3/14.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DiyCodeTopicDetailWebCell : UITableViewCell
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) NSString *html;
@end
