//
//  GerneralService.h
//  Bygones
//
//  Created by lizhao on 2018/2/28.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <CTNetworking/CTNetworking.h>

extern NSString * const ServiceIdentifierDiyCode;

@interface DiyCodeService : NSObject <CTServiceProtocol>

@property (nonatomic, assign) CTServiceAPIEnvironment apiEnvironment;

@end
