
//
//  UPIndivividualViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPIndivividualViewController.h"
#import "SearchUrlPlayVC.h"
#import "DownLoadVC.h"
@interface UPIndivividualViewController ()

@end

@implementation UPIndivividualViewController

-(void)loadView{
    [super loadView];
    _indivividualView = [[UPIndivividualView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _indivividualView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indivividualView.delegate  = self;
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    if ([type isEqualToString:@"吐槽"]) {
        
    }
    if ([type isEqualToString:@"下载管理"]) {
        
        DownLoadVC * downLoadVC = [DownLoadVC new];
        downLoadVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:downLoadVC animated:YES];
    }
    if ([type isEqualToString:@"公众号"]) {
        
    }
    if ([type isEqualToString:@"联系我们"]){
    
    }
    //搜索按钮
    if ([type isEqualToString:@"navbar_search_icon-"]) {
        
        SearchUrlPlayVC * searchUrlPlay = [SearchUrlPlayVC new];
        
        [self presentViewController:searchUrlPlay animated:YES completion:^{
            
        }];
        
        
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
