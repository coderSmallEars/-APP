//
//  UPDrawerController.m
//  URLPLayer
//
//  Created by jinyulong on 16/6/12.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDrawerController.h"

@implementation UPDrawerController

- (UINavigationController *)currentCenterController{
    UITabBarController *tabbar = (UITabBarController *)self.centerViewController;
    return  tabbar.selectedViewController;
}

- (BOOL)shouldAutorotate{
    return [[self currentCenterController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self currentCenterController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self currentCenterController] preferredInterfaceOrientationForPresentation];
}
@end
