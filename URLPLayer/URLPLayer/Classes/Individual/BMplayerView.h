//
//  BMplayerView.h
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface BMplayerView : UPView


@property (nonatomic, strong)NSURL *url;
@property (nonatomic, strong)IJKFFMoviePlayerController *player;

- (instancetype)initWithURL:(NSURL *)url;
- (void)playStateDidChange:(NSNotification *)notification;
- (void)loadStateDidChange:(NSNotification*)notification;
- (void)removeNotifications;
- (void)addNotifications;
@end
