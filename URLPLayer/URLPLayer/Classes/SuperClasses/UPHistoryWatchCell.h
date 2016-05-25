//
//  UPHistoryWatchCell.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPBaseTableCell.h"

@interface UPHistoryWatchCell : UPBaseTableCell

/**
 图片
 */
@property  (nonatomic, strong)UIImageView *picImgView;

/**
 标题
 */
@property (nonatomic, strong)UILabel *titleLab;

/**
 简介
 */
@property (nonatomic, strong)UILabel *descriptLab;


@end
