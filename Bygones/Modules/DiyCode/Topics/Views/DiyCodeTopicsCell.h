//
//  DiyCodeTopicsCell.h
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiyCodeTopicsCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *datas;

+ (CGFloat)cellHeightForDatas:(NSDictionary *)datas;
@end
