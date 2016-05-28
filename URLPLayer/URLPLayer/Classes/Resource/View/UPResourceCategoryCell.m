//
//  UPResourceCategoryCell.m
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPResourceCategoryCell.h"

@implementation UPResourceCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UPHexColor(@"#f6f6f6");
        self.categoryNameLabel = [UILabel new];
        self.categoryNameLabel.textAlignment = NSTextAlignmentCenter;
        self.categoryNameLabel.font = IPHONELESS6 ? UPSystemFont(12) : UPSystemFont(15);
        self.categoryNameLabel.numberOfLines = 0;
        [self.contentView addSubview:self.categoryNameLabel];
        WS(weakSelf)
        [self.categoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(5);
            make.right.equalTo(weakSelf.contentView).offset(-5);
            make.top.bottom.equalTo(weakSelf.contentView);
        }];
        
        UIView *selectBackgtoundView = [UIView new];
        selectBackgtoundView.backgroundColor = [UIColor whiteColor];
        UIView *leftIndicate = [UIView new];
        leftIndicate.backgroundColor = UPHexColor(@"ffbc0c");
        [selectBackgtoundView addSubview:leftIndicate];
        [leftIndicate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(selectBackgtoundView);
            make.width.mas_equalTo(3);
        }];
        self.selectedBackgroundView = selectBackgtoundView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.categoryNameLabel.textColor = UPHexColor(@"#ffbc0c");
    }else{
        self.categoryNameLabel.textColor = UPHexColor(@"#333333");
    }
}


@end
