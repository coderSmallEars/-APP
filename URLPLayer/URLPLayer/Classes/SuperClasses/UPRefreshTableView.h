//
//  UPRefreshTableView.h
//  URLPlayer
//
//  Created by King on 16/5/22.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UPRefreshViewType) {
    UPRefreshViewTypeNone,
    UPRefreshViewTypeHeader,
    UPRefreshViewTypeFooter,
    UPRefreshViewTypeBoth
};

typedef NS_ENUM(NSInteger, UPRefreshViewStatus) {
    UPRefreshViewStatusIdle = 1, // 普通闲置状态
    UPRefreshViewStatusPulling,    //松手（下拉中才有）
    UPRefreshViewStatusRefreshing, // 正在刷新中的状态
    UPRefreshStateWillRefresh,      //即将刷新的状态
    UPRefreshViewStatusNoMoreData // 所有数据加载完毕，没有更多的数据了（上拉加载更多）
};

@protocol UPRefreshTableViewDelegate <NSObject>

- (void)startHeaderRefresh:(UITableView *)tableView;
- (void)startFooterRefresh:(UITableView *)tableView;

@end

@interface UPRefreshTableView : UITableView

@property (nonatomic, assign)id<UPRefreshTableViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
                   refreshNow:(BOOL)refreshNow
              refreshViewType:(UPRefreshViewType)refreshViewType;


- (void)startHeaderRefresh;
- (void)endHeaderRefresh;

- (void)startFooterRefresh;
- (void)endFoorRefresh;

- (void)hiddenHeader;
- (void)showHeader;

- (void)showFooter;
- (void)hiddenFooter;

@end
