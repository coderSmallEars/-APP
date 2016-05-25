//
//  UPLocalViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPLocalViewController.h"

@interface UPLocalViewController ()

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
        
    }
    if ([type isEqualToString:@"点击历史观看cell"]) {
        
    }
    //搜索
    if ([type isEqualToString:@"navbar_search_icon-"]) {
        
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
