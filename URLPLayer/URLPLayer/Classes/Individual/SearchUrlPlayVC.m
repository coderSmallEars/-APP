//
//  SearchUrlPlayVC.m
//  URLPlayer
//
//  Created by wubing on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "SearchUrlPlayVC.h"
#import "SearchUrlPlayView.h"

@interface SearchUrlPlayVC ()

@property (nonatomic, strong) SearchUrlPlayView * searchView ;

@end

@implementation SearchUrlPlayVC

-(void)loadView
{
     self.view = self.searchView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    _searchView.delegate = self;
    
}

-(SearchUrlPlayView *)searchView
{

    if (!_searchView) {
        
        _searchView = [SearchUrlPlayView new];
        
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
