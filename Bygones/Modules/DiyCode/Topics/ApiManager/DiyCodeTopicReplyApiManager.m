//
//  DiyCodeTopicReplyApiManager.m
//  Bygones
//
//  Created by lizhao on 2018/3/14.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicReplyApiManager.h"
#import "DiyCodeService.h"

@interface DiyCodeTopicReplyApiManager()<CTAPIManagerInterceptor,CTAPIManagerValidator>
@property (nonatomic, assign, readwrite) BOOL isFirstPage;
@property (nonatomic, assign, readwrite) BOOL isLastPage;
@property (nonatomic, assign, readwrite) NSUInteger pageNumber;
@property (nonatomic, strong, readwrite) NSString *errorMessage;
@end

@implementation DiyCodeTopicReplyApiManager
@synthesize errorMessage = _errorMessage;

- (instancetype)init {
    if (self = [super init]) {
        self.interceptor = self;
        self.validator = self;
        self.cachePolicy = CTAPIManagerCachePolicyNoCache;
        _pageSize = 20;
        _pageNumber = 0;
        _isFirstPage = YES;
        _isLastPage = NO;
    }
    return self;
}

#pragma mark - CTPagableAPIManager
- (NSInteger)loadData {
    [self cleanData];
    return  [super loadData];
}

- (void)loadNextPage {
    if (self.isLastPage) {
        if ([self.interceptor respondsToSelector:@selector(manager:didReceiveResponse:)]) {
            [self.interceptor manager:self didReceiveResponse:nil];
        }
        return;
    }
    if (!self.isLoading) {
        [super loadData];
    }
}

- (void)cleanData {
    self.isFirstPage = YES;
    self.pageNumber = 0;
    [super cleanData];
}

#pragma mark - CTAPIManager
- (NSString * _Nonnull)methodName {
    NSString *topicId = [self.paramSource paramsForApi:self][@"topicId"];
    return [NSString stringWithFormat:@"/news/%@/replies.json",topicId];
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypeGet;
}

- (NSString * _Nonnull)serviceIdentifier {
    return ServiceIdentifierDiyCode;
}

#pragma mark - CTAPIManagerInterceptor
- (BOOL)manager:(CTAPIBaseManager *_Nonnull)manager beforePerformSuccessWithResponse:(CTURLResponse *_Nonnull)response {
    self.isFirstPage = NO;
    if (response.content.count == 0) {
        self.isLastPage = YES;
    } else {
        self.isLastPage = NO;
        self.pageNumber++;
    }
    return [super beforePerformSuccessWithResponse:response];
}

#pragma mark - CTAPIManagerValidator
- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithCallBackData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithParamsData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}



@end
