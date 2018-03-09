//
//  TopicsCellTopView.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "TopicsCellTopView.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TopicsCellTopView()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TopicsCellTopView
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

#pragma mark - methods
- (void)addSubViews {
    [self addSubview:self.avatarView];
    [self addSubview:self.titleLabel];
}

- (void)setupLayout {
    self.avatarView.ct_size = CGSizeMake(20, 20);
    self.avatarView.ct_top = 5;
    self.avatarView.ct_left = 5;
    
    [self.titleLabel fromTheRight:5 ofView:self.avatarView];
    [self.titleLabel heightEqualToView:self.avatarView];
    [self.titleLabel rightEqualToView:self];
}

#pragma mark - getters & setters
- (void)setDatas:(NSDictionary *)datas {
    _datas = datas;
    [self.avatarView sd_setImageWithURL:datas[@"avatar_url"]];
    self.titleLabel.text = datas[@"title"];
    [self.titleLabel sizeToFit];
}

- (UIImageView *)avatarView {
    if(!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
    }
    return _avatarView;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _titleLabel;
}
@end
