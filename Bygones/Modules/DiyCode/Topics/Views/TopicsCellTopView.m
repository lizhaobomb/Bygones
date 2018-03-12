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
@property (nonatomic, strong) UILabel *timeLabel;
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
    [self addSubview:self.timeLabel];
}

- (void)setupLayout {
    self.avatarView.ct_size = CGSizeMake(20, 20);
    self.avatarView.ct_top = 5;
    self.avatarView.ct_left = 5;
    
    [self.titleLabel fromTheRight:5 ofView:self.avatarView];
    [self.titleLabel topEqualToView:self.avatarView];
    [self.titleLabel heightEqualToView:self.avatarView];
    
    [self.timeLabel rightEqualToView:self];
    [self.timeLabel topEqualToView:self.titleLabel];
    [self.timeLabel heightEqualToView:self.titleLabel];
}

- (NSString *)formatTime:(NSString *)time {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    NSDate *dateFormated = [df dateFromString:time];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [df stringFromDate:dateFormated];
}

#pragma mark - getters & setters
- (void)setDatas:(NSDictionary *)datas {
    _datas = datas;
    [self.avatarView sd_setImageWithURL:datas[@"user"][@"avatar_url"]];
    self.titleLabel.text = datas[@"user"][@"login"];
    [self.titleLabel sizeToFit];
    self.timeLabel.text = [self formatTime:datas[@"updated_at"]];
    [self.timeLabel sizeToFit];
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

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
@end
