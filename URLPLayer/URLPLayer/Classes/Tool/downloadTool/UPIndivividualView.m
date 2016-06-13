//
//  UPIndivividualView.m
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPIndivividualView.h"

@implementation UPIndivividualView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        [self.navigationView creatNavigitionViewWithLeftImgName:@"navbar_backarrow_icon" titleName:@"吐槽" rightImgName:@"navbar_search_icon-"];
        [self layoutTableView];
    }
    return self;
}
-(void)layoutTableView{
    _indivividualTV = [[UPIndivividualTableView alloc]initWithFrame:CGRectMake(0, 64.f, kScreenWidth, kScreenHeight - 64.f - kTabbarHeight)];
    [self addSubview:_indivividualTV];
    
}
-(UPNavigationView*)navigationView{
    if (!_navigationView) {
        _navigationView = [[UPNavigationView alloc]initWithFrame:CGRectMake(0, 0.f, kScreenWidth, kNavigationBarHeight + 20.f)];
        [self addSubview:_navigationView];
    }
    return _navigationView;
}
-(void)addDelegate{
    [super addDelegate];
    self.navigationView.delegate = self.delegate;
    _indivividualTV.delegate  = self.delegate;

}
//清空吐槽内容
-(void)clearFeedbackContent{
    [_indivividualTV clearFeedbackContent];

}
@end
