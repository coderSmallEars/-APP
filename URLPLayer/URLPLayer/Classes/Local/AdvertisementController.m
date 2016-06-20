//
//  AdvertisementController.m
//  URLPLayer
//
//  Created by wubing on 16/6/1.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "AdvertisementController.h"
#import "AdvertisementView.h"
@interface AdvertisementController ()
@property (nonatomic, strong)AdvertisementView * advertisementView;
@end

@implementation AdvertisementController

-(void)loadView{
    [super loadView];
    
    self.view = self.advertisementView;
    self.advertisementView.delegate  =self;
    
}
-(AdvertisementView *)advertisementView{
    if (_advertisementView == nil) {
        _advertisementView  = [[AdvertisementView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _advertisementView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.title;
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    if ([type isEqualToString:@"navbar_backarrow_icon"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)setModel:(ScorllModel *)model{
    _model = model;
    self.advertisementView.model = _model;
    
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
