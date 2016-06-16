//
//  UPBmobManager.h
//  URLPLayer
//
//  Created by jinyulong on 16/6/10.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPBmobSourceList.h"

#define UPBmobSingetonManager [UPBmobManager singleton]

typedef void (^UPBmobResultBlock)(NSArray *resultArray);

@interface UPBmobManager : NSObject

+ (instancetype)singleton;

@property (nonatomic, assign) BOOL isInitSuccess;//是否成功初始化

- (void)registBmob;

//按表查询,未知表名和model类型时用此项,数据请求,错误处理
- (void)loadDataWithList:(NSString *)list result:(BmobObjectArrayResultBlock)result;

- (void)loadScrollPicList:(UPBmobResultBlock)result;
//电影分类
- (void)loadCategoryList:(UPBmobResultBlock)result;
//电影子类
- (void)loadSubCategotyList:(NSString *)listName result:(UPBmobResultBlock)result;

@end
