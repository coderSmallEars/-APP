//
//  UPResourceViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPResourceViewController.h"

@interface UPResourceViewController ()

@end

@implementation UPResourceViewController
-(void)loadView{
    [super loadView];
    _resourceView = [[UPResourceView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _resourceView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _resourceView.delegate = self;
    [_resourceView updateCycleScrollViewImages:nil titles:nil];
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
