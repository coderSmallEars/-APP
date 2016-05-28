//
//  UPSearchUrlPlayVC.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPSearchUrlPlayVC.h"
#import "UPSearchUrlPlayView.h"
#import "UPPlayerView.h"
#define originStr @"rtmp://live.hkstv.hk.lxdns.com/live/hks"
#define kLOLMovieStr @"http://videohy.tc.qq.com/vhot2.qqvideo.tc.qq.com/i0198e3nrxv.p702.1.mp4?vkey=E9894CE1624646A3877812381E269D676EF73984C0657894A14208D50BEDE2A97C477064E18DBCD6BFC65DA1CB875B13D6A84D7FEF9DcAE0FCB67C215C0724C6EC2A0CBA161BE9C4877A4096F9030814F0624A24B5B9D5F37&sha=&level=3&br=200&fmt=hd&sdtfrom=%28null%29&platform=0&guid=7bb4c06070471033bbcf80fbd48ad00a&ocid=232660908"
#define TencentSports @"http://123.125.86.21/vlive.qqvideo.tc.qq.com/v0020wmbdf9.p412.1.mp4?vkey=363C785E45D581170C38D6C5CE607F987D5AAA44CAD1B5764218CA977C3BF8F4553CD78DAAF45FBD160154CFA2384EFEC26F5EE438040750F67F8709A2291CA12CA8D0F09D4B390DAA1B28C3541981F29EEAF0972B7F8A15&sha=&level=3&br=200&fmt=hd&sdtfrom=v3030&platform=40403&guid=E411ADA7B940479FAEF7FAE4BF6CE3E6"
#define kReadJsonList 1 //1播放自定义url,0读取固定url

@interface UPSearchUrlPlayVC ()

@property (nonatomic, strong) UPSearchUrlPlayView * searchView ;


@end

@implementation UPSearchUrlPlayVC

-(void)loadView
{
     self.view = self.searchView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    _searchView.delegate = self;
    
}


#pragma mark - 懒加载
-(UPSearchUrlPlayView *)searchView
{

    if (!_searchView) {
        
        _searchView = [UPSearchUrlPlayView new];
        
        _searchView.frame =[UIScreen mainScreen].bounds;
    }
    
    return _searchView;
}



-(void)uiview:(UIView *)view collectionEventType:(id)type params:(id)params{
    [super uiview:view collectionEventType:type params:params];
    
    if([type isEqualToString:@"取消"]){
    
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }
    
    if([type isEqualToString:@"打开播放器"]){
        
        [self presentViewController:[(NSDictionary *)params objectForKey:@"VC"] animated:YES completion:^{
            
        }];
        
        UPPlayerView * playerView = [[UPPlayerView alloc]initWithURL:[NSURL URLWithString:kReadJsonList ? [(NSDictionary *)params objectForKey:@"searchtext"] : originStr]];
        
        
        
    }



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
