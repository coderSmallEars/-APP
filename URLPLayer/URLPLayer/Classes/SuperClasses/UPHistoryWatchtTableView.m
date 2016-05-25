//
//  UPHistoryWatchtTableView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPHistoryWatchtTableView.h"
#import "UPHistoryWatchCell.h"
@implementation UPHistoryWatchtTableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALDHeight(114.5f);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"UPHistoryWatchCell";
    UPHistoryWatchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UPHistoryWatchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell updateView:self.datas[indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self uiview:nil collectionEventType:@"点击历史观看cell"  params:nil];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1.f;
}


@end
