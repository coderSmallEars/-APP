//
//  UPRefreshTableView.m
//  URLPlayer
//
//  Created by King on 16/5/22.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPRefreshTableView.h"

@implementation UPRefreshTableView{
    BOOL isHeaderRefresh;
    BOOL isFooterRefresh;
}

- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
         refreshNow:(BOOL)isRefresh
    refreshViewType:(UPRefreshViewType)type{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        isHeaderRefresh = isRefresh;
        isFooterRefresh = NO;
        self.tableFooterView = [UIView new];
        [self setSeparatorInset:UIEdgeInsetsZero];
        
        
        NSArray *idleImages = @[];
        
        switch (type) {
            case UPRefreshViewTypeHeader:{
                [self createHeaderWithImages:idleImages];
            }
                break;
                
            case UPRefreshViewTypeFooter:{
                [self createFooterWithImages:idleImages];
            }
                break;
                
            case UPRefreshViewTypeBoth:{
                [self createHeaderWithImages:idleImages];
                [self createFooterWithImages:idleImages];
            }
                break;
                
            default:
                break;
        }
        
        if ((type == UPRefreshViewTypeHeader || type == UPRefreshViewTypeBoth)
            && isRefresh) {
            [self startHeadRefresh];
        }
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self;
}

- (void)createHeaderWithImages:(NSArray *)idleImages{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeaderRefresh)];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    [header setImages:idleImages forState:MJRefreshStatePulling];
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
}

- (void)createFooterWithImages:(NSArray *)idleImages{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterRefresh)];
    [footer setImages:idleImages forState:MJRefreshStateRefreshing];
    self.footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    footer.hidden = YES;
    
}


- (void)setRefreshingImages:(NSArray *)images
                  withState:(UPRefreshViewStatus)viewState
                   position:(UPRefreshViewType)position{
    if (position == UPRefreshViewTypeHeader && viewState < 3) {
        
    }else if(position == UPRefreshViewTypeFooter){
        
    }
    
    
    
}

- (void)loadHeaderRefresh{
    if ([self.delegate respondsToSelector:@selector(startHeaderRefresh:)]) {
        [self.delegate performSelector:@selector(startHeaderRefresh:) withObject:self];
    }else{
        [self.header endRefreshing];
        NSLog(@"未实现下拉刷新事件");
    }
}

- (void)loadFooterRefresh{
    
    if ([self.delegate respondsToSelector:@selector(startFooterRefresh:)]) {
        [self.delegate performSelector:@selector(startFooterRefresh:) withObject:self];
    }else{
        [self.footer endRefreshing];
        NSLog(@"未实现上拉加载事件");
    }
    
}


- (BOOL)automaticallyRefresh{
    return [(MJRefreshAutoFooter *)self.footer isAutomaticallyRefresh];
}

- (void)setAutomaticallyRefresh:(BOOL)automaticallyRefresh{
    [(MJRefreshAutoFooter *)self.footer setAutomaticallyRefresh:automaticallyRefresh];
}



- (void)startHeadRefresh{
    [self.header beginRefreshing];
}

- (void)endHeadRefresh{
    [self.header endRefreshing];
}


- (void)startFootRefresh{
    [self.footer beginRefreshing];
}

- (void)endFootFefresh{
    [self.footer endRefreshing];
}

- (void)hiddenHeader
{
    if (self.header) {
        self.header.hidden = YES;
    }
}

- (void)showHeader
{
    if (self.header) {
        self.header.hidden = NO;
    }
}

- (void)hiddenFooter{
    if (self.footer) {
        self.footer.hidden = YES;
    }
}

- (void)showFooter{
    if (self.footer) {
        self.footer.hidden = NO;
    }
}

@end
