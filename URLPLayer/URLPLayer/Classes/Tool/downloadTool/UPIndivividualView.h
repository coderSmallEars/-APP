//
//  UPIndivividualView.h
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"
#import "UPIndivividualTableView.h"
@interface UPIndivividualView : UPView
@property (nonatomic,strong )UPNavigationView *navigationView;
@property (nonatomic, strong)UPIndivividualTableView *indivividualTV;

//清空吐槽内容
-(void)clearFeedbackContent;
@end
