//
//  SqliteTool.m
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "SqliteTool.h"

@implementation SqliteTool
static FMDatabaseQueue *queue;

+(void)initialize{
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db.sqlite"];
    NSLog(@"FMDBpath: %@",filename);
    // 1.创建数据库队列
    queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        //创建Video表
        NSString * sqlClassesStr = @"create table if not exists Video (Id integer PRIMARY KEY AUTOINCREMENT,fileName text,totalSize text, video_name text,video_img blob,video_des text,video_type text,video_url text,downloadState text,currentSize text,lastSize text);";
        if(![dealDB executeUpdate:sqlClassesStr])
        {
            NSLog(@"Video表创建失败");
        } else {
            NSLog(@"Video表创建成功");
        }
        
        //创建播放历史History表
        NSString * sqlHistoryStr = @"create table if not exists History (Id integer PRIMARY KEY AUTOINCREMENT,fileName text,totalSize text, video_name text,video_img blob,video_des text,video_type text,video_url text,downloadState text,currentSize text,lastSize text);";
        if(![dealDB executeUpdate:sqlHistoryStr])
        {
            NSLog(@"History表创建失败");
        } else {
            NSLog(@"History表创建成功");
        }
    }];

}


/**
 *  添加视频对象
 *
 *  @param model 视频对象
 */
+(void)addVideo:(VideoModel *)model{
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Video (fileName,totalSize,video_name,video_img,video_des,video_type,video_url,downloadState,currentSize,lastSize) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model.fileName,model.totalSize,model.video_name,model.video_img,model.video_des,model.video_type,model.video_url,model.downloadState,model.currentSize,model.lastSize];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"model添加失败!");
            
        }
        
    }];
    
    
}

/**
 *  删除视频对象
 *
 *  @param model 视频对象
 */
+(void)removeVideo:(VideoModel *)model{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Video WHERE video_url='%@'",model.video_url];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"model删除失败!");
            
        }
        
    }];
}
/**
 *  根据video_url删除视频
 *
 *  @param video_url 视频url
 */
+(void)removeVideoByVideo_url:(NSString * )video_url{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Video WHERE video_url='%@'",video_url];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"model删除失败!");
            
        }
        
    }];
    
}

/**
 *  修改视频对象内容
 *
 *  @param model 视频对象
 */
+(void)modifyVideoModel:(VideoModel *)model{
    NSString *sql=[NSString stringWithFormat:@"UPDATE Video SET fileName='%@',totalSize='%@',video_name='%@',video_img='%@',video_des='%@',video_type='%@',video_url='%@',downloadState='%@',currentSize='%@',lastSize='%@'",model.fileName,model.totalSize,model.video_name,model.video_img,model.video_des,model.video_type,model.video_url,model.downloadState,model.currentSize,model.lastSize];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"model修改失败!");
            
        }
        
    }];
    
}
/**
 *  根据video_url取得视频
 *
 *  @param video_url 视频url
 *
 *  @return 视频对象
 */
+(VideoModel *)modelgetVideoByVideo_url:(NSString *)video_url{
    NSMutableArray *array=[NSMutableArray array];
    VideoModel *model=[[VideoModel alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT fileName,totalSize,video_name,video_img,video_des,video_type,downloadState,currentSize,lastSize FROM Video WHERE video_url='%@'",video_url];
    [queue inDatabase:^(FMDatabase *dealDB) {
        //执行查询sql语句
        FMResultSet *result= [dealDB executeQuery:sql];
        while (result.next) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<result.columnCount; ++i) {
                dic[[result columnNameForIndex:i]]=[result stringForColumnIndex:i];
            }
            [array addObject:dic];
        }
        [result close];
        
    }];
    
    if (array&&array.count>0) {
        [model setValuesForKeysWithDictionary:array[0]];
        return model;
    }
    return nil;
    
    
}
/**
 查询所有下载的视频模型
 
 */
+(NSMutableArray *)getAllVideoModels{
    NSMutableArray * modelArr = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        
        // 1.查询数据
        
        FMResultSet *rs = [dealDB executeQuery:@"select * from Video"];
        while ([rs next]) {
            VideoModel * model = [[VideoModel alloc]init];
            model.fileName = [rs stringForColumn:@"fileName"];
            model.totalSize = [rs stringForColumn:@"totalSize"];
            model.video_name = [rs stringForColumn:@"video_name"];
            model.video_img = [rs stringForColumn:@"video_img"];
            model.video_url = [rs stringForColumn:@"video_url"];
            model.video_type = [rs stringForColumn:@"video_type"];
            model.video_des = [rs stringForColumn:@"video_des"];
            model.downloadState = [rs stringForColumn:@"downloadState"];
            model.currentSize = [rs stringForColumn:@"currentSize"];
            model.lastSize = [rs stringForColumn:@"lastSize"];
            [modelArr addObject:model];
        }
        
        [rs close];
    }];
    return modelArr;
}

