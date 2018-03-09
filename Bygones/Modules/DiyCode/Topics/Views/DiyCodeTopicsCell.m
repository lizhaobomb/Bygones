//
//  DiyCodeTopicsCell.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicsCell.h"
#import "TopicsCellTopView.h"

@interface DiyCodeTopicsCell()

@property(nonatomic, strong) TopicsCellTopView *topView;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *nodeLabel;
@property(nonatomic, strong) UILabel *commentLabel;
@end

@implementation DiyCodeTopicsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

- (void)addSubviews {
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.nodeLabel];
    [self.contentView addSubview:self.commentLabel];
}

- (void)setupLayout {
}

#pragma mark - getters
- (TopicsCellTopView *)topView {
    if (!_topView) {
        _topView = [[TopicsCellTopView alloc] init];
    }
    return _topView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}

- (UILabel *)nodeLabel {
    if (!_nodeLabel) {
        _nodeLabel = [[UILabel alloc] init];
        _nodeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _nodeLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _commentLabel;
}

@end
