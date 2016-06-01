//
//  AdvertisementView.m
//  URLPLayer
//
//  Created by wubing on 16/6/1.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "AdvertisementView.h"
#import "UPNavigationView.h"
@interface AdvertisementView ()
@property (nonatomic, strong)UPNavigationView * navigationView;
@property (nonatomic, strong) UIWebView * webView;
@end
@implementation AdvertisementView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
         [self layoutWebView];
    }
    return self;
}
-(void)setModel:(ScorllModel *)model{
    _model = model;
    [self.navigationView creatNavigitionViewWithLeftImgName:@"navbar_backarrow_icon" titleName:_model.title rightImgName:@""];
    NSURL *url = [[NSURL alloc]initWithString:_model.web_url];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}
-(void)layoutWebView{
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64.f, kScreenWidth, kScreenHeight - 64.f)];
    [self addSubview:_webView];

}
-(UPNavigationView*)navigationView{
    if (!_navigationView) {
        _navigationView = [[UPNavigationView alloc]initWithFrame:CGRectMake(0, 0.f, kScreenWidth, kNavigationBarHeight+20)];
        [self addSubview:_navigationView];
    }
    return _navigationView;
}
-(void)addDelegate{
    [super addDelegate];
    self.navigationView.delegate = self.delegate;
}
@end
