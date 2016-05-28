//
//  SearchUrlPlayView.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "SearchUrlPlayView.h"

@interface SearchUrlPlayView ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UISearchBar * search;

@property (nonatomic , strong) UIButton * cancel;

@property (nonatomic , strong) UITableView * tableView;

@end

@implementation SearchUrlPlayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.search];
        
        [self addSubview:self.cancel];
        
        [self addSubview:self.tableView];
        
    }

    return self;
}




-(void)dissmissVC
{
    [self uiview:nil collectionEventType:@"取消" params:nil];
}

#pragma mark - searchDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"jiji");
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
        
    }
    
    return _search;
    
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
