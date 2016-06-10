//
//  UPResourceCagetoryTableView.h
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPResourceCagetoryTableView : UITableView

@property (nonatomic, copy)UPGeneralBlock cellClickBlock;

- (void)refreshAllCategoryTableView:(NSArray *)array;

@end
