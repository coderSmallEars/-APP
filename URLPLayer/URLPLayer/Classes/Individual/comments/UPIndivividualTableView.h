//
//  UPindivividualTableView.h
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPBaseTableView.h"

@interface UPIndivividualTableView : UPBaseTableView
@property (nonatomic, strong)UITextView *inputTextView;
@property (nonatomic, strong)UIButton * commitBtn;
//清空吐槽内容
-(void)clearFeedbackContent;
@end
