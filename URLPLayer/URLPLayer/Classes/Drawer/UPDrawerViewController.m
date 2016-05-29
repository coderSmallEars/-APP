//
//  UPDrawerViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDrawerViewController.h"
#import "AppDelegate.h"

#define color [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface UPDrawerViewController ()

@end

@implementation UPDrawerViewController

-(void)loadView{
   
    [super loadView];
    _drawerView = [[UPDrawerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _drawerView;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    _drawerView.delegate = self;
}
-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    
     AppDelegate * app  =  [UIApplication sharedApplication].delegate;
    
    if ([type isEqualToString:@"切换主题色"]) {
        
        [self postNotification];
        
        [app.mmDrawer closeDrawerAnimated:YES completion:^(BOOL finished) {
            
        }];
        
        

    }
    if ([type isEqualToString:@"加密模式"]) {
        
      [app.mmDrawer closeDrawerAnimated:YES completion:^(BOOL finished) {
          
      }];
        
    }
    if ([type isEqualToString:@"清除缓存"]) {
        
    }

}

#pragma mark - 发出通知改变颜色
-(void)postNotification
{
    NSNotificationCenter * not = [NSNotificationCenter defaultCenter];
    
    [not postNotificationName:@"exchagecolor" object:nil userInfo:@{@"color":color}];
    

    
    
 //[StoreSetting setUserInfoDic:@{@"loadcolor":[]}];
    
    
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
