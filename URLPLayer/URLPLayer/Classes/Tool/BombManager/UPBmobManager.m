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
        }
    });
    return manager;
}

+ (void)loadDataWithList:(NSString *)list result:(BmobObjectArrayResultBlock)result{
    BmobQuery *bquery = [BmobQuery queryWithClassName:list];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {//请求错误不返回数据,调用此方法获取数据不用每个list单独做错误处理
            NSLog(@"%@",error.description);
        }else{
            if (result) {
                result(array, error);
            }
        }
    }];
}

+ (void)loadCategoryList:(UPBmobResultBlock)result{
    [UPBmobManager loadDataWithList:UPCategoryList result:^(NSArray *resultArray, NSError *error) {
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

+ (void)loadSubCategotyList:(NSString *)listName result:(UPBmobResultBlock)result{
    [UPBmobManager loadDataWithList:listName result:^(NSArray *resultArray, NSError *error) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (BmobObject *obj in resultArray) {
            UPUrlSubCategoryModel *model = [UPUrlSubCategoryModel new];
            model.video_name = StringNotNull([obj objectForKey:@"video_name"]);
            model.video_img = StringNotNull([obj objectForKey:@"video_img"]);
            model.video_url = StringNotNull([obj objectForKey:@"video_url"]);
            [tmpArray addObject:model];
        }
        if (result) {
            result([tmpArray copy]);
        }
    }];
}

@end