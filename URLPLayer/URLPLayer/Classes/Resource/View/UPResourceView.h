//
//  UPResourceView.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"
#import "UPNavigationView.h"
@interface UPResourceView : UPView
@property (nonatomic,strong )UPNavigationView *navigationView;
//更新轮播图
-(void)updateCycleScrollViewImages:(id)images titles:(id)titles;

@end
