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
#define kLOLMovieStr @"http://videohy.tc.qq.com/vhot2.qqvideo.tc.qq.com/i0198e3nrxv.p702.1.mp4?vkey=E9894CE1624646A3877812381E269D676EF73984C0657894A14208D50BEDE2A97C477064E18DBCD6BFC65DA1CB875B13D6A84D7FEF9DAE0FCB67C215C0724C6EC2A0CBA161BE9C4877A4096F9030814F0624A24B5B9D5F37&sha=&level=3&br=200&fmt=hd&sdtfrom=%28null%29&platform=0&guid=7bb4c06070471033bbcf80fbd48ad00a&ocid=232660908"
#define TencentSports @"http://123.125.86.21/vlive.qqvideo.tc.qq.com/v0020wmbdf9.p412.1.mp4?vkey=363C785E45D581170C38D6C5CE607F987D5AAA44CAD1B5764218CA977C3BF8F4553CD78DAAF45FBD160154CFA2384EFEC26F5EE438040750F67F8709A2291CA12CA8D0F09D4B390DAA1B28C3541981F29EEAF0972B7F8A15&sha=&level=3&br=200&fmt=hd&sdtfrom=v3030&platform=40403&guid=E411ADA7B940479FAEF7FAE4BF6CE3E6"
#define kReadJsonList 0 //1播放自定义url,0读取固定url

@interface UPResourceViewController ()

@property (nonatomic, strong) UPResourceCagetoryTableView *categoryTableView;
@property (nonatomic, strong) UPResourceSubCategoryCollectionView *subCategoryCollectionView;
@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation UPResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史";
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
    [self.subCategoryCollectionView refreshSubCatagoryCollectionView:subCategoryArray];
    [self.subCategoryCollectionView scrollToTop];
}

- (void)playByUrlString:(NSString *)urlString{
    UPPlayerController *playerCtrl = [[UPPlayerController alloc] initWithURL:[NSURL URLWithString:kReadJsonList ? urlString : originStr]];
    playerCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerCtrl animated:YES];
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

- (UPResourceSubCategoryCollectionView *)subCategoryCollectionView{
    if (!_subCategoryCollectionView) {
        _subCategoryCollectionView = [[UPResourceSubCategoryCollectionView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_subCategoryCollectionView];
        
        WS(weakSelf)
        _subCategoryCollectionView.cellClickBlock = ^(id item){
            [weakSelf playByUrlString:StringNotNull(item)];
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
