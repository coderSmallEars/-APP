
//
//  UPIndivividualViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPIndivividualViewController.h"
#import "UPSearchUrlPlayVC.h"
#import "UPDownLoadVC.h"
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
    self.title = @"吐槽";
    [self addBarButtonItems];
    _indivividualView.delegate  = self;
}
-(void)addBarButtonItems{

    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *searchImg = [UIImage imageNamed:@"navbar_search_icon-"];
    [searchBtn setImage:searchImg forState:UIControlStateNormal];
    searchBtn.bounds = CGRectMake(0, 0, searchImg.size.width + 20.f, searchImg.size.height + 20.f);
    [searchBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBI = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightBI;

}
-(void)clickSearchBtn{
    
    UPSearchUrlPlayVC * searchUrlPlay = [UPSearchUrlPlayVC new];
    
    [self presentViewController:searchUrlPlay animated:YES completion:^{
        
    }];
    
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    if ([type isEqualToString:@"吐槽"]) {
        
        //往urlPlay_feedback表添加一条吐槽数据
        BmobObject *gameScore = [BmobObject objectWithClassName:@"urlPlay_feedback"];
        [gameScore setObject:[params objectForKey:@"content"] forKey:@"content"];
        [gameScore setObject:[params objectForKey:@"contactWay"] forKey:@"contact_way"];
        [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
        [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            //进行操作
            if(!error){
            //评论成功
                [_indivividualView clearFeedbackContent];
            }else{
                NSLog(@"评论失败");
            }
                
        }];
    }
    if ([type isEqualToString:@"下载管理"]) {
        
        UPDownLoadVC * downLoadVC = [UPDownLoadVC new];
        downLoadVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:downLoadVC animated:YES];
    }
    if ([type isEqualToString:@"公众号"]) {
        
    }
    if ([type isEqualToString:@"联系我们"]){
    
    }
    //搜索按钮
    if ([type isEqualToString:@"navbar_search_icon-"]) {
        
        UPSearchUrlPlayVC * searchUrlPlay = [UPSearchUrlPlayVC new];
        
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
