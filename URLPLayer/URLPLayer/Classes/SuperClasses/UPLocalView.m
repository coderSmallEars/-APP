//
//  UPLocalView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPLocalView.h"
#import "SDCycleScrollView.h"
#import "ScorllModel.h"
@interface UPLocalView ()<SDCycleScrollViewDelegate>
{/* 轮播图 */
    SDCycleScrollView *cycleScrollView;
   NSMutableArray * scrollModelArr;
}
@end
@implementation UPLocalView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];

        [self layoutCycleScrollView];
        [self layoutHistoryWatchTableView];
    }
    return self;
}

-(void)clickDeleteBtn{
    [self uiview:nil collectionEventType:@"点击删除按钮" params:nil];
}
-(void)clickToLocalVideo{
    [self uiview:nil collectionEventType:@"搜索本地视频" params:nil];

}

-(void)layoutCycleScrollView{
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, ALDHeight(100.f)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    [self addSubview:cycleScrollView];
}
-(void)layoutHistoryWatchTableView{
    _historyWatchTV = [[UPHistoryWatchtTableView alloc]initWithFrame:CGRectMake(0, cycleScrollView.bottom, kScreenWidth, kScreenHeight - 64.f - ALDHeight(100.f) - kTabbarHeight)];
    [self addSubview:_historyWatchTV];

}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [self uiview:nil collectionEventType:@"点击了轮播图" params:scrollModelArr[index]];
    
}
-(void)updateCycleScrollView:(id)datas{
    scrollModelArr = datas;
    NSMutableArray * imgArr  = [NSMutableArray array];
    NSMutableArray * titleArr = [NSMutableArray array];
    for (ScorllModel * model in datas) {
        [imgArr addObject:model.pic_url];
        [titleArr addObject:model.title];
    }
    cycleScrollView.imageURLStringsGroup = imgArr;
    cycleScrollView.titlesGroup = titleArr; // 如果设置title数
}
/**
 更新历史浏览列表
 */
-(void)updateHistoryWatchTableView:(id)datas{

    [_historyWatchTV updateView:datas];
}

-(void)addDelegate{
    [super addDelegate];
    //self.navigationView.delegate = self.delegate;
    _historyWatchTV.delegate = self.delegate;
}
@end
