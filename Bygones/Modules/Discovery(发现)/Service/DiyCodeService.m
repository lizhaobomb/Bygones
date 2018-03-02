//
//  GerneralService.m
//  Bygones
//
//  Created by lizhao on 2018/2/28.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeService.h"
#import <CTMediator/CTMediator.h>
#import <AFNetworking/AFNetworking.h>

NSString * const ServiceIdentifierDiyCode = @"DiyCodeService";

@interface DiyCodeService()

@property (nonatomic, strong, readonly) NSString *baseURL;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation DiyCodeService

- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType {
    if (requestType == CTAPIManagerRequestTypeGet) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        NSMutableDictionary *finalParams = [params mutableCopy];
        
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:finalParams error:nil];
        return request;
    }
    return nil;
}

- (NSDictionary *)resultWithResponseData:(NSData *)responseData response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError *__autoreleasing *)error {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    result[kCTApiProxyValidateResultKeyResponseData] = responseData;
    result[kCTApiProxyValidateResultKeyResponseJSONString] = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    result[kCTApiProxyValidateResultKeyResponseJSONObject] = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
    return result;
}

- (NSString *)baseURL {
    return @"https://diycode.cc/api/v3";
}

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}

@end
