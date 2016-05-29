//
//  BKStoreSetting.h
//  BKoo
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 王永军. All rights reserved.
//


#import <Foundation/Foundation.h>
//用户信息工具类

@interface StoreSetting : NSObject
//设置或保存用户名
+ (void)setUserName:(NSString *)userName;
+ (NSString *)getUserName;

// 设置个人 信息
+ (void)setUserInfoDic:(NSDictionary *)userInfo;
+ (NSDictionary *)getUserInfoDic;

//设置或保存用户密码
+ (void)setPassWord:(NSString *)passWord;
+ (NSString *)getPassWord;

//判断用户是否有效
+ (BOOL)isValid;

//移除用户
+ (void)removeAccount;


+(NSString*)getStringForKey:(NSString*)key;
+(NSInteger)getIntForkey:(NSString*)key;
+(NSDictionary*)getDictForKey:(NSString*)key;
+(NSArray*)getArrayForKey:(NSString*)key;
+(BOOL)getBoolForKey:(NSString*)key;
+(void)setStringForKey:(NSString*)value:(NSString*)key;
+(void)setIntForKey:(NSInteger)value:(NSString*)key;
+(void)setDictForKey:(NSDictionary*)value:(NSString*)key;
+(void)setArrayForKey:(NSArray*)value:(NSString*)key;
+(void)setBoolForKey:(BOOL)value:(NSString*)key;


#pragma mark-----两种方法删除NSUserDefaults所有记录
+(void)resetDefaults;



@end
