//
//  DiyCodeSitesCollectionViewCell.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeSitesCollectionViewCell.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeSitesCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation DiyCodeSitesCollectionViewCell

//- (instancetype)init {
//    if (self = [super init]) {
//        [self addSubViews];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

- (void)addSubViews {
    [self.contentView addSubview:self.titleLabel];
}

- (void)setupLayout {
    self.titleLabel.ct_width = SCREEN_WIDTH;
    self.titleLabel.ct_height = 50;
}

#pragma mark - getters & setters
- (void)setDatas:(NSDictionary *)datas {
    self.titleLabel.text = datas[@"name"];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

@end
