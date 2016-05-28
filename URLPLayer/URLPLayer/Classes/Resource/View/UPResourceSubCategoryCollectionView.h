//
//  UPResourceSubCategoryCollectionView.h
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPResourceSubCategoryCollectionView : UICollectionView

@property (nonatomic, copy)UPGeneralBlock cellClickBlock;

- (void)refreshSubCatagoryCollectionView:(NSArray *)subCategoryArray;

@end
