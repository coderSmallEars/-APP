//
//  UPBaseTableCell.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPView.h"
@interface UPBaseTableCell : UITableViewCell<UIViewCollectEventsDelegate>
@property (nonatomic,assign) id<UIViewCollectEventsDelegate> delegate;
-(void)uiView:(UIView*)uiView collectEventsType:(id)type params:(id)params;
-(void)updateView:(id)datas;

@end
