//
//  UPNavigationView.h
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPView.h"

@interface UPNavigationView : UPView
/**
 左按钮
 */
@property (nonatomic, strong) UIButton *leftBtn;

/**
 标题
 */
@property (nonatomic, strong) UILabel * titleLab;

/**
 右按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;

/**
 创建导航栏view
 */
-(void)creatNavigitionViewWithLeftImgName:(NSString*)leftImgName titleName:(NSString*)titleName rightImgName:(NSString*)rightImgName;

@end
