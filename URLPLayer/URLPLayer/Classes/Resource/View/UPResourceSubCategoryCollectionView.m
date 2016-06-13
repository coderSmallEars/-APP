//
//  UPResourceSubCategoryCollectionView.m
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPResourceSubCategoryCollectionView.h"
#import "UPResourceSubCategoryCell.h"
#import "SqliteTool.h"
static NSString *const subCategoryReuseIdentifier = @"LESubCategoryCollectionCell";
@interface UPResourceSubCategoryCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *subCatogoryArray;

@end

@implementation UPResourceSubCategoryCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:self.flowLayout]) {
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UPResourceSubCategoryCell class] forCellWithReuseIdentifier:subCategoryReuseIdentifier];
    }
    return self;
}

- (void)refreshSubCatagoryCollectionView:(NSArray *)subCategoryArray{
    if (![self.subCatogoryArray isEqual:subCategoryArray]) {
        self.subCatogoryArray = [subCategoryArray copy];
    }
    self.subCatogoryArray = [subCategoryArray copy];
    if (_subCatogoryArray && [_subCatogoryArray isKindOfClass:[NSArray class]]) {
        [self reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subCatogoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UPResourceSubCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:subCategoryReuseIdentifier forIndexPath:indexPath];
    UPUrlSubCategoryModel *model = self.subCatogoryArray[indexPath.row];
    [cell refreshSubCategoryCollectionCell:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UPUrlSubCategoryModel *model = self.subCatogoryArray[indexPath.row];
    //播放记录插入数据库
   UPUrlSubCategoryModel * sqliteModel = [SqliteTool historyModelGetByVideo_url:model.video_url];
    if (sqliteModel == nil) {
        model.encrypt = 0;
    }else{
        model.encrypt = sqliteModel.encrypt;
        [SqliteTool removeHistory:sqliteModel];
        
    }
    [SqliteTool addHistory:model];

    
    if (self.cellClickBlock) {
        self.cellClickBlock(model);
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat edge = ALD(18);
        _flowLayout.minimumLineSpacing = edge;
        _flowLayout.minimumInteritemSpacing = edge - 0.3;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake(ALD(105),ALD(105));
        _flowLayout.sectionInset = UIEdgeInsetsMake(edge,edge,edge,edge);
    }
    return _flowLayout;
}


@end
