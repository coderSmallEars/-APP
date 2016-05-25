//
//  UPBaseTableView.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"

@interface UPBaseTableView : UPView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) UITableView * tableView;
@end
