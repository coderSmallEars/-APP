//
//  AppDelegate.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "AppDelegate.h"
#import "UIView+Util.h"
#import "UPDrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bmob registerWithAppKey:@"60b8b8347c38fff0515c5b4c988da4b1"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UPTabBarController *tabbar = [[UPTabBarController alloc] init];
    
    UPDrawerViewController *drawerVC = [UPDrawerViewController new];
    
    UPNavigationController *drawerNC = [[UPNavigationController alloc] initWithRootViewController:drawerVC];
    
    self.mmDrawer = [[UPDrawerController alloc] initWithCenterViewController:tabbar leftDrawerViewController:drawerNC];
    
    self.mmDrawer.maximumLeftDrawerWidth = kUPScreenWidth * (1-0.618);
    
    self.mmDrawer.openDrawerGestureModeMask = MMOpenDrawerGestureModeBezelPanningCenterView;
    
    self.mmDrawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    self.window.rootViewController = self.mmDrawer;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exchageColorOfDeleagte:)
                                                 name:@"exchagecolor" object:nil];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"exchagecolor" object:nil];
}



#pragma mark - 主题色外观控制
-(void)exchageColorOfDeleagte:(NSNotification *)info
{
    
    UIColor * color = [info.userInfo objectForKey:@"color"];
    /************ 控件外观设置 **************/
    [[UIApplication sharedApplication] keyWindow].tintColor = color;
    
    //再plist文件中设置View controller-based status bar appearance 为 NO才能起效
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //导航条上标题的颜色
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:color};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    //导航条上UIBarButtonItem颜色
    [[UINavigationBar appearance] setTintColor:color];
    
    //TabBar选中图标的颜色,默认是蓝色
    [[UITabBar appearance] setTintColor:color];
    //TabBarItem选中的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
    
    //导航条的背景颜色
    [[UINavigationBar appearance] setBarTintColor:color];
    
    //TabBar的背景颜色
    [[UITabBar appearance] setBarTintColor:color];
    
    NSLog(@"%@",[UITabBar appearance].subviews[0]);
    
    [UISearchBar appearance].tintColor =color;
    //当某个class被包含在另外一个class内时，才修改外观。
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setCornerRadius:14.0];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAlpha:0.6];
    
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = color;
    pageControl.currentPageIndicatorTintColor = color;
    
    [[UITextField appearance] setTintColor:color];
    [[UITextView appearance]  setTintColor:color];
    

    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    [menuController setMenuVisible:YES animated:YES];
    [menuController setMenuItems:@[
                                   [[UIMenuItem alloc] initWithTitle:@"复制" action:NSSelectorFromString(@"copyText:")],
                                   [[UIMenuItem alloc] initWithTitle:@"删除" action:NSSelectorFromString(@"deleteObject:")]
                                   ]];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DownloadTool sharedInstance] exitApp];
}

@end
