//
//  UPindivividualTableView.m
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPIndivividualTableView.h"

@interface UPIndivividualTableView ()
{
    /**
     键盘高度
     */
    CGFloat kbEndHeight;

}
@end

@implementation UPIndivividualTableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = [UIColor colorWithHexString:@"f5f5f5"];
        
        self.datas =[NSMutableArray arrayWithArray:@[@"下载管理",@"公众号",@"联系我们"]];
        /**
         监听键盘的弹出，把输入工具条往上移
         */
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        /**
         监听键盘的隐藏，把输入工具条往下移
         */
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"000000"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [self uiview:nil collectionEventType:cell.textLabel.text params:nil];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 350.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * backView = [[UIView alloc]init];
    UILabel *noticeLab = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 10.f, kScreenWidth - 20.f, 60.f)];
    [backView addSubview:noticeLab];
    noticeLab.numberOfLines = 0;
    noticeLab.text = @"您的建议内容,将会显示在我们的公众微信号上,对我们有利建议的用户有奖励哦!";
    noticeLab.font = [UIFont systemFontOfSize:13.0];
    noticeLab.textColor = [UIColor colorWithHexString:@"000000"];
    UIImageView * inputBackView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_Input-panel"]];
    inputBackView.userInteractionEnabled = YES;
    inputBackView.frame = CGRectMake(5.f, noticeLab.bottom, kScreenWidth - 10.f, 200.f);
    [backView addSubview:inputBackView];
    self.inputTextView  = [[UITextView alloc]initWithFrame:CGRectMake(5.f, 5.f, inputBackView.width - 10.f, 190.f)];
    [inputBackView addSubview:self.inputTextView];
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitle:@"吐槽" forState:UIControlStateNormal];
    self.commitBtn.layer.cornerRadius = 4.0;
    self.commitBtn.clipsToBounds = YES;
    self.commitBtn.bounds = CGRectMake(0, 0, 60.f, 30.f);
    self.commitBtn.centerX = kScreenWidth/2.0;
    self.commitBtn.top = inputBackView.bottom + 20.f;
    [backView addSubview:self.commitBtn];
    self.commitBtn.backgroundColor  = [UIColor whiteColor];
    [self.commitBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_commitBtn addTarget:self action:@selector(clickToCommit) forControlEvents:UIControlEventTouchUpInside];
    backView.bounds = CGRectMake(0, 0, kScreenWidth, self.commitBtn.bottom + 30.f);
    
    return backView;
}
-(void)clickToCommit{
    if ([self.inputTextView.text isEqualToString:@""]) {
        
    }else{
    [self uiview:nil collectionEventType:@"吐槽" params:self.inputTextView.text];
    }

    [self.inputTextView resignFirstResponder];
}
#pragma mark--- 键盘显示时会触发的方法
-(void)keyBoardWillShow:(NSNotification*)notif{
    
    //1.获取键盘的高度
    // 1)获取键盘活动结束时的位置
    CGRect kbEndFrame=  [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbEndHeight = kbEndFrame.size.height;
    self.top = self.top - kbEndHeight + kTabbarHeight;
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        
    }];
}
#pragma mark--- 键盘隐藏时会触发的方法
-(void)keyBoardWillHidden:(NSNotification*)notif{
    //1.inputView恢复原位
    self.top = self.top + kbEndHeight - kTabbarHeight;
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.inputTextView resignFirstResponder];
}
@end
