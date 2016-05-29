//
//  UPSearchUrlPlayView.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPSearchUrlPlayView.h"
#import "UPNavigationView.h"
@interface UPSearchUrlPlayView ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UISearchBar * search;

@property (nonatomic , strong) UIButton * cancel;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic, strong) UPNavigationView * nav;

@end

@implementation UPSearchUrlPlayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.nav];
        [self.nav addSubview:self.search];
        
        [self.nav addSubview:self.cancel];
        
        [self addSubview:self.tableView];
        
    }

    return self;
}



#pragma mark - 取消搜索
-(void)dissmissVC
{
    [self uiview:nil collectionEventType:@"取消" params:nil];
}

#pragma mark - searchDelegate(search代理)
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSRange range = [_search.text rangeOfString:@"http://"];
    
    if (range.length > 0)
    {
        NSLog(@"%@",_search.text);
        
    }
    
    else [self makeToast:@"请输入有效网址"
                    duration:0.5
                    position:@"center"
     ];

}

#pragma mark - 懒加载
/**
   搜索框
 */
-(UISearchBar *)search
{
    if (!_search) {
        
        _search = [UISearchBar new];
        
        _search.frame = CGRectMake(0, 20, kScreenWidth-60, 44);
        
        _search.placeholder = @"粘贴链接即可播放";
        
        _search.delegate = self;
        
        _search.returnKeyType = UIReturnKeySearch;
        
        _search.showsScopeBar = YES;
        
    }
    
    return _search;
    
}
-(UPNavigationView *)nav{
    if (_nav == nil) {
        _nav = [[UPNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64.f)];
        
    }
    return _nav;
}
-(UIButton *)cancel
{
    
    if (!_cancel) {
        
        _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        
        _cancel.frame = CGRectMake(_search.right, _search.top, kScreenWidth-_search.width, _search.height);
        
        //_cancel.layer.borderWidth = 1;
        
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        
        [_cancel addTarget:self action:@selector(dissmissVC) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancel;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(_search.left, _search.bottom, kScreenWidth, kScreenHeight-_search.bottom)];
        
       // _tableView.delegate = self;
        
       // _tableView.dataSource = self;
    }
    
    return  _tableView;

}






@end
