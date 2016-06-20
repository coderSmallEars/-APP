//
//  DownLoadVC.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDownLoadVC.h"
#import "UPDownLoadView.h"

@interface UPDownLoadVC ()


@property (nonatomic , strong) UPDownLoadView * downLoadView;
@end

@implementation UPDownLoadVC

-(void)loadView
{
    self.view = self.downLoadView;
   
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"下载管理";
    _downLoadView.delegate = self;
    
    
    
    // Do any additional setup after loading the view.
}

-(UPDownLoadView *)downLoadView
{
    if (!_downLoadView) {
        
        _downLoadView = [[UPDownLoadView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return  _downLoadView;
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    

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
