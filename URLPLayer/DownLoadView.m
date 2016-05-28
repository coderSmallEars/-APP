//
//  DownLoadView.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "DownLoadView.h"
#import "UPNavigationView.h"

@interface DownLoadView ()
@property (nonatomic, strong)UPNavigationView * nav;
@end

@implementation DownLoadView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.nav= [[UPNavigationView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
        
        [_nav creatNavigitionViewWithLeftImgName:@"navbar_backarrow_icon" titleName:@"下载管理" rightImgName:@""];
        
        [self addSubview:_nav];
    }

    return self;
}
-(void)addDelegate{
    [super addDelegate];
    self.nav.delegate  = self.delegate;
}
@end
