//
//  UPControlPanel.h
//  URLPLayer
//
//  Created by King on 16/6/5.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IJKMediaPlayback;

@interface UPControlPanel : UIControl

@property (nonatomic, copy)UPGeneralBlock playButtonCLick;

- (void)showNoFade;
- (void)showAndFade;
- (void)hide;
- (void)refreshPlayerControl;

- (void)beginDragPlayerSlider;
- (void)endDragPlayerSlider;
- (void)continueDragPlayerSlider;

- (void)play;
- (void)pause;

@property (nonatomic, weak) IJKFFMoviePlayerController<IJKMediaPlayback> *delegatePlayer;
@property (nonatomic, strong) UIView *bottomPanel;

@end
