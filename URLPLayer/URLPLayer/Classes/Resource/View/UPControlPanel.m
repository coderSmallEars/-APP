//
//  UPControlPanel.m
//  URLPLayer
//
//  Created by King on 16/6/5.
//  Copyright © 2016年 Player. All rights reserved.
//
#define bottomPanelHeight 44
#import "UPControlPanel.h"

@interface UPControlPanel()

@property (nonatomic, strong) UIButton                *playButton;
@property (nonatomic, strong) UILabel                 *currentTimeLabel;
@property (nonatomic, strong) UILabel                 *totalDurationLabel;
@property (nonatomic, strong) UISlider                *playerProgressSlider;
@property (nonatomic, strong) UIActivityIndicatorView *indicateView;
@property (nonatomic, assign) BOOL                    isPlayerSliderBeginDragged;
@end

@implementation UPControlPanel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.bottomPanel];
        [self addSubview:self.indicateView];
        WS(weakSelf)
        [self.bottomPanel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf);
            make.height.mas_equalTo(bottomPanelHeight);
        }];
        [self.indicateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            make.width.and.height.mas_equalTo(bottomPanelHeight* 2 );
        }];
    }
    return self;
}

#pragma mark -Public Method
- (void)showNoFade{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomPanel.alpha = 1;
    }];
    [self cancelDelayHide];
    [self refreshPlayerControl];
}

- (void)showAndFade{
    [self showNoFade];
    [self performSelector:@selector(hide) withObject:nil afterDelay:5];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomPanel.alpha = 0;
    }];
    [self cancelDelayHide];
}

- (void)play{
    [self.delegatePlayer play];
}

- (void)pause{
    [self.delegatePlayer pause];
}
#pragma mark - Private Method
- (void)cancelDelayHide{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
}

- (void)beginDragPlayerSlider{
    [self.delegatePlayer pause];
    self.isPlayerSliderBeginDragged = YES;
}

- (void)endDragPlayerSlider{
    [self.delegatePlayer play];
    self.isPlayerSliderBeginDragged = NO;
}

- (void)continueDragPlayerSlider{
    [self refreshPlayerControl];
}

- (void)changePlayStatus:(UIButton *)button{
    if (button.isSelected && self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePaused) {
        [self play];
    }else{
        [self pause];
    }
}

- (void)timeIntervalValueChanged:(UISlider *)slider{
    [self beginDragPlayerSlider];
    NSLog(@"value change %f",slider.value);
}

- (void)timeIntervalValueChangEnd:(UISlider *)slider{
    [self endDragPlayerSlider];
    NSTimeInterval duration = self.delegatePlayer.duration;
    if (duration + 0.5 > 1 && slider.value <= duration + 0.5) {
        self.delegatePlayer.currentPlaybackTime = slider.value;
    }
    NSLog(@"touch up inside");
}

- (void)refreshPlayerControl{
//    duration
    NSTimeInterval duration = self.delegatePlayer.duration;
    NSInteger intDuration   = duration + 0.5;
    if (intDuration > 0) {
        self.playerProgressSlider.maximumValue = duration;
        self.totalDurationLabel.text           = [NSString stringWithFormat:@"%02d:%02d",(int)intDuration/60,(int)intDuration % 60];
    }else{
        self.totalDurationLabel.text           = @"--:--";
        self.playerProgressSlider.maximumValue = 1;
    }
//    position
    NSTimeInterval position;
    if (_isPlayerSliderBeginDragged) {
        position = self.playerProgressSlider.value;
    }else{
        position = self.delegatePlayer.currentPlaybackTime;
        NSLog(@"%ld",self.delegatePlayer.bufferingProgress);
    }
    NSInteger intPosition = position + 0.5;
    if (intDuration > 0) {
        self.playerProgressSlider.value = position;
    }else{
        self.playerProgressSlider.value = 0.f;
    }

    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];

//    status
    BOOL isPlaying             = self.delegatePlayer.isPlaying;
    self.playButton.selected   = !isPlaying;

    if (isPlaying && self.indicateView.isAnimating) {
        [self.indicateView stopAnimating];
    }else if(self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePaused && !self.indicateView.isAnimating){
        [self.indicateView startAnimating];
    }


    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshPlayerControl) object:nil];
    if (!self.hidden) {
        [self performSelector:@selector(refreshPlayerControl) withObject:nil afterDelay:0.5];
    }
}

- (UIView *)bottomPanel{
    if (!_bottomPanel) {
        _bottomPanel = [UIView new];
        _bottomPanel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        [self.bottomPanel addSubview:self.playButton];
        [self.bottomPanel addSubview:self.playerProgressSlider];
        [self.bottomPanel addSubview:self.currentTimeLabel];
        [self.bottomPanel addSubview:self.totalDurationLabel];
        
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(_bottomPanel);
            make.width.mas_equalTo(bottomPanelHeight);
        }];
        
        [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_playButton.mas_right).offset(10);
            make.top.bottom.equalTo(_bottomPanel);
            make.width.mas_equalTo(50);
        }];
        
        [self.playerProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_bottomPanel);
            make.left.equalTo(_currentTimeLabel.mas_right).offset(10);
            make.right.equalTo(_totalDurationLabel.mas_left).offset(-10);
        }];
        
        [self.totalDurationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_bottomPanel);
            make.left.equalTo(_playerProgressSlider.mas_right).offset(10);
            make.right.equalTo(_bottomPanel).offset(-10);
            make.width.equalTo(_currentTimeLabel);
        }];
    }
    return _bottomPanel;
}


- (UIButton *)playButton{
    if (!_playButton) {
    _playButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.frame = CGRectMake(0,0, 70,44);
        [_playButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_playButton setTitle:@"播放" forState:UIControlStateSelected];
        [_playButton setBackgroundColor:[UIColor clearColor]];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(changePlayStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UILabel *)currentTimeLabel{
    if (!_currentTimeLabel) {
    _currentTimeLabel             = [UILabel new];
    _currentTimeLabel.textColor   = [UIColor whiteColor];
        [_currentTimeLabel setAdjustsFontSizeToFitWidth:YES];
    _currentTimeLabel.text        = @"cTime;";
    }
    return _currentTimeLabel;
}

- (UISlider *)playerProgressSlider{
    if (!_playerProgressSlider) {
    _playerProgressSlider = [UISlider new];
    UIImage *sliderImg    = [self getImageWithColor:[UIColor grayColor] width:15 height:9];
        [_playerProgressSlider setThumbImage:sliderImg forState:UIControlStateNormal];
        [_playerProgressSlider addTarget:self action:@selector(timeIntervalValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_playerProgressSlider addTarget:self action:@selector(timeIntervalValueChangEnd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerProgressSlider;
}

- (UILabel *)totalDurationLabel{
    if (!_totalDurationLabel) {
    _totalDurationLabel           = [UILabel new];
    _totalDurationLabel.textColor = [UIColor whiteColor];
        [_totalDurationLabel setAdjustsFontSizeToFitWidth:YES];
    _totalDurationLabel.text      = @"aTime";
    }
    return _totalDurationLabel;
}

- (UIActivityIndicatorView *)indicateView{
    if (!_indicateView) {
    _indicateView                 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _indicateView;
}
//纯色image
- (UIImage *)getImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height{
    CGRect imageRect   = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(imageRect.size);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), imageRect);
    UIImage *sliderImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return sliderImg;
}

@end
