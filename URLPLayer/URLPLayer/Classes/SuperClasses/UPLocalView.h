//
//  UPLocalView.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"
#import "UPNavigationView.h"
#import "UPHistoryWatchtTableView.h"
@interface UPLocalView : UPView

@property (nonatomic,strong )UPNavigationView *navigationView;

@property (nonatomic, strong)UPHistoryWatchtTableView *historyWatchTV;

/**
 搜索本地视频按钮
 */
@property (nonatomic, strong)UIButton *searchLocalBtn;

/**
 没有搜索历史记录提示
 */
@property (nonatomic, strong) UILabel * showNoticeLab;

/**
 更新轮播图
 */
-(void)updateCycleScrollViewImages:(id)images titles:(id)titles;

/**
 更新历史浏览列表
 */
-(void)updateHistoryWatchTableView:(id)datas;
@end
