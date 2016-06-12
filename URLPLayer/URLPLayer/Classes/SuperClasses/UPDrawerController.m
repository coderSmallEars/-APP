//
//  UPDrawerController.m
//  URLPLayer
//
//  Created by jinyulong on 16/6/12.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDrawerController.h"

@implementation UPDrawerController

- (BOOL)shouldAutorotate{
    UITabBarController *tabbar = (UITabBarController *)self.centerViewController;
    UINavigationController *navi = tabbar.selectedViewController;
    return navi.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UITabBarController *tabbar = (UITabBarController *)self.centerViewController;
    UINavigationController *navi = tabbar.selectedViewController;
    return navi.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    UITabBarController *tabbar = (UITabBarController *)self.centerViewController;
    UINavigationController *navi = tabbar.selectedViewController;
    return navi.preferredInterfaceOrientationForPresentation;
}


@end
