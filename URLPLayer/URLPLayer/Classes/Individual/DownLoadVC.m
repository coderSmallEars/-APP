//
//  DownLoadVC.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "DownLoadVC.h"
#import "DownLoadView.h"

@interface DownLoadVC ()


@property (nonatomic , strong) DownLoadView * downLoadView;
@end

@implementation DownLoadVC

-(void)loadView
{
    self.view = self.downLoadView;
   
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _downLoadView.delegate = self;
    
    
    
    // Do any additional setup after loading the view.
}

-(DownLoadView *)downLoadView
{
    if (!_downLoadView) {
        
        _downLoadView = [[DownLoadView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return  _downLoadView;
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    if ([type isEqualToString:@"navbar_backarrow_icon"]) {
        [self.navigationController popViewControllerAnimated:YES];
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
