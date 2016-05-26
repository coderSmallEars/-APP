//
//  DownloadTool.m
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "DownloadTool.h"

@interface DownloadTool ()<NSURLSessionDownloadDelegate>
/**
 下载的session
 */
@property(nonatomic,strong)NSURLSession *downLoadSession;

/**
 正在下载的任务
 */
@property(nonatomic,strong)NSURLSessionDownloadTask *downLoadTask;

/** 保存所有任务(注：用下载地址/后作为key) */
@property (nonatomic, strong) NSURLSessionDataTask *task;

@property (nonatomic, strong) NSOutputStream *stream;

@property (nonatomic, strong) VideoModel *currentModel;

///  当未过加密区时已请求数据的总大小
@property (nonatomic, assign) NSInteger bufferLength;
///  是否已过加密区的标志
@property (nonatomic, assign) BOOL status;
///  下载代理执行的次数
@property (nonatomic, assign) NSInteger downloadNum;
///  截取后的钥匙字符串
@property (nonatomic, copy) NSString *keyString;

@property (nonatomic, assign) NSInteger downLoadingOffset;


@end
@implementation DownloadTool


static DownloadTool *_downloadManager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _downloadManager = [super allocWithZone:zone];
    });
    
    return _downloadManager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return _downloadManager;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[self alloc] init];
    });
    return _downloadManager;
}

///  判断某个模型数组中是否有某种状态
- (BOOL)isSomeStateWithNSArray:(NSMutableArray *)dataArr andState:(NSString *)state {
    for (NSInteger i = 0; i < dataArr.count; i ++) {
        VideoModel *model = [dataArr objectAtIndex:i];
        if ([model.downloadState isEqualToString:state]) {
            return YES;
            break;
        }
    }
    return NO;
}

/**
 *  创建缓存目录文件
 */
