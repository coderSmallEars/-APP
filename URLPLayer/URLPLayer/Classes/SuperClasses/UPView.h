//
//  UPView.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewCollectEventsDelegate <NSObject>

@optional
-(void)uiview:(UIView*)view collectionEventType:(id)type params:(id)params;

@end

@interface UPView : UIView

@property (nonatomic ,assign) id<UIViewCollectEventsDelegate> delegate;


-(void)uiview:(UIView*)view collectionEventType:(id)type params:(id)params;
/**
 添加代理
 */
-(void)addDelegate;

/**
 更新数据
 */
-(void)updateView:(id)datas;

@end
