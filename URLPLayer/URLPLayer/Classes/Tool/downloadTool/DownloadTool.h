//
//  DownloadTool.h
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPUrlSubCategoryModel.h"


@protocol DownloadDelegate <NSObject>
/** 下载中的回调 */
- (void)downloadResponse:(UPUrlSubCategoryModel *)videoPlayModel progress:(CGFloat) progress speed:(NSInteger)speed writtenSize:( NSString *)writtenSize totalSize:(NSString *)totalSize;
@optional
- (void)downloadFinished:(UPUrlSubCategoryModel *)videoPlayModel;
@optional
-(void)beginNewDownload:(UPUrlSubCategoryModel*)videoPlayModel;

@end

@interface DownloadTool  : NSObject<NSCopying, NSURLSessionDelegate>

/** 保存所有下载相关信息 */
@property (nonatomic, strong, readonly) NSMutableDictionary *videoPlayModels;
/** ZFDownloadDelegate */
@property (nonatomic, assign) id<DownloadDelegate> delegate;

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;


/**
 *  开启任务下载资源
 */
- (void)addTaskWithVideoPlayModel:(UPUrlSubCategoryModel * )videoPlayModel;

/**
 暂停或开始下载任务
 */
- (void)suspendOrBeginWithVideoPlayModel:(UPUrlSubCategoryModel * )videoPlayModel;



/**
 *  删除该资源
 *
 *  @param url 下载地址
 */
- (void)deleteFile:(NSString *)url;

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile;



- (void)exitApp;

- (void)allStart;

- (void)allSuspend;




@end
