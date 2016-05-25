//
//  UPBaseTableCell.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPBaseTableCell.h"

@implementation UPBaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - UIViewCollectEventsDelegate
-(void)uiView:(UIView*)uiView collectEventsType:(id)type params:(id)params{
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(uiview:collectionEventType:params:)]) {
            [self.delegate uiview:uiView collectionEventType:type params:params];
        }
    }
}
-(void)updateView:(id)datas{
    
}

@end
