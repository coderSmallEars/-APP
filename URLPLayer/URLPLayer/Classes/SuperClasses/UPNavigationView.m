//
//  UPNavigationView.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPNavigationView.h"

@interface UPNavigationView ()
{
/**
 左图片名字
*/
    NSString * leftImageName;
/**
 右图片名字
 */
    NSString * rightImageName;

}
@end

@implementation UPNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(exchageColor:)
                                                     name:@"exchagecolor" object:nil];
        
        if ([StoreSetting getDictForKey:@"color"]!=nil) {
            
            
            UIColor * color = [[StoreSetting getDictForKey:@"color"] objectForKey:@"loadcolor"];
            
            self.backgroundColor = color;

        }
        
    }
    return self;
}
-(void)exchageColor:(NSNotification *)info
{
    UIColor * color = [info.userInfo objectForKey:@"color"];

    self.backgroundColor = color;
}


-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

-(UILabel *)titleLab{

    if (!_titleLab ) {
        _titleLab = [[UILabel alloc]init];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

-(UIButton *)rightBtn{

    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

-(void)creatNavigitionViewWithLeftImgName:(NSString*)leftImgName titleName:(NSString*)titleName rightImgName:(NSString*)rightImgName{
    if (![leftImgName isEqualToString:@""]) {
        leftImageName = leftImgName;
        UIImage *leftImg = [UIImage imageNamed:leftImageName];
        [self.leftBtn setImage:leftImg forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.frame = CGRectMake(9.5f, 20, leftImg.size.width +20.f, leftImg.size.height +20.f);
        self.leftBtn.centerY = self.height/2.0 +10.f;
    }
    if (![rightImgName isEqualToString:@""]) {
        rightImageName = rightImgName;
        UIImage * rightImg = [UIImage imageNamed:rightImgName];
        [self.rightBtn setImage:rightImg forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
        self.rightBtn.frame = CGRectMake(kScreenWidth - 29.5 -rightImg.size.width ,20, rightImg.size.width +20.f, rightImg.size.height +20.f);
        self.rightBtn.centerY = self.height/2.0 + 10.f;
    }
    if (![titleName isEqualToString:@""]) {
        self.titleLab.text = titleName;
        self.titleLab.bounds  = CGRectMake(0, 20, kScreenWidth, self.height - 20.f);
        [self.titleLab sizeToFit];
        self.titleLab.center = CGPointMake(kScreenWidth/2.0, self.height/2.0 + 10.f);
    }
    UIView * grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5f, kScreenWidth, 0.5f)];
    [self addSubview:grayLine];
    grayLine.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"exchagecolor" object:nil];
}

-(void)clickLeftBtn{
[self uiview:nil collectionEventType:leftImageName params:nil];

}
-(void)clickRightBtn{
    [self uiview:nil collectionEventType:rightImageName params:nil];

}
@end
