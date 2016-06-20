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
    
    self.title = @"历史";
    [self addBarButtonItems];
    //查找轮播图表
    [UPBmobSingetonManager loadScrollPicList:^(NSArray *resultArray) {
        [_localView updateCycleScrollView:resultArray];
    }];

    
}
-(void)addBarButtonItems{
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteImg = [UIImage imageNamed:@"navbar_delete_icon"];
    deleteBtn.bounds = CGRectMake(0, 0, deleteImg.size.width +20.f, deleteImg.size.height +20.f);
    [deleteBtn setImage:deleteImg forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBI1 = [[UIBarButtonItem alloc]initWithCustomView:deleteBtn];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *searchImg = [UIImage imageNamed:@"navbar_search_icon-"];
    [searchBtn setImage:searchImg forState:UIControlStateNormal];
    searchBtn.bounds = CGRectMake(0, 0, searchImg.size.width + 20.f, searchImg.size.height + 20.f);
    [searchBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBI2 = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItems = @[rightBI2,rightBI1];

}
-(void)changeLocalVideos{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Encrypt] == nil || [[[NSUserDefaults standardUserDefaults] objectForKey:User_Encrypt] isEqualToString:@"0"]){
        //未加密
        NSMutableArray * historyArr = [SqliteTool getAllNotEncryptHistoryModels];
        [_localView updateHistoryWatchTableView:historyArr];
    }else{
        //加密
        NSMutableArray * historyArr = [SqliteTool getAllEncryptHistoryModels];
        [_localView updateHistoryWatchTableView:historyArr];
        
    }

}
-(void)clickDeleteBtn{
    //清空,先看数据库有内容否
    NSMutableArray * historyArr = [SqliteTool getAllHistoryModels];
    if (historyArr.count > 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"是否全部清空?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }



}
-(void)clickSearchBtn{

    UPSearchUrlPlayVC * searchUrlPlay = [UPSearchUrlPlayVC new];
    
    [self presentViewController:searchUrlPlay animated:YES completion:^{
        
    }];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeLocalVideos];
   }
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    
    if ([type isEqualToString:@"点击历史观看cell"]) {
        UPUrlSubCategoryModel * model = params;
        UPPlayerController *playerCtrl = [[UPPlayerController alloc] initWithURL:[NSURL URLWithString:model.video_url]];
        playerCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:playerCtrl animated:YES];
    }
   
    
    if ([type isEqualToString:@"点击了轮播图"]) {

        AdvertisementController * advertisementVC = [[AdvertisementController alloc]init];
        advertisementVC.hidesBottomBarWhenPushed = YES;
        advertisementVC.model = params;
        [self.navigationController pushViewController:advertisementVC animated:YES];
    }
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        return;
        
    }else{
     //清空数据库数据
        if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Encrypt] == nil || [[[NSUserDefaults standardUserDefaults] objectForKey:User_Encrypt] isEqualToString:@"0"]){
        //未加密列表
            [SqliteTool deleteAllNotEncryptHistoryModel];
        }
        else{
            //加密列表
        [SqliteTool deleteAllEncryptHistoryModel];
        }
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
