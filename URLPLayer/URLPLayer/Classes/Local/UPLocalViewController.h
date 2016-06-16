//
//  UPLocalViewController.h
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPViewController.h"
#import "UPLocalView.h"
@interface UPLocalViewController : UPViewController
@property (nonatomic, strong)UPLocalView * localView;

-(void)changeLocalVideos;
@end
