//
//  DiyCodeSitesApiManager.m
//  Bygones
//
//  Created by lizhao on 2018/3/8.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeSitesApiManager.h"
#import "DiyCodeService.h"

@interface DiyCodeSitesApiManager()<CTAPIManager,CTAPIManagerValidator>
@end

@implementation DiyCodeSitesApiManager

#pragma mark - life cyle
- (instancetype)init {
    if (self = [super init]) {
        self.validator = self;
    }
    return self;
}

#pragma mark - CTAPIManager
- (NSString * _Nonnull)methodName {
    return @"sites.json";
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypeGet;
}

- (NSString * _Nonnull)serviceIdentifier {
    return ServiceIdentifierDiyCode;
}


#pragma mark - CTAPIManagerValidator
- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithCallBackData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager * _Nonnull)manager isCorrectWithParamsData:(NSDictionary * _Nullable)data {
    return CTAPIManagerErrorTypeNoError;
}


@end
