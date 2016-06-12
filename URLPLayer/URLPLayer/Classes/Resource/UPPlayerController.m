//
//  UPPlayerController.m
//  URLPLayer
//
//  Created by jinyulong on 16/6/5.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPPlayerController.h"
#import "UPControlPanel.h"

#define playerHeight (kUPScreenWidth *9.f / 16.f)
#define playerRect CGRectMake(0, 0, kUPScreenWidth, playerHeight)
@interface UPPlayerController()

@property (atomic, strong)IJKFFMoviePlayerController *player;
@property (nonatomic, strong)UPControlPanel *panel;
@property (nonatomic, strong)NSURL *url;
@end
@implementation UPPlayerController
#pragma mark - LIFE CYCLE
- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.url = url;
        NSLog(@"url ----------------- %@",url);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.player prepareToPlay];
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.player.playbackState == IJKMPMoviePlaybackStatePaused) {
        [self.player play];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player pause];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [IJKFFMoviePlayerController setLogReport:NO];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
    
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    [self addNotifications];
    [self initPlayer];
    [self.view addSubview:self.panel];
}

- (void)dealloc{
    [self removeNotifications];
}
#pragma mark - Private Method
- (void)initPlayer{
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:[IJKFFOptions optionsByDefault]];
    self.player.view.backgroundColor = [UIColor blackColor];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = playerRect;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
    UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMediaControl:)];
    [self.player.view addGestureRecognizer:mainTap];
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _player.view.frame = playerRect;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

#pragma mark - SETTER AND GETTER
- (UPControlPanel *)panel{
    if (!_panel) {
        _panel = [[UPControlPanel alloc] initWithFrame:CGRectMake(0,playerHeight, kUPScreenWidth, 44)];
        __weak typeof(self)weakSelf = self;
        _panel.playButtonCLick = ^(UIButton *button){
            [weakSelf changePlayStatus:button];
        };
    }
    return _panel;
}

@end
