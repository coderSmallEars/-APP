//
//  UPBaseTableView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPBaseTableView.h"

@implementation UPBaseTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _datas = [NSMutableArray array];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        //分割线设置
        _tableView.separatorColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, ALD(19.5f), 0, ALD(19.5f));
        
        [self addSubview:_tableView];
        
        
    }
    return self;
}
-(void)updateView:(id)datas
{
    
    [_datas removeAllObjects];
    [_datas addObjectsFromArray:datas];
    [_tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    return cell;
}

@end
