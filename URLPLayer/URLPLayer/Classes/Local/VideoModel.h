//
//  VideoModel.h
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
/**
 更新时间
 */
@property (nonatomic,strong) NSString *updatedAt;

/**
 文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 文件大小
 */
@property (nonatomic, copy) NSString *totalSize;


/**
 所属课程的名称
 */
@property (nonatomic, copy) NSString* video_name;



/**
 该视频缩略图url
 */
@property (nonatomic, copy) NSString *video_img;


/**
 视频简介
 */
@property (nonatomic, copy) NSString *video_des;



/**
 视频url
 */
@property (nonatomic, copy) NSString *video_url;

/**
 视频类型
 */
@property (nonatomic, copy)NSString * video_type;

/**
 视频下载状态
 */
@property (nonatomic, copy) NSString* downloadState;//数据库存储:downloading/pause/downloaded/wait

@property (nonatomic, copy) NSString *currentSize;

@property (nonatomic, copy) NSString *lastSize;




- (float)calculateFileSizeInUnit:(unsigned long long)contentLength;

- (NSString *)calculateUnit:(unsigned long long)contentLength;
@end
