//
//  UPLocalViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPLocalViewController.h"
#import "UPSearchUrlPlayVC.h"

@interface UPLocalViewController ()<UIAlertViewDelegate>

@end

@implementation UPLocalViewController
-(void)loadView{
    [super loadView];
    _localView = [[UPLocalView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _localView;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.localView.delegate = self;
    [_localView updateCycleScrollViewImages:nil titles:nil];
    [_localView updateHistoryWatchTableView:@[@"",@"",@"",@""]];
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    if ([type isEqualToString:@"点击删除按钮"]) {
        //清空,先看数据库有内容否
        if (YES) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"是否全部清空?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }
    if ([type isEqualToString:@"点击历史观看cell"]) {
        
    }
    //搜索
    if ([type isEqualToString:@"navbar_search_icon-"]) {
        
        UPSearchUrlPlayVC * searchUrlPlay = [UPSearchUrlPlayVC new];
        
        [self presentViewController:searchUrlPlay animated:YES completion:^{
            
        }];
        
        
    }
    
    if ([type isEqualToString:@"点击了轮播图"]) {
        
    }
    if ([type isEqualToString:@"搜索本地视频"]) {
        
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        return;
        
    }else{
     //清空数据库数据
     [_localView updateHistoryWatchTableView:nil];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
