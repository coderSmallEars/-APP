//
//  UPInlineMethod.h
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

static inline NSString *StringNotNull(NSString *string) {
    
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]]){
        return @"";
    }else {
        return string;
    }
}

static inline CGSize SizeForString(NSString *string,UIFont *font,CGSize size){
    CGRect newRect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    return newRect.size;
}