//
//  UPHistoryWatchtTableView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPHistoryWatchtTableView.h"
#import "UPHistoryWatchCell.h"

@interface UPHistoryWatchtTableView ()<MGSwipeTableCellDelegate>

@end
@implementation UPHistoryWatchtTableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALDHeight(90.5f);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"UPHistoryWatchCell";
    UPHistoryWatchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UPHistoryWatchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.delegate = self;
    [cell updateView:self.datas[indexPath.row]];
    
    return cell;
}
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
   
    if (direction == MGSwipeDirectionRightToLeft){
        return [self createRightButtons:2];
    }
    return nil;
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[2] = {@"删除", @"加密"};
    UIColor * colors[2] = {[UIColor redColor], [UIColor lightGrayColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (right).");
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
        }];
        [result addObject:button];
    }
    return result;
}
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{     NSIndexPath * path = [self.tableView indexPathForCell:cell];
   
    if(direction == MGSwipeDirectionRightToLeft && index == 1){
        if (path.row !=0 ) {
            id moveData = [self.datas objectAtIndex:path.row];
            [self.datas removeObjectAtIndex:path.row];
            [self.datas insertObject:moveData atIndex:0];
            [self.tableView moveRowAtIndexPath:path toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
#warning  修改数据库
            
            
        }
    
    }
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        [self.datas removeObjectAtIndex:path.row];
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    }
    
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self uiview:nil collectionEventType:@"点击历史观看cell"  params:nil];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.5f;
}


@end
