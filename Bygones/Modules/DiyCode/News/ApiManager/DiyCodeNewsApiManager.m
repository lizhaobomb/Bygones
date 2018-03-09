//
//  DiyCodeNewsApiManager.m
//  Bygones
//
//  Created by lizhao on 2018/3/5.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeNewsApiManager.h"
#import "DiyCodeService.h"

@interface DiyCodeNewsApiManager()<CTAPIManagerValidator,CTAPIManagerInterceptor>

@property (nonatomic, assign, readwrite) BOOL isFirstPage;
@property (nonatomic, assign, readwrite) BOOL isLastPage;
@property (nonatomic, assign, readwrite) NSUInteger pageNumber;
@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation DiyCodeNewsApiManager

@synthesize errorMessage;

- (instancetype)init {
    self = [super init];
    if (self) {
        _isFirstPage = YES;
        _isLastPage = NO;
        _pageSize = 20;
        _pageNumber = 0;
        self.cachePolicy = CTAPIManagerCachePolicyNoCache;
        self.validator = self;
        self.interceptor = self;
    }
    return self;
}

- (NSString * _Nonnull)methodName {
    return @"news.json";
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypeGet;
}

- (NSString * _Nonnull)serviceIdentifier {
    return ServiceIdentifierDiyCode;
}

- (NSInteger)loadData {
    [self cleanData];
    return [super loadData];
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
    [super cleanData];
    _isFirstPage = YES;
    _pageNumber = 0;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *result = [params mutableCopy];
    if (result == nil) {
        result = [[NSMutableDictionary alloc] init];
    }
    if (result[@"limit"] == nil) {
        result[@"limit"] = @(self.pageSize);
    } else {
        self.pageSize = [result[@"limit"] integerValue];
    }
    
    if (result[@"offset"] == nil) {
        if (self.isFirstPage == NO) {
            result[@"offset"] = @(self.pageNumber * self.pageSize);
        } else {
            result[@"offset"] = @(0);
        }
    } else {
        self.pageNumber = [result[@"offset"] unsignedIntegerValue] / self.pageSize;
    }
    return result;
}

#pragma mark - CTAPIManagerInterceptor
- (BOOL)beforePerformSuccessWithResponse:(CTURLResponse *)response {
    _isFirstPage = NO;
    if (response.content.count == 0) {
        _isLastPage = YES;
    } else {
        _isLastPage = NO;
        _pageNumber++;
    }
    return YES;
}

#pragma mark - CTAPIManagerValidator
- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithCallBackData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithParamsData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}

#pragma mark - getters & setters
- (NSUInteger)currentPageNumber {
    return self.pageNumber;
}
@end
