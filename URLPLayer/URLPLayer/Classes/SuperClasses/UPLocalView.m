//
//  UPLocalView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPLocalView.h"
#import "SDCycleScrollView.h"

@interface UPLocalView ()<SDCycleScrollViewDelegate>
{/* 轮播图 */
    SDCycleScrollView *cycleScrollView;

}
@end
@implementation UPLocalView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.navigationView creatNavigitionViewWithLeftImgName:@"navbar_backarrow_icon" titleName:@"历史" rightImgName:@"navbar_search_icon-"];
       //删除按钮
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *deleteImg = [UIImage imageNamed:@"navbar_delete_icon"];
        [deleteBtn setImage:deleteImg forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.frame = CGRectMake(self.navigationView.rightBtn.left - 20.f - deleteImg.size.width, 0, deleteImg.size.width +20.f, deleteImg.size.height +20.f);
        deleteBtn.centerY = self.navigationView.height/2.0;
        [self.navigationView addSubview:deleteBtn];
        [self layoutCycleScrollView];
        [self layoutHistoryWatchTableView];
    }
    return self;
}

-(void)clickDeleteBtn{
    [self uiview:nil collectionEventType:@"点击删除按钮" params:nil];
}
-(UPNavigationView*)navigationView{
    if (!_navigationView) {
        _navigationView = [[UPNavigationView alloc]initWithFrame:CGRectMake(0, 20.f, kScreenWidth, kNavigationBarHeight)];
        [self addSubview:_navigationView];
    }
    return _navigationView;
}
-(void)layoutCycleScrollView{
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20.f + kNavigationBarHeight, kScreenWidth, ALDHeight(170.f)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    [self addSubview:cycleScrollView];
}
-(void)layoutHistoryWatchTableView{
    _historyWatchTV = [[UPHistoryWatchtTableView alloc]initWithFrame:CGRectMake(0, cycleScrollView.bottom, kScreenWidth, kScreenHeight - 64.f - ALDHeight(170.f) - kTabbarHeight)];
    [self addSubview:_historyWatchTV];

}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}
-(void)updateCycleScrollViewImages:(id)images titles:(id)titles{

    cycleScrollView.imageURLStringsGroup = @[
                                             @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                             @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                             @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                             ];
    cycleScrollView.titlesGroup = @[@"haha",@"haha",@"haha"]; // 如果设置title数
}
/**
 更新历史浏览列表
 */
-(void)updateHistoryWatchTableView:(id)datas{
    [_historyWatchTV updateView:datas];
}

-(void)addDelegate{
    [super addDelegate];
    self.navigationView.delegate = self.delegate;
    _historyWatchTV.delegate = self.delegate;
}
@end
