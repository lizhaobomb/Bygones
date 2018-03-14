//
//  DiyCodeTopicTitleCell.m
//  Bygones
//
//  Created by lizhao on 2018/3/14.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeTopicTitleCell.h"
#import "DiyCodeTopicsCellTopView.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeTopicTitleCell()
@property (nonatomic, strong) DiyCodeTopicsCellTopView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation DiyCodeTopicTitleCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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
    [self.contentView addSubview:self.titleLabel];
}

- (void)setupLayout {
    self.topView.ct_height = 50;
    self.topView.ct_width = SCREEN_WIDTH;
    
    [self.titleLabel fromTheBottom:0 ofView:self.topView];
    [self.titleLabel widthEqualToView:self.topView];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (DiyCodeTopicsCellTopView *)topView {
    if (!_topView) {
        _topView = [[DiyCodeTopicsCellTopView alloc] init];
    }
    return _topView;
}

- (void)setDatas:(NSDictionary *)datas {
    _datas = datas;
    
    self.topView.datas = datas;
    self.titleLabel.text = datas[@"title"];
    [self.titleLabel sizeToFit];
}

@end
