//
//  Target_CTAppContext.m
//  Bygones
//
//  Created by lizhao on 2018/3/2.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "Target_CTAppContext.h"

@implementation Target_CTAppContext

- (BOOL)Action_isReachable:(NSDictionary *)params {
    return YES;
}

- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params {
    return 2;
}

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params {
    return YES;
}

@end
