//
//  UPPlayerView.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPPlayerView.h"

static inline NSURL *URLNotNull(NSURL *url){
    if (url == nil || [url isKindOfClass:[NSNull class]]) {
        NSLog(@"++++++++++++++++++++++++++++++++++URL ERROR");
        return [NSURL URLWithString:@""];
    }else{
        return url;
    }
}


@interface UPPlayerView ()

@end

@implementation UPPlayerView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
         [self addSubview:self.player.view];
    }

    return self;
}

#pragma mark - LIFE CYCLE
- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}




#pragma mark - NOTIFICATION
- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:self.player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStateDidChange:) name:IJKMoviePlayerLoadStateDidChangeNotification object:self.player];
    
}

- (void)removeNotifications{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark- RESPONSE
- (void)onClickMediaControl:(UIGestureRecognizer *)GR{
    _player.shouldShowHudView = !_player.shouldShowHudView;
}

- (void)changePlayStatus:(UIButton *)button{
    if (button.isSelected && self.player.playbackState == IJKMPMoviePlaybackStatePaused) {
        [self.player play];
    }else{
        [self.player pause];
    }
    button.selected = !button.isSelected;
}
#pragma MARK - NOTIFICATION RESPONSE

- (void)loadStateDidChange:(NSNotification*)notification{
    IJKMPMovieLoadState loadState = self.player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)playStateDidChange:(NSNotification *)notification{
    switch (self.player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"-------------------------------------------IJKMPMoviePlayBackStateDidChange %ld: stoped", self.player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"-------------------------------------------IJKMPMoviePlayBackStateDidChange %ld: playing", self.player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"-------------------------------------------IJKMPMoviePlayBackStateDidChange %ld: paused", self.player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %ld: interrupted", self.player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"-------------------------------------------JKMPMoviePlayBackStateDidChange %ld: seeking", self.player.playbackState);
            break;
        }
        default: {
            NSLog(@"-------------------------------------------IJKMPMoviePlayBackStateDidChange %ld: unknown", self.player.playbackState);
            break;
        }
    }
}

#pragma mark - SETTER AND GETTER
- (IJKFFMoviePlayerController *)player{
    if (!_player) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:URLNotNull(self.url) withOptions:options];
        _player.view.frame = self.bounds;
        _player.scalingMode = IJKMPMovieScalingModeAspectFit;
        _player.shouldAutoplay = YES;
        _player.shouldShowHudView = NO;
        UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMediaControl:)];
        [_player.view addGestureRecognizer:mainTap];
    }
    return _player;
}



- (void)viewDidLayoutSubviews{
    _player.view.frame = self.bounds;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        
        
        
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }else{
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}



@end
