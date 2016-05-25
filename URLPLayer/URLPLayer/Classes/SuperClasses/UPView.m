//
//  UPView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"

@implementation UPView
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)uiview:(UIView*)view collectionEventType:(id)type params:(id)params{
    if ([self.delegate respondsToSelector:@selector(uiview:collectionEventType:params:)]) {
        [self.delegate uiview:view collectionEventType:type params:params];
    }
}

/**
 代理
 */
-(void)addDelegate{

}

-(void)setDelegate:(id<UIViewCollectEventsDelegate>)delegate{

    _delegate = delegate;
    [self addDelegate];
}

/**
 更新数据
 */
-(void)updateView:(id)datas{



}
@end
