//
//  BMPlayer.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "BMPlayer.h"
#import "BMplayerView.h"

@interface BMPlayer ()
@property (nonatomic , strong) BMplayerView * playerView;

@end

@implementation BMPlayer


-(void)loadView
{
    self.view = self.playerView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
#ifdef DEBUG
    [IJKFFMoviePlayerController setLogReport:NO];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_DEBUG];
#else
    [IJKFFMoviePlayerController setLogReport:NO];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
#endif
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    
    self.view.autoresizesSubviews = YES;
   
   
}


#pragma mark - 懒加载
-(BMplayerView *)playerView
{
    if (!_playerView) {
        
        _playerView  = [BMplayerView new];
        
        _playerView.frame =[UIScreen mainScreen].bounds;
    }
    return _playerView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.playerView addNotifications];
    [self.playerView.player prepareToPlay];
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.playerView.player.playbackState == IJKMPMoviePlaybackStatePaused) {
        [self.playerView.player play];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playerView.player pause];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.playerView.player shutdown];
    [self.playerView removeNotifications];
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
