//
//  DiyCodeSitesCollectionHeaderView.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeSitesCollectionHeaderView.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeSitesCollectionHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation DiyCodeSitesCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

- (void)addSubviews {
    [self addSubview:self.titleLabel];
}

- (void)setupLayout {
    [self.titleLabel fill];
}

#pragma mark - getters & setters
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

@end
