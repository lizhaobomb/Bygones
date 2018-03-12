//
//  DiyCodeTopicDetialApiManager.m
//  Bygones
//
//  Created by lizhao on 2018/3/12.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicDetialApiManager.h"
#import "DiyCodeService.h"

@interface DiyCodeTopicDetialApiManager()<CTAPIManagerValidator, CTAPIManager>
@end

@implementation DiyCodeTopicDetialApiManager

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        self.validator = self;
    }
    return self;
}

#pragma mark - CTAPIManager
- (NSString * _Nonnull)methodName {
    NSString *topId = [self.paramSource paramsForApi:self][@"topicId"];
    return [NSString stringWithFormat:@"topics/%@.json", topId];
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
