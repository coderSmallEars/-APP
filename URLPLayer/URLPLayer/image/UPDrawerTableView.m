//
//  UPDrawerTableView.m
//  URLPlayer
//
//  Created by wubing on 16/5/27.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDrawerTableView.h"
#import "UPDrawerCell.h"
@implementation UPDrawerTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        self.dataArr =@[@{@"navbar_delete_icon":@"切换主题色"},@{@"navbar_delete_icon":@"加密模式"},@{@"navbar_delete_icon":@"清除缓存"}];
    }
    return self;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALDHeight(22.f) + 20.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"UPDrawerCell";
    UPDrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UPDrawerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    [cell updateView:self.dataArr[indexPath.section]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self uiview:nil collectionEventType:[[self.dataArr[indexPath.section] allValues] objectAtIndex:0]  params:nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return ALDHeight(22.f) + 20.f;
}

@end
