//
//  Target_CTAppContext.h
//  Bygones
//
//  Created by lizhao on 2018/3/2.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_CTAppContext : NSObject

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params;
- (BOOL)Action_isReachable:(NSDictionary *)params;
- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params;

@end
