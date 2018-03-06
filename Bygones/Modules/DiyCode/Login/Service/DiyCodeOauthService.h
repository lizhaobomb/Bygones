//
//  DiyCodeOauthService.h
//  Bygones
//
//  Created by lizhao on 2018/3/6.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CTNetWorking/CTNetworking.h>

extern NSString *const DiyCodeOauthServiceIdentifier;

@interface DiyCodeOauthService : NSObject <CTServiceProtocol>
@property (nonatomic, assign) CTServiceAPIEnvironment apiEnvironment;
@end
