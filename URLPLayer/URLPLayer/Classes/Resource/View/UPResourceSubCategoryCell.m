//
//  UPResourceSubCategoryCell.m
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPResourceSubCategoryCell.h"

@interface UPResourceSubCategoryCell ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel     *subCategoryNameLabel;

@end
@implementation UPResourceSubCategoryCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = UPHexColor(@"#e9e9e9").CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)refreshSubCategoryCollectionCell:(UPUrlSubCategoryModel *)model{
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.video_img] placeholderImage:[UIImage imageNamed:@"share_wechat_session"]];
    self.subCategoryNameLabel.text = model.video_name;
}

-  (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"320_320"]];
        CGFloat length = ALD(40);
        _logoImageView.frame = CGRectMake(ALD(32.5), ALD(16), length, length);
        [self addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UILabel *)subCategoryNameLabel{
    if (!_subCategoryNameLabel) {
        _subCategoryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, ALD(66), self.width - 10, UPSystemFont(15).lineHeight * 2)];
        _subCategoryNameLabel.textAlignment = NSTextAlignmentCenter;
        _subCategoryNameLabel.numberOfLines = 2;
        _subCategoryNameLabel.font = IPHONELESS6 ? UPSystemFont(12) : UPSystemFont(15);
        [self addSubview:_subCategoryNameLabel];
    }
    return _subCategoryNameLabel;
}



@end
