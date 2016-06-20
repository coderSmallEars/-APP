//
//  AdvertisementView.m
//  URLPLayer
//
//  Created by wubing on 16/6/1.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "AdvertisementView.h"

@interface AdvertisementView ()

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
   
    NSURL *url = [[NSURL alloc]initWithString:_model.web_url];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}
-(void)layoutWebView{
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f)];
    [self addSubview:_webView];

}

-(void)addDelegate{
    [super addDelegate];
   
}
@end
