//
//  SqliteTool.h
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDB.h"
#import "UPUrlSubCategoryModel.h"

@interface SqliteTool : NSObject
/**
 *  添加视频对象
 *
 *  @param model 视频对象
 */
+(void)addVideo:(UPUrlSubCategoryModel *)model;

/**
 *  删除视频对象
 *
 *  @param model 视频对象
 */
+(void)removeVideo:(UPUrlSubCategoryModel *)model;

/**
 *  根据video_url删除视频
 *
 *  @param video_url 视频url
 */
+(void)removeVideoByVideo_url:(NSString * )video_url;

/**
 *  修改视频对象内容
 *
 *  @param model 视频对象
 */
+(void)modifyVideoModel:(UPUrlSubCategoryModel *)model;



/**
 *  根据video_url取得视频
 *
 *  @param video_url 视频url
 *
 *  @return 视频对象
 */
+(UPUrlSubCategoryModel *)modelgetVideoByVideo_url:(NSString*)video_url;

/**
 查询所有下载视频模型
 
 */
+(NSMutableArray *)getAllVideoModels;

/**
 获取所有未下载视频模型
 */
+(NSMutableArray *)getAllVideoNoDownloadedModels;

/**
 获取所有下载等待的模型
 */
+ (NSMutableArray *)getWaitModels;

/****** 历史*****/

/**
 查询视频播放历史记录
 
 */
+(NSMutableArray *)getAllHistoryModels;

/**
 获取所有未加密的视频模型
 */
+(NSMutableArray *)getAllNotEncryptHistoryModels;

/**
 *
 *  根据video_url删除播放历史视频
 *
 *  @param videoId 视频url
 */
+(void)removeHistoryByVideo_url:(NSString * )video_url;

/**
 添加播放历史模型
 */
+(void)addHistory:(UPUrlSubCategoryModel *)model;

/**
 移除历史视频模型
 */
+(void)removeHistory:(UPUrlSubCategoryModel *)model;

/**
 根据视频url获取播放历史模型
 */
+(UPUrlSubCategoryModel *)historyModelGetByVideo_url:(NSString*)video_url;

/**
 清空加密的播放历史
 */
+(void)deleteAllEncryptHistoryModel;

/**
  清空所有未加密的播放历史
 */
+(void)deleteAllNotEncryptHistoryModel;

/**
 获取所有加密的视频模型
 */
+(NSMutableArray *)getAllEncryptHistoryModels;

@end
