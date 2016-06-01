//
//  ScorllModel.h
//  URLPLayer
//
//  Created by wubing on 16/6/1.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScorllModel : NSObject
/**
 标题
 */
@property (nonatomic , strong) NSString * title;

/**
 图片链接
 */
@property (nonatomic ,strong )NSString * pic_url;

/**
 
 webView url
 */
@property (nonatomic, strong) NSString * web_url;

@end
