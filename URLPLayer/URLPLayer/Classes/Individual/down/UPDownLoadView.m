//
//  DownLoadView.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDownLoadView.h"

@interface UPDownLoadView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UISegmentedControl * segment;
@property (nonatomic ,strong)UITableView * tableView;
@property (nonatomic ,strong)NSMutableArray * finishDataArray;
@property (nonatomic ,strong)NSMutableArray * beginDataArray;
@end

@implementation UPDownLoadView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    
        [self buildUI];

    }

    return self;
}

#pragma mark - 组建UI
-(void)buildUI
{
    
    [self addSubview:self.segment];

    [self addSubview:self.tableView];
}

#pragma mark - 懒加载
-(UISegmentedControl *)segment
{

    if (!_segment) {
        
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"已完成",@"下载中"]];
        
        _segment.frame =CGRectMake(-2, 0, kScreenWidth+4, 40);
        
        _segment.selectedSegmentIndex = 0;
        
        [self.segment addTarget:self action:@selector(exchageData:) forControlEvents:UIControlEventValueChanged];
        

    }
    
    return _segment;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _segment.bottom, kScreenWidth, kScreenHeight-self.segment.bottom) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        
        _tableView.dataSource =self;
    }
    
    return  _tableView;
}


#pragma mark - 数据源
-(NSMutableArray *)finishDataArray
{
    if (!_finishDataArray) {
        
        _finishDataArray = [NSMutableArray arrayWithObjects:@"完成下载", @"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",@"完成下载",nil];
    }
    return  _finishDataArray;
}


-(NSMutableArray *)beginDataArray
{
    if (!_beginDataArray) {
        
        _beginDataArray = [NSMutableArray arrayWithObjects:@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载",@"正在下载", nil];
    }
    return  _beginDataArray;
}

#pragma mark - tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self segmentChageBackArray:self.segment.selectedSegmentIndex].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * dif = @"downloadcell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:dif];
    
      if (!cell) {
          
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dif];
          
        }
    
    cell.textLabel.text =[self segmentChageBackArray:self.segment.selectedSegmentIndex][indexPath.row];
    
    return cell;
}



#pragma mark - segment切换数据源
-(void)exchageData:(UISegmentedControl *)segmentControl{

               [self.tableView reloadData];
    }

#pragma makr -
-(NSMutableArray *)segmentChageBackArray:(NSInteger)index
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
        {
            return  self.finishDataArray;
        }
            break;
        case 1:
        {
            return self.beginDataArray;
        }
            break;
            
        default:
            break;
    }
    NSMutableArray * arr = [NSMutableArray array];
    
    return arr;
}

-(void)addDelegate{
    
    [super addDelegate];
    
}
@end
