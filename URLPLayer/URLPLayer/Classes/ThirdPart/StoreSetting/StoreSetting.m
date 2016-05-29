//
//  BKStoreSetting.m
//  BKoo
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import "StoreSetting.h"
#import "SSKeychain.h"
@implementation StoreSetting
//设置或保存用户名
+ (void)setUserName:(NSString *)userName;
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:NSStringFromSelector(@selector(getUserName))];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(_cmd)];
}

+ (void)setUserInfoDic:(NSDictionary *)userInfo{
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:NSStringFromSelector(@selector(getUserInfoDic))];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)getUserInfoDic{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(_cmd)];
}


//设置或保存用户密码
+ (void)setPassWord:(NSString *)passWord
{
    [SSKeychain setPassword:passWord forService:[NSBundle mainBundle].bundleIdentifier account:[self getUserName]];
}

+ (NSString *)getPassWord
{
    return [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:[self getUserName]];
}

//判断用户是否有效
+ (BOOL)isValid
{
    BOOL ret = NO;
    NSString *result = [self getUserName];
    if ([result isKindOfClass:[NSString class]]
        && result.length > 0
        && result !=nil)
    {
        ret = YES;
    }
    return ret;
}

+ (void)removeAccount
{
    [StoreSetting setUserName:nil];
    [StoreSetting setPassWord:nil];
}

+(NSString*)getStringForKey:(NSString*)key
{
    NSString* val = @"";
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults stringForKey:key];
    if (val == NULL) val = @"";
    return val;
}

+(NSInteger)getIntForkey:(NSString *)key
{
    NSInteger val = 0;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults integerForKey:key];
    return val;
}

+(NSDictionary*)getDictForKey:(NSString*)key
{
    NSDictionary* val = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults dictionaryForKey:key];
    return val;
}

+(NSArray*)getArrayForKey:(NSString*)key
{
    NSArray* val = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults arrayForKey:key];
    return val;
}

+(BOOL)getBoolForKey:(NSString*)key
{
    BOOL val = FALSE;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults boolForKey:key];
    return val;
}

+(void)setStringForKey:(NSString*)value:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setIntForKey:(NSInteger)value:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        [standardUserDefaults setInteger:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setDictForKey:(NSDictionary*)value:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setArrayForKey:(NSArray*)value:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setBoolForKey:(BOOL)value:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        [standardUserDefaults setBool:value forKey:key];
        [standardUserDefaults synchronize];
    }
}



#pragma mark-----两种方法删除NSUserDefaults所有记录

//方法一
//NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//


//方法二
+ (void)resetDefaults {
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dict = [defs dictionaryRepresentation];
    
    for (id key in dict) {
        
        [defs removeObjectForKey:key];
        
    }
    [defs synchronize];
}




@end
