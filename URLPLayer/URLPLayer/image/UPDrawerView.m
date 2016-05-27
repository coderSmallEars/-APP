//
//  UPDrawerView.m
//  URLPlayer
//
//  Created by wubing on 16/5/27.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDrawerView.h"

@implementation UPDrawerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutTableView];
    }
    return self;
}
-(void)layoutTableView{
    _drawerTableView  = [[UPDrawerTableView alloc]initWithFrame:CGRectMake(0, kScreenHeight/3.0, kScreenWidth, 5 *(ALDHeight(22.f) + 20.f) + 1.5f)];
    [self addSubview:_drawerTableView];


}
-(void)addDelegate{
    [super addDelegate];
    _drawerTableView.delegate = self.delegate;

}
@end
