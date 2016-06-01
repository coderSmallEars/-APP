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
        [self.navigationView creatNavigitionViewWithLeftImgName:@"navbar_backarrow_icon" titleName:@"历史" rightImgName:@"navbar_search_icon-"];
       //删除按钮
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *deleteImg = [UIImage imageNamed:@"navbar_delete_icon"];
        [deleteBtn setImage:deleteImg forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.frame = CGRectMake(self.navigationView.rightBtn.left - 20.f - deleteImg.size.width, 0, deleteImg.size.width +20.f, deleteImg.size.height +20.f);
        deleteBtn.centerY = self.navigationView.height/2.0 + 10.f;
        [self.navigationView addSubview:deleteBtn];
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
-(UIButton *)searchLocalBtn{
    if (_searchLocalBtn == nil) {
        _searchLocalBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [_searchLocalBtn setTitle:@"搜索本地视频" forState:UIControlStateNormal];
        _searchLocalBtn.titleLabel.font  = [UIFont systemFontOfSize:14.0];
        [_searchLocalBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_searchLocalBtn setBackgroundColor:[UIColor colorWithHexString:@"f5f5f5"]];
        _searchLocalBtn.layer.cornerRadius = 6.0;
        _searchLocalBtn.clipsToBounds = YES;
        _searchLocalBtn.frame = CGRectMake(0, 0, 100.f, 30.f);
        _searchLocalBtn.centerX = kScreenWidth/2.0;
        _searchLocalBtn.top = self.showNoticeLab.bottom + 10.f;
        _searchLocalBtn.hidden = YES;
        [_searchLocalBtn addTarget:self action:@selector(clickToLocalVideo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchLocalBtn];
    }
    return _searchLocalBtn;

}
-(UILabel *)showNoticeLab{
    if (_showNoticeLab == nil) {
        _showNoticeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _showNoticeLab.center = _historyWatchTV.center;
        _showNoticeLab.centerY = _showNoticeLab.centerY - 30.f;
        _showNoticeLab.textAlignment = NSTextAlignmentCenter;
        _showNoticeLab.textColor = [UIColor colorWithHexString:@"333333"];
        _showNoticeLab.font = [UIFont systemFontOfSize:14.0];
        _showNoticeLab.text = @"您还没有历史游览记录";
        [self addSubview:_showNoticeLab];
        _showNoticeLab.hidden = YES;
    }
    return _showNoticeLab;
}
-(UPNavigationView*)navigationView{
    if (!_navigationView) {
        _navigationView = [[UPNavigationView alloc]initWithFrame:CGRectMake(0, 0.f, kScreenWidth, kNavigationBarHeight+20)];
        [self addSubview:_navigationView];
    }
    return _navigationView;
}
-(void)layoutCycleScrollView{
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20.f + kNavigationBarHeight, kScreenWidth, ALDHeight(100.f)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
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
    if (datas == nil) {
        self.showNoticeLab.hidden = NO;
        self.searchLocalBtn.hidden = NO;
    }else{
        self.showNoticeLab.hidden = YES;
        self.searchLocalBtn.hidden = YES;
    }
    [_historyWatchTV updateView:datas];
}

-(void)addDelegate{
    [super addDelegate];
    self.navigationView.delegate = self.delegate;
    _historyWatchTV.delegate = self.delegate;
}
@end
