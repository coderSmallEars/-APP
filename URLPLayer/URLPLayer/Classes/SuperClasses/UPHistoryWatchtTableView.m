//
//  UPHistoryWatchtTableView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPHistoryWatchtTableView.h"
#import "UPHistoryWatchCell.h"
#import "SqliteTool.h"
#import "UPUrlSubCategoryModel.h"
@interface UPHistoryWatchtTableView ()<MGSwipeTableCellDelegate,UIActionSheetDelegate>
{
    NSIndexPath * encryptPath;

}
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
    NSArray * titles;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Encrypt] == nil || [[[NSUserDefaults standardUserDefaults] objectForKey:User_Encrypt] isEqualToString:@"2"]){
    titles = @[@"删除", @"加密"];
    
    }else{
    titles = @[@"删除", @"解密"];
    }
    
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
{     encryptPath = [self.tableView indexPathForCell:cell];
   
    if(direction == MGSwipeDirectionRightToLeft && index == 1){
    
           //加密或解密
        if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Secret] == nil) {
            //未设置密码
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" ,nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
             [alertView textFieldAtIndex:0].placeholder = @"请输入密码";
            [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeEmailAddress;
            [alertView show];

        }
        else{
            UPUrlSubCategoryModel * model = self.datas[encryptPath.row];
            if (model.encrypt == 0) {
                
                model.encrypt = 1;
                [SqliteTool removeHistory:model];
                [SqliteTool addHistory:model];
                [self.datas removeObjectAtIndex:encryptPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[encryptPath] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                [SqliteTool removeHistory:model];
                model.encrypt = 0;
                [SqliteTool addHistory:model];
            
            }
        }
    }
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        [SqliteTool removeHistory:self.datas[encryptPath.row]];
        [self.datas removeObjectAtIndex:encryptPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[encryptPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        return NO; //Don't autohide to improve delete expansion animation
    }
    
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self uiview:nil collectionEventType:@"点击历史观看cell"  params:self.datas[indexPath.row]];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.5f;
}
#pragma mark UIAlertView的代理方法 点击了提醒框上面的按钮时都会来调用此代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    
    NSString *passWord = [alertView textFieldAtIndex:0].text;
    if (passWord == nil) {
        NSLog(@"密码不能为空");
        return;
    }
    if ([[passWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        NSLog (@"密码不能为空格");
        return;
    }
    if ([passWord lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 18) {
        NSLog(@"密码不能超过18个字母");
        return;
    }
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:passWord forKey:User_Secret];
    [ud setObject:@"2" forKey:User_Encrypt];
    [ud synchronize];
    
        UPUrlSubCategoryModel * model = self.datas[encryptPath.row];
        model.encrypt = 1;
        [SqliteTool removeHistory:model];
        [SqliteTool addHistory:model];
        [self.datas removeObjectAtIndex:encryptPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[encryptPath] withRowAnimation:UITableViewRowAnimationNone];

}
@end
