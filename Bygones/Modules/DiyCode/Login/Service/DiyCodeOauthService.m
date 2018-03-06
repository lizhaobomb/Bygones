//
//  DiyCodeOauthService.m
//  Bygones
//
//  Created by lizhao on 2018/3/6.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeOauthService.h"
#import <AFNetworking/AFNetworking.h>

NSString *const DiyCodeOauthServiceIdentifier = @"DiyCodeOauthService";

@interface DiyCodeOauthService()
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation DiyCodeOauthService

- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
    NSMutableDictionary *finalParams = [params mutableCopy];
    
    if (requestType == CTAPIManagerRequestTypeGet) {
        
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:finalParams error:nil];
        return request;
    } else if(requestType == CTAPIManagerRequestTypePost){
        
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:finalParams error:nil];
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
    return @"https://diycode.cc/oauth";
}

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFJSONRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}
@end
