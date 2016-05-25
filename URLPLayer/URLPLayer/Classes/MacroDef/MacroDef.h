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

#define ALD(x)      (x * kUPScreenWidth/375.0)
#define ALDHeight(y)      ((y) * kUPScreenHeight/667.0)

#endif /* MacroDef_h */
