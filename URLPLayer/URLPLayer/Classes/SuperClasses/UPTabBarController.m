//
//  UPTabBarController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPTabBarController.h"

@interface UPTabBarController ()

@end

@implementation UPTabBarController

- (void)loadView{
    [super loadView];
    
    UPLocalViewController *localVC = [UPLocalViewController new];
    UPNavigationController *localNavi = [[UPNavigationController alloc] initWithRootViewController:localVC];
    [localNavi setNavigationBarHidden:YES];
    UITabBarItem *localItem = [[UITabBarItem alloc] initWithTitle:@"历史" image:nil selectedImage:nil];
    localNavi.tabBarItem = localItem;
    
    UPResourceViewController *resourceVC = [UPResourceViewController new];
    UPNavigationController *resourceNavi = [[UPNavigationController alloc] initWithRootViewController:resourceVC];
    UITabBarItem *resourceItem = [[UITabBarItem alloc] initWithTitle:@"资源" image:nil tag:1];
    resourceNavi.tabBarItem = resourceItem;
    
    UPIndivividualViewController *individualVC = [UPIndivividualViewController new];
    UPNavigationController *individualNavi = [[UPNavigationController alloc] initWithRootViewController:individualVC];
    [individualNavi setNavigationBarHidden:YES];
    UITabBarItem *individualItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil selectedImage:nil];
    individualNavi.tabBarItem = individualItem;
    
    
    self.viewControllers = @[localNavi, resourceNavi, individualNavi];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exchageColorOfTabBar:)
                                                 name:@"exchagecolor" object:nil];
    
    
}

-(void)exchageColorOfTabBar:(NSNotification *)info
{
    NSLog(@"----%@",self.tabBar.subviews);
    
    UIColor * color = [info.userInfo objectForKey:@"color"];
    
    self.tabBar.backgroundImage = [UIImage imageWithColor:color];
    
    self.tabBar.opaque = YES;

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"exchagecolor" object:nil];
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
