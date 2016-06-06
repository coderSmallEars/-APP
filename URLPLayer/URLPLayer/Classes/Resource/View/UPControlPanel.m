//
//  UPControlPanel.m
//  URLPLayer
//
//  Created by King on 16/6/5.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPControlPanel.h"

@interface UPControlPanel()

@property (nonatomic, strong) UIButton *playButton;

@end

@implementation UPControlPanel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.playButton];
    }
    return self;
}

- (void)playStatusChanged:(UIButton *)button{
    if (self.playButtonCLick) {
        self.playButtonCLick(button);
    }
}

- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.frame = CGRectMake((kScreenWidth - 70) / 2,0, 70,44);
        [_playButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_playButton setTitle:@"播放" forState:UIControlStateSelected];
        [_playButton setBackgroundColor:[UIColor whiteColor]];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playStatusChanged:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}


@end
