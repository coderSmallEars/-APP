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
        
        [self layoutTableView];
    }
    return self;
}
-(void)layoutTableView{
    _indivividualTV = [[UPIndivividualTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f - kTabbarHeight)];
    [self addSubview:_indivividualTV];
    
}

-(void)addDelegate{
    [super addDelegate];
    _indivividualTV.delegate  = self.delegate;

}
//清空吐槽内容
-(void)clearFeedbackContent{
    [_indivividualTV clearFeedbackContent];

}
@end
