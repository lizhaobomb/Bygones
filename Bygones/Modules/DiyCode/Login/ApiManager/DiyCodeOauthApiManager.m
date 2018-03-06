//
//  DiyCodeOauthApiManager.m
//  Bygones
//
//  Created by lizhao on 2018/3/6.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeOauthApiManager.h"
#import "DiyCodeOauthService.h"

@interface DiyCodeOauthApiManager()<CTAPIManager,CTAPIManagerValidator>
@end

@implementation DiyCodeOauthApiManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
        self.cachePolicy = CTAPIManagerCachePolicyNoCache;
    }
    return self;
}

- (NSString *)methodName {
    return @"token";
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypePost;
}


- (NSString * _Nonnull)serviceIdentifier {
    return DiyCodeOauthServiceIdentifier;
}


- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithCallBackData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithParamsData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}


@end
