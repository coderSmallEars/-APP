//
//  MacroDef.h
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#ifndef MacroDef_h
#define MacroDef_h

#ifdef DEBUG
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#define IsTest 1
#else
#define NSLog(format, ...)
#define IsTest 0
#endif

#define kUPScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kUPScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kTabbarHeight               49.0f
#define kStatusBarHeight            20.0f
#define kNavigationBarHeight        44.0f

#define kTabSwitchHeight            39
//Screen Fit
#define ALD(x)      (x * kUPScreenWidth/375.0)
#define ALDHeight(y)      ((y) * kUPScreenHeight/667.0)
#define UPAppDelegate [UIApplication sharedApplication].delegate

/**
 *  iPhone6以下设备
 */
#define IPHONELESS6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? 640 == [[UIScreen mainScreen] currentMode].size.width : NO)
/**
 *  判断iphone6
 */
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/**
 *  判断iphone6+
 */
#define IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define WS(weakSelf) __weak typeof(*&self)weakSelf = self;
//Macro Color
#define UPHexColor(colorHex) [UIColor colorWithHexString:(colorHex)]
//System Font
#define UPSystemFont(size) [UIFont systemFontOfSize:size]
//Macro Block
typedef void(^UPGeneralBlock)(id object);

//加密与否的标志key
#define User_Encrypt @"user_encrypt"

//密码key
#define User_Secret @"user_secret"

#endif /* MacroDef_h */
