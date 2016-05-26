//
//  VideoModel.m
//  URLPlayer
//
//  Created by wubing on 16/5/26.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (float)calculateFileSizeInUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3))
        return (float) (contentLength / (float)pow(1024, 3));
    else if(contentLength >= pow(1024, 2))
        return (float) (contentLength / (float)pow(1024, 2));
    else if(contentLength >= 1024)
        return (float) (contentLength / (float)1024);
    else
        return (float) (contentLength);
}

- (NSString *)calculateUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3)){
        NSLog(@"%f",pow(1024, 3));
        return @"GB";
    }
    else if(contentLength >= pow(1024, 2))
        return @"MB";
    else if(contentLength >= 1024)
        return @"KB";
    else
        return @"B";
}

@end