- (void)createCacheDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:ZFCachesDirectory]) {
        [fileManager createDirectoryAtPath:ZFCachesDirectory  withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

/**
 *  开启任务下载资源
 */
- (void)addTaskWithVideoPlayModel:(VideoModel * )videoPlayModel
{
    
    NSMutableArray *dataArr = [SqliteTool getAllVideoModels];
    if (dataArr.count == 0) {
        NSURL *url = [NSURL URLWithString:videoPlayModel.video_url];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        self.downLoadSession = session;
        self.downLoadTask = [self.downLoadSession downloadTaskWithURL:url];
        // 获得服务器这次请求 返回数据的总长度
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"HEAD";
        NSURLResponse *response = nil;
        NSError *error =nil;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        videoPlayModel.totalSize = [NSString stringWithFormat:@"%lld", response.expectedContentLength];
        
        videoPlayModel.fileName = ZFFileName(videoPlayModel.video_url);
        videoPlayModel.currentSize = @"0";
        videoPlayModel.lastSize = @"0";
        videoPlayModel.downloadState = @"downloading";
        
        self.currentModel = videoPlayModel;
        // 保存数据库
        [SqliteTool addVideo:videoPlayModel];
        //3.resume
        [self.downLoadTask resume];
    } else {
        if ([SqliteTool modelgetVideoByVideo_url:videoPlayModel.video_url]) {
            return;
        }
        if ([self isSomeStateWithNSArray:dataArr andState:@"downloading"]) {
            videoPlayModel.downloadState = @"wait";
            NSURL *url = [NSURL URLWithString:videoPlayModel.video_url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"HEAD";
            NSURLResponse *response = nil;
            NSError *error =nil;
            [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            videoPlayModel.totalSize = [NSString stringWithFormat:@"%lld", response.expectedContentLength];
            videoPlayModel.currentSize = @"0";
            videoPlayModel.lastSize = @"0";
            [SqliteTool addVideo:videoPlayModel];
        } else {
            NSURL *url = [NSURL URLWithString:videoPlayModel.video_url];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
            self.downLoadSession = session;
            self.downLoadTask = [self.downLoadSession downloadTaskWithURL:url];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"HEAD";
            NSURLResponse *response = nil;
            NSError *error =nil;
            [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            videoPlayModel.totalSize = [NSString stringWithFormat:@"%lld", response.expectedContentLength];
            videoPlayModel.fileName = ZFFileName(videoPlayModel.video_url);
            videoPlayModel.downloadState = @"downloading";
            videoPlayModel.currentSize = @"0";
            videoPlayModel.lastSize = @"0";
            self.currentModel = videoPlayModel;
            // 保存数据库
            [SqliteTool addVideo:videoPlayModel];
            [self.downLoadTask resume];
        }
    }
}

- (void)suspendOrBeginWithVideoPlayModel:(VideoModel *)videoPlayModel {
    
    NSMutableArray *sqliteArr = [SqliteTool getAllVideoModels];
    if (sqliteArr.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < sqliteArr.count; ++i) {
        VideoModel *videoModel = [sqliteArr objectAtIndex:i];
        if ([videoPlayModel.video_url isEqualToString:videoModel.video_url]) {
            if ([videoModel.downloadState isEqualToString:@"pause"]) {
                NSMutableArray *videoArr = [SqliteTool getAllVideoModels];
                if ([self isSomeStateWithNSArray:videoArr andState:@"downloading"]) {
                    videoModel.downloadState = @"wait";
                    [SqliteTool modifyVideoModel:videoModel];
                } else {
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    if ([fileManager fileExistsAtPath:kResumeDataPath(videoModel.video_url)]) {
                        NSData *data = [NSData dataWithContentsOfFile:kResumeDataPath(videoModel.video_url)];
                        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
                        self.downLoadSession = session;
                        self.downLoadTask = [self.downLoadSession downloadTaskWithResumeData:data];
                        videoModel.fileName = ZFFileName(videoModel.video_url);
                        videoModel.downloadState = @"downloading";
                        
                        
                        self.currentModel = videoModel;
                        // 保存数据库
                        [SqliteTool modifyVideoModel:videoModel];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([self.delegate respondsToSelector:@selector(beginNewDownload:)]) {
                                [self.delegate beginNewDownload:videoModel];
                            }
                        });
                        //2.resume
                        [self.downLoadTask resume];
                    } else {
                        NSURL *url = [NSURL URLWithString:videoModel.video_url];
                        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
                        self.downLoadSession = session;
                        self.downLoadTask = [self.downLoadSession downloadTaskWithURL:url];
                        videoModel.fileName = ZFFileName(videoModel.video_url);
                        videoModel.downloadState = @"downloading";
                        
                        
                        self.currentModel = videoModel;
                        // 保存数据库
                        [SqliteTool modifyVideoModel:videoModel];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([self.delegate respondsToSelector:@selector(beginNewDownload:)]) {
                                [self.delegate beginNewDownload:videoModel];
                            }
                        });
                        [self.downLoadTask resume];
                    }
                }
            } else if ([videoModel.downloadState isEqualToString:@"downloading"]) {
                [self.downLoadTask suspend];
                videoModel.downloadState = @"pause";
                [SqliteTool modifyVideoModel:videoModel];
                [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                    [resumeData writeToFile:kResumeDataPath(videoModel.video_url) atomically:YES];
                }];
                NSMutableArray *waitArr = [SqliteTool getWaitModels];
                if (waitArr.count == 0) {
                    return;
                }
                
                VideoModel *model = [waitArr firstObject];
                NSURL *url = [NSURL URLWithString:model.video_url];
                NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
                self.downLoadSession = session;
                self.downLoadTask = [self.downLoadSession downloadTaskWithURL:url];
                model.fileName = ZFFileName(model.video_url);
                model.downloadState = @"downloading";
                
                self.currentModel = model;
                
                // 保存数据库
                [SqliteTool modifyVideoModel:model];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(beginNewDownload:)]) {
                        [self.delegate beginNewDownload:model];
                    }
                });
                [self.downLoadTask resume];
            } else if ([videoModel.downloadState isEqualToString:@"wait"]) {
                videoModel.downloadState = @"pause";
                [SqliteTool modifyVideoModel:videoModel];
            }
            
            
        }
    }
}

- (void)allStart {
   
    NSMutableArray *videoArr = [SqliteTool getAllVideoNoDownloadedModels];
    if (videoArr.count == 0) {
        return;
    }
    VideoModel *video = videoArr.firstObject;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kResumeDataPath(video.video_url)]) {
        NSData *data = [NSData dataWithContentsOfFile:kResumeDataPath(video.video_url)];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        self.downLoadSession = session;
        self.downLoadTask = [self.downLoadSession downloadTaskWithResumeData:data];
        video.fileName = ZFFileName(video.video_url);
        video.downloadState = @"downloading";
        
        self.currentModel = video;
        // 保存数据库
        [SqliteTool modifyVideoModel:video];
        //2.resume
        [self.downLoadTask resume];
        
    } else {
        NSURL *url = [NSURL URLWithString:video.video_url];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        self.downLoadSession = session;
        self.downLoadTask = [self.downLoadSession downloadTaskWithURL:url];
        video.fileName = ZFFileName(video.video_url);
        video.downloadState = @"downloading";
        
        self.currentModel = video;
        // 保存数据库
        [SqliteTool modifyVideoModel:video];
        [self.downLoadTask resume];
    }
    if (videoArr.count <= 1) {
        return;
    }
    for (NSInteger i = 1; i < videoArr.count; ++i) {
        VideoModel *videoModel = [videoArr objectAtIndex:i];
        videoModel.downloadState = @"wait";
        [SqliteTool modifyVideoModel:videoModel];
    }
}

