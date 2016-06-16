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

#define originStr @"rtmp://live.hkstv.hk.lxdns.com/live/hks"

#define kReadJsonList 0 //1播放正式数据url,0读取测试数据url

@interface UPResourceViewController ()

@property (nonatomic, strong) UPResourceCagetoryTableView *categoryTableView;
@property (nonatomic, strong) UPResourceSubCategoryCollectionView *subCategoryCollectionView;
@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation UPResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资源";
    [self loadVideoEvent];
}
#pragma mark -加载赛事分类
- (void)loadVideoEvent{
    [self requestData];
}
- (void)requestData{
    //查找轮播图表
    WS(weakSelf)
    [UPBmobSingetonManager loadCategoryList:^(NSArray *array) {
        weakSelf.categoryArray = array;
        [weakSelf refreshCategoryTableView];
    }];
}

- (void)refreshCategoryTableView{
    WS(weakSelf)
    [self.categoryTableView refreshAllCategoryTableView:self.categoryArray];
    if (self.categoryArray.count > 0) {
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [self.categoryTableView scrollToTopAnimated:NO];
        UPUrlCategoryModel *model = self.categoryArray.firstObject;
        [UPBmobSingetonManager loadSubCategotyList:model.tableTitle result:^(NSArray *resultArray) {
            [weakSelf refreshSubCategoryCollectionView:resultArray];
        }];
    }
}

- (void)refreshSubCategoryCollectionView:(NSArray*)subCategoryArray{
    [self.subCategoryCollectionView refreshSubCatagoryCollectionView:subCategoryArray];
}

- (void)playBySubCategoryModel:(UPUrlSubCategoryModel *)model{
    NSLog(@"playurl -------------------------%@",model.video_url);
    UPPlayerController *playerCtrl = [[UPPlayerController alloc] initWithURL:[NSURL URLWithString:kReadJsonList ? originStr : model.video_url]];
    playerCtrl.title = model.video_name;
    playerCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerCtrl animated:YES];
}

- (void)playByUrlString:(NSString *)urlString{
    NSLog(@"playurl -------------------------%@",urlString);
    UPPlayerController *playerCtrl = [[UPPlayerController alloc] initWithURL:[NSURL URLWithString:kReadJsonList ? originStr : urlString]];
    playerCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerCtrl animated:YES];
}

- (UPResourceCagetoryTableView *)categoryTableView{
    if (!_categoryTableView) {
        _categoryTableView = [[UPResourceCagetoryTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_categoryTableView];
        
        WS(weakSelf)
        _categoryTableView.cellClickBlock = ^(id listUrl){
            [UPBmobSingetonManager loadSubCategotyList:listUrl result:^(NSArray *resultArray) {
                [weakSelf refreshSubCategoryCollectionView:resultArray];
            }];
        };
        
        [_categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(weakSelf.view);
            make.width.mas_equalTo(kUPScreenWidth - ALD(264));
        }];
    }
    return _categoryTableView;
}

- (UPResourceSubCategoryCollectionView *)subCategoryCollectionView{
    if (!_subCategoryCollectionView) {
        _subCategoryCollectionView = [[UPResourceSubCategoryCollectionView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_subCategoryCollectionView];
        
        WS(weakSelf)
        _subCategoryCollectionView.cellClickBlock = ^(id model){
            [weakSelf playBySubCategoryModel:model];
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
