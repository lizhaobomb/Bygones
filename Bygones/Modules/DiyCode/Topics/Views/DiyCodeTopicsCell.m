//
//  DiyCodeTopicsCell.m
//  Bygones
//
//  Created by lizhao on 2018/3/9.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicsCell.h"
#import "TopicsCellTopView.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <ChameleonFramework/Chameleon.h>

@interface DiyCodeTopicsCell()

@property(nonatomic, strong) TopicsCellTopView *topView;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *nodeLabel;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, strong) UIView *seperatorView;
@end

@implementation DiyCodeTopicsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    [self.contentView addSubview:self.seperatorView];
}

- (void)setupLayout {
    self.topView.ct_width = self.contentView.ct_width - 20;
    self.topView.ct_left = 10;
    [self.topView setCt_height:30];
    
    [self.contentLabel fromTheBottom:0 ofView:self.topView];
    [self.contentLabel leftEqualToView:self.topView];
    [self.contentLabel widthEqualToView:self.topView];
    
    [self.nodeLabel fromTheBottom:10 ofView:self.contentLabel];
    [self.nodeLabel leftEqualToView:self.topView];
    
    [self.commentLabel fromTheRight:5 ofView:self.nodeLabel];
    [self.commentLabel topEqualToView:self.nodeLabel];
    
    [self.seperatorView fromTheBottom:10 ofView:self.commentLabel];
    [self.seperatorView widthEqualToView:self.contentView];
    [self.seperatorView setCt_height:10];
}

#pragma mark - getters & cetters
- (void)setDatas:(NSDictionary *)datas {
    _datas = datas;
    self.topView.datas = datas;
    self.contentLabel.text = datas[@"title"];
    [self.contentLabel sizeToFit];
    
    self.nodeLabel.text = datas[@"node_name"];
    [self.nodeLabel sizeToFit];

    self.nodeLabel.ct_width = self.nodeLabel.ct_width + 10;
    
    self.commentLabel.text = [NSString stringWithFormat:@"评论:%@",datas[@"replies_count"]];
    [self.commentLabel sizeToFit];

}

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
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)nodeLabel {
    if (!_nodeLabel) {
        _nodeLabel = [[UILabel alloc] init];
        _nodeLabel.font = [UIFont systemFontOfSize:12];
        _nodeLabel.layer.cornerRadius = 3;
        _nodeLabel.layer.borderWidth = 1;
        _nodeLabel.layer.borderColor = [UIColor randomFlatColor].CGColor;
        _nodeLabel.textAlignment = NSTextAlignmentCenter;
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

- (UIView *)seperatorView {
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc] init];
        _seperatorView.backgroundColor = [UIColor flatGrayColor];
    }
    return _seperatorView;
}

+ (CGFloat)cellHeightForDatas:(NSDictionary *)datas {
    NSString *content = datas[@"title"];
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT);

    CGFloat contentHeight = [content boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    return 30 + 10 + 15 + contentHeight + 20;
}

@end