- (void)allSuspend {
    
    NSMutableArray *videoArr = [SqliteTool getAllVideoNoDownloadedModels];
    if (videoArr.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < videoArr.count; ++i) {
        VideoModel *videoModel = [videoArr objectAtIndex:i];
        if ([videoModel.downloadState isEqualToString:@"downloading"]) {
            [self.downLoadTask suspend];
            videoModel.downloadState = @"pause";
            [SqliteTool modifyVideoModel:videoModel];
            [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                [resumeData writeToFile:kResumeDataPath(videoModel.video_url) atomically:YES];
            }];
        } else if([videoModel.downloadState isEqualToString:@"pause"]) {
            // 不执行任何操作
        } else if ([videoModel.downloadState isEqualToString:@"wait"]) {
            videoModel.downloadState = @"pause";
            [SqliteTool modifyVideoModel:videoModel];
        }
    }
}

#pragma mark - 删除
/**
 *  删除该资源
 */
- (void)deleteFile:(NSString *)url
{
    
    if (self.downLoadTask && [self.currentModel.video_url isEqualToString:url]) {
        // 取消下载
        [self.downLoadTask cancel];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:ZFFileFullpath(url)]) {
        // 删除沙盒中的资源
        [fileManager removeItemAtPath:ZFFileFullpath(url) error:nil];
    }
    // 删除数据库中的该model
    NSMutableArray * modelArr = [SqliteTool getAllVideoModels];
    for ( VideoModel * model in modelArr) {
        if ([model.video_url isEqualToString:url]) {
            [SqliteTool removeVideo:model];
            break;
        }
    }
}

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile
{
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:ZFCachesDirectory]) {
        
        // 删除沙盒中所有资源
        [fileManager removeItemAtPath:ZFCachesDirectory error:nil];
        // 删除资源总长度
        for (VideoModel * model in [SqliteTool getAllVideoModels]) {
            [SqliteTool removeVideo:model];
        }
    }
}



#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
   
     [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:ZFFileFullpath(self.currentModel.video_url) error:nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kResumeDataPath(self.currentModel.video_url)]) {
        [fileManager removeItemAtPath:kResumeDataPath(self.currentModel.video_url) error:nil];
    }
    self.currentModel.downloadState = @"downloaded";
    [SqliteTool modifyVideoModel:self.currentModel];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(downloadFinished:)]) {
            [self.delegate downloadFinished:self.currentModel];
        }
    });
    
    NSMutableArray *waitArr = [SqliteTool getWaitModels];
    if (waitArr.count == 0) {
        return;
    }
    VideoModel *model = [waitArr firstObject];
    if ([fileManager fileExistsAtPath:kResumeDataPath(model.video_url)]) {
        NSData *data = [NSData dataWithContentsOfFile:kResumeDataPath(model.video_url)];
        self.downLoadTask = [self.downLoadSession downloadTaskWithResumeData:data];
        model.fileName = ZFFileName(model.video_url);
        model.downloadState = @"downloading";
        
        self.currentModel = model;
        // 保存数据库
        [SqliteTool modifyVideoModel:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(beginNewDownload:)]) {
                [self.delegate beginNewDownload:model];
            }
        });
        //2.resume
        [self.downLoadTask resume];
    } else {
        NSURL *url = [NSURL URLWithString:model.video_url];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        self.downLoadSession = session;
        self.downLoadTask = [self.downLoadSession downloadTaskWithURL:url];
        model.fileName = ZFFileName(model.video_url);
        model.downloadState = @"downloading";
        
        self.currentModel = model;
        // 保存数据库
        [SqliteTool modifyVideoModel:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(beginNewDownload:)]) {
                [self.delegate beginNewDownload:model];
            }
        });
        [self.downLoadTask resume];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    self.currentModel.currentSize = [NSString stringWithFormat:@"%lld", totalBytesWritten];
    self.currentModel.lastSize = self.currentModel.lastSize;
    [SqliteTool modifyVideoModel:self.currentModel];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(downloadResponse:progress:speed:writtenSize:totalSize:)]) {
            [self.delegate downloadResponse:self.currentModel progress:progress speed:1 writtenSize:[NSString stringWithFormat:@"%.2f%@", [self.currentModel calculateFileSizeInUnit:totalBytesWritten], [self.currentModel calculateUnit:totalBytesWritten]] totalSize:self.currentModel.totalSize];
        }
    });
}

- (void)exitApp {
       if ([self.currentModel.downloadState isEqualToString:@"downloading"]) {
        [self.downLoadTask suspend];
        self.currentModel.downloadState = @"pause";
        [SqliteTool modifyVideoModel:self.currentModel];
        [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            [resumeData writeToFile:kResumeDataPath(self.currentModel.video_url) atomically:YES];
        }];
    }
}

@end