/**
 查询所有非下载完成视频模型
 
 */
+(NSMutableArray *)getAllVideoNoDownloadedModels{
    NSMutableArray * modelArr = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        
        // 1.查询数据
        
        FMResultSet *rs = [dealDB executeQuery:@"select * from Video where downloadState!='downloaded'"];
        while ([rs next]) {
            VideoModel * model = [[VideoModel alloc]init];
            model.fileName = [rs stringForColumn:@"fileName"];
            model.totalSize = [rs stringForColumn:@"totalSize"];
            model.video_name = [rs stringForColumn:@"video_name"];
            model.video_img = [rs stringForColumn:@"video_img"];
            model.video_url = [rs stringForColumn:@"video_url"];
            model.video_type = [rs stringForColumn:@"video_type"];
            model.video_des = [rs stringForColumn:@"video_des"];
            model.currentSize = [rs stringForColumn:@"currentSize"];
            model.lastSize = [rs stringForColumn:@"lastSize"];
            [modelArr addObject:model];
        }
        
        [rs close];
    }];
    
    return modelArr;
}


/**
 查询所有播放历史模型
 
 */
+(NSMutableArray *)getAllHistoryModels{
    NSMutableArray * modelArr = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *dealDB) {
        // 1.查询数据
        FMResultSet *rs = [dealDB executeQuery:@"select * from History"];
        while ([rs next]) {
            VideoModel * model = [[VideoModel alloc]init];
            model.fileName = [rs stringForColumn:@"fileName"];
            model.totalSize = [rs stringForColumn:@"totalSize"];
            model.video_name = [rs stringForColumn:@"video_name"];
            model.video_img = [rs stringForColumn:@"video_img"];
            model.video_url = [rs stringForColumn:@"video_url"];
            model.video_type = [rs stringForColumn:@"video_type"];
            model.video_des = [rs stringForColumn:@"video_des"];
            model.downloadState = [rs stringForColumn:@"downloadState"];
            model.currentSize = [rs stringForColumn:@"currentSize"];
            model.lastSize = [rs stringForColumn:@"lastSize"];
            [modelArr addObject:model];
        }
        [rs close];
    }];
    return modelArr;
}

/**
 *  根据video_url删除视频
 *
 *  @param videoId 视频url
 */
+(void)removeHistoryByVideo_url:(NSString * )video_url{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM History WHERE video_url='%@'",video_url];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"model删除失败!");
            
        }
        
    }];
    
}

/**
 *  添加视频历史
 *
 *  @param model 视频对象
 */
+(void)addHistory:(VideoModel *)model{
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Video (fileName,totalSize,video_name,video_img,video_des,video_type,video_url,downloadState,currentSize,lastSize) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model.fileName,model.totalSize,model.video_name,model.video_img,model.video_des,model.video_type,model.video_url,model.downloadState,model.currentSize,model.lastSize];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"history记录添加失败!");
        }
        
    }];
}


/**
 *  删除历史视频记录
 *
 *  @param model 视频对象
 */
+(void)removeHistory:(VideoModel *)model{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM History WHERE video_url='%@'",model.video_url];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        if (![dealDB executeUpdate:sql])
        {
            NSLog(@"model删除失败!");
            
        }
        
    }];
}

/**
 查询等待状态视频模型
 
 */
+ (NSMutableArray *)getWaitModels{
    NSMutableArray * modelArr = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        
        // 1.查询数据
        
        FMResultSet *rs = [dealDB executeQuery:@"select * from Video where downloadState = 'wait'"];
        while ([rs next]) {
            VideoModel * model = [[VideoModel alloc]init];
            model.fileName = [rs stringForColumn:@"fileName"];
            model.totalSize = [rs stringForColumn:@"totalSize"];
            model.video_name = [rs stringForColumn:@"video_name"];
            model.video_img = [rs stringForColumn:@"video_img"];
            model.video_url = [rs stringForColumn:@"video_url"];
            model.video_type = [rs stringForColumn:@"video_type"];
            model.video_des = [rs stringForColumn:@"video_des"];
            model.downloadState = [rs stringForColumn:@"downloadState"];
            model.currentSize = [rs stringForColumn:@"currentSize"];
            model.lastSize = [rs stringForColumn:@"lastSize"];
            [modelArr addObject:model];
        }
        
        [rs close];
    }];
    
    return modelArr;
}

@end

