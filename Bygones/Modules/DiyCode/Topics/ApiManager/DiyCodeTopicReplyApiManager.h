//
//  DiyCodeTopicReplyApiManager.h
//  Bygones
//
//  Created by lizhao on 2018/3/14.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <CTNetworking/CTNetworking.h>

@interface DiyCodeTopicReplyApiManager : CTAPIBaseManager <CTPagableAPIManager, CTAPIManager>
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isFirstPage;
@property (nonatomic, assign, readonly) BOOL isLastPage;
@end
