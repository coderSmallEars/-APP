//
//  UPViewController.m
//  URLPlayer
//
//  Created by King on 16/5/22.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPViewController.h"

@implementation UPViewController

- (instancetype)init{
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)uiview:(UIView*)view collectionEventType:(id)type params:(id)params{
   
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
