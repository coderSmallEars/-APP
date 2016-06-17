//
//  UPBmobManager.m
//  URLPLayer
//
//  Created by jinyulong on 16/6/10.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPBmobManager.h"
#import <BmobSDK/Bmob.h>
@implementation UPBmobManager

+ (instancetype)singleton{
    static UPBmobManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [UPBmobManager new];
            manager.isInitSuccess = YES;//默认yes,解决notication返回初始化成功慢问题
        }
    });
    return manager;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notification
- (void)registBmob{
    
    [Bmob registerWithAppKey:@"60b8b8347c38fff0515c5b4c988da4b1"];
    [Bmob setBmobRequestTimeOut:20];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bmobRegistNoti:) name:kBmobInitSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bmobRegistNoti:) name:kBmobInitFailNotification object:nil];
    });
}

- (void)bmobRegistNoti:(NSNotification *)noti{
    NSLog(@"%@",noti.name);
    if ([noti.name isEqualToString:kBmobInitFailNotification]) {
        NSLog(@"Failure-------------------------Bmob 初始化失败");
        self.isInitSuccess = NO;
    }else if([noti.name isEqualToString:kBmobInitSuccessNotification]){
        NSLog(@"Success-------------------------Bmob 初始化成功");
        self.isInitSuccess = YES;
    }
}

#pragma mark - API Method
- (void)loadDataWithList:(NSString *)list result:(BmobObjectArrayResultBlock)result{
    if (!self.isInitSuccess) {
        //初始化失败,重新注册
        [self registBmob];
        return;
    }
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:list];
    bmobQuery.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {//请求错误不返回数据,调用此方法获取数据不用每个list单独做错误处理
            NSLog(@"%@",error.description);
        }else{
            if (result) {
                result(array, error);
            }
        }
    }];
}

- (void)loadScrollPicList:(UPBmobResultBlock)result{
    [self loadDataWithList:UPScrollPic result:^(NSArray *array, NSError *error) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (BmobObject *obj in array) {
            ScorllModel *model = [ScorllModel new];
            model.title = [obj objectForKey:@"title"];
            model.pic_url = [obj objectForKey:@"pic_url"];
            model.web_url = [obj objectForKey:@"web_url"];
            [tmpArray addObject:model];
        }
        if (result) {
            result([tmpArray copy]);
        }
    }];
}


- (void)loadCategoryList:(UPBmobResultBlock)result{
    [self loadDataWithList:UPCategoryList result:^(NSArray *resultArray, NSError *error) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (BmobObject *obj in resultArray) {
            UPUrlCategoryModel *model = [UPUrlCategoryModel new];
            model.titleClass = StringNotNull([obj objectForKey:@"titleClass"]);
            model.tableTitle = StringNotNull([obj objectForKey:@"tableTitle"]);
            [tmpArray addObject:model];
        }
        if (result) {
            result([tmpArray copy]);
        }
    }];
}

- (void)loadSubCategotyList:(NSString *)listName result:(UPBmobResultBlock)result{
    [self loadDataWithList:listName result:^(NSArray *resultArray, NSError *error) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (BmobObject *obj in resultArray) {
            UPUrlSubCategoryModel *model = [UPUrlSubCategoryModel new];
            model.video_name = StringNotNull([obj objectForKey:@"video_name"]);
            model.video_img = StringNotNull([obj objectForKey:@"video_img"]);
            model.video_url = StringNotNull([obj objectForKey:@"video_url"]);
           
            model.video_des = StringNotNull([obj objectForKey:@"video_des"]);
            model.video_type = StringNotNull([obj objectForKey:@"video_type"]);
            model.updatedAt = StringNotNull([obj objectForKey:@"updatedAt"]);
            [tmpArray addObject:model];
        }
        if (result) {
            result([tmpArray copy]);
        }
    }];
}

@end
