//
//  TopicManager.h
//  Bygones
//
//  Created by lizhao on 2018/2/27.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <CTNetworking/CTNetworking.h>

@interface DiyCodeTopicsApiManager : CTAPIBaseManager <CTAPIManager,CTPagableAPIManager>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isLastPage;

@end
