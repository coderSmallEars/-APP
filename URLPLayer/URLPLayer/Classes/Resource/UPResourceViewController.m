//
//  UPResourceViewController.m
//  URLPlayer
//
//  Created by King on 16/5/21.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPResourceViewController.h"
#import "UPResourceCagetoryTableView.h"
#import "UPResourceSubCategoryCollectionView.h"
@interface UPResourceViewController ()

@property (nonatomic, strong) UPResourceCagetoryTableView *categoryTableView;
@property (nonatomic, strong) UPResourceSubCategoryCollectionView *subCategoryCollectionView;
@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation UPResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadMatchEvent];
}
#pragma mark -加载赛事分类
- (void)loadMatchEvent{

    [self requestData];
    [self refreshCategoryTableView];
}

- (void)requestData{
    
}

- (void)refreshCategoryTableView{
    self.categoryArray = @[@1,@1];
    [self.categoryTableView refreshAllMatchCategoryTableView:self.categoryArray];
    if (self.categoryArray.count > 0) {
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [self.categoryTableView scrollToTopAnimated:NO];
        [self refreshSubCategoryCollectionView:@[]];
    }
}

- (void)refreshSubCategoryCollectionView:(NSArray*)subCategoryArray{
    [self.subCategotyCollectionView refreshSubCatagoryCollectionView:subCategoryArray];
    [self.subCategotyCollectionView scrollToTop];
}

- (void)pushMatchItemDetailController{

}

- (UPResourceCagetoryTableView *)categoryTableView{
    if (!_categoryTableView) {
        _categoryTableView = [[UPResourceCagetoryTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_categoryTableView];
        
        WS(weakSelf)
        _categoryTableView.cellClickBlock = ^(id item){
            [weakSelf refreshSubCategoryCollectionView:@[]];
        };
        [_categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(weakSelf.view);
            make.width.mas_equalTo(kUPScreenWidth - ALD(264));
        }];
    }
    return _categoryTableView;
}

- (UPResourceSubCategoryCollectionView *)subCategotyCollectionView{
    if (!_subCategoryCollectionView) {
        _subCategoryCollectionView = [[UPResourceSubCategoryCollectionView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_subCategoryCollectionView];
        
        WS(weakSelf)
        _subCategoryCollectionView.cellClickBlock = ^(id item){
            [weakSelf pushMatchItemDetailController];
        };
        [ _subCategoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(weakSelf.view);
            make.width.mas_equalTo(ALD(264));
        }];
    }
    return _subCategoryCollectionView;
}

#pragma mark - UIViewControllerRotation
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
