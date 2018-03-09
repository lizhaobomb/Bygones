//
//  DiyCodeSitesCollectionViewCell.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeSitesCollectionViewCell.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DiyCodeSitesCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *icon;
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
    [self.contentView addSubview:self.icon];
}

- (void)setupLayout {
    
    self.icon.ct_size = CGSizeMake(20, 20);
    [self.icon centerYEqualToView:self.contentView];
    
    [self.titleLabel fromTheRight:5 ofView:self.icon];
    [self.titleLabel centerYEqualToView:self.icon];
}

#pragma mark - getters & setters
- (void)setDatas:(NSDictionary *)datas {
    self.titleLabel.text = datas[@"name"];
    [self.titleLabel sizeToFit];
    [self.icon sd_setImageWithURL:datas[@"avatar_url"]];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

@end
