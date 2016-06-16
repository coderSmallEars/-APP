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

@interface UPDrawerViewController ()<UIAlertViewDelegate>

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
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        
        if([ud objectForKey:User_Encrypt] == nil ){
        //未设置加密密码
            //未设置密码
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" ,nil];
            alertView.tag = 10086;
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"请输入密码";
            [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeEmailAddress;
            [alertView show];

        }else if ( [[ud objectForKey:User_Encrypt] isEqualToString:@"2"]){
        //未加密 --- >切换为加密
            [ud setObject:@"1" forKey:User_Encrypt];
            [ud synchronize];
            UPTabBarController* tabBar =  app.mmDrawer.centerViewController.childViewControllers[0];
            UPLocalViewController * localC =   tabBar.viewControllers[0];
            [localC changeLocalVideos];
        
        }else{
        //加密 -- >切换为不加密
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" ,nil];
            alertView.tag = 10087;
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"请输入密码";
            [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeEmailAddress;
            [alertView show];
        }
       
      [app.mmDrawer closeDrawerAnimated:YES completion:^(BOOL finished) {
          
      }];
        
    }
    if ([type isEqualToString:@"清除缓存"]) {
        
    }

}
#pragma mark UIAlertView的代理方法 点击了提醒框上面的按钮时都会来调用此代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *passWord = [alertView textFieldAtIndex:0].text;
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (alertView.tag == 10086) {
        
    if (buttonIndex == 0) {
        return;
    }
    
    if (passWord == nil) {
        NSLog(@"密码不能为空");
        return;
    }
    if ([[passWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        NSLog (@"密码不能为空格");
        return;
    }
    if ([passWord lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 18) {
        NSLog(@"密码不能超过18个字母");
        return;
    }
    
    [ud setObject:passWord forKey:User_Secret];
    [ud synchronize];
    }
    else{
        if ([passWord isEqualToString:[ud objectForKey:User_Secret]]) {
            [ud setObject:@"2" forKey:User_Encrypt];
            [ud synchronize];
        }else{
        
            return;
        }
    
    }
     AppDelegate * app  =  [UIApplication sharedApplication].delegate;
    UPTabBarController* tabBar =  app.mmDrawer.centerViewController.childViewControllers[0];
    UPLocalViewController * localC =   tabBar.viewControllers[0];
    [localC changeLocalVideos];
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
