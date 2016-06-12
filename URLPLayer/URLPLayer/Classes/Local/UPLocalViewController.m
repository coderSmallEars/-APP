//
//  UPLocalViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPLocalViewController.h"
#import "UPSearchUrlPlayVC.h"
#import "AdvertisementController.h"
#import "SqliteTool.h"
#import "ScorllModel.h"
#import "UPPlayerController.h"
#import "UPUrlSubCategoryModel.h"
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
    
    //查找轮播图表
    [UPBmobManager loadScrollPicList:^(NSArray *resultArray) {
        [_localView updateCycleScrollView:resultArray];
    }];
    

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableArray * historyArr = [SqliteTool getAllHistoryModels];
    [_localView updateHistoryWatchTableView:historyArr];


}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    if ([type isEqualToString:@"点击删除按钮"]) {
        //清空,先看数据库有内容否
         NSMutableArray * historyArr = [SqliteTool getAllHistoryModels];
        if (historyArr.count > 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"是否全部清空?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }
    if ([type isEqualToString:@"点击历史观看cell"]) {
        UPUrlSubCategoryModel * model = params;
        UPPlayerController *playerCtrl = [[UPPlayerController alloc] initWithURL:[NSURL URLWithString:model.video_url]];
        playerCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:playerCtrl animated:YES];
    }
    //搜索
    if ([type isEqualToString:@"navbar_search_icon-"]) {
        
        UPSearchUrlPlayVC * searchUrlPlay = [UPSearchUrlPlayVC new];
        
        [self presentViewController:searchUrlPlay animated:YES completion:^{
            
        }];
        
        
    }
    
    if ([type isEqualToString:@"点击了轮播图"]) {

        AdvertisementController * advertisementVC = [[AdvertisementController alloc]init];
        advertisementVC.hidesBottomBarWhenPushed = YES;
        advertisementVC.model = params;
        [self.navigationController pushViewController:advertisementVC animated:YES];
    }
    if ([type isEqualToString:@"搜索本地视频"]) {
        
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        return;
        
    }else{
     //清空数据库数据
        [SqliteTool deleteAllHistoryModel];
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
