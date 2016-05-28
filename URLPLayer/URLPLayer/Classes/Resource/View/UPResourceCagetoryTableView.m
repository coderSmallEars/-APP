//
//  UPResourceCagetoryTableView.m
//  URLPlayer
//
//  Created by jinyulong on 16/5/28.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPResourceCagetoryTableView.h"
#import "UPResourceCategoryCell.h"

@interface UPResourceCagetoryTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *matchCategoryArray;

@end

@implementation UPResourceCagetoryTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorInset = UIEdgeInsetsZero;
        self.separatorColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor =  UPHexColor(@"#f6f6f6");
    }
    return self;
    
}

- (void)refreshAllMatchCategoryTableView:(NSArray *)array{
    self.matchCategoryArray = [array copy];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.matchCategoryArray.count;
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UPResourceCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UPResourceCategoryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.categoryNameLabel.text = @"呵呵";
    CGSize size = SizeForString(cell.categoryNameLabel.text, UPSystemFont(15),CGSizeMake(kUPScreenWidth - ALD(264) - 10, 1000));
    if(size.height + 5 > ALD(57)){
        cell.categoryNameLabel.height = size.height + 5;
    }else{
        cell.categoryNameLabel.height = ALD(57);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = SizeForString(@"呵呵", UPSystemFont(15),CGSizeMake(kUPScreenWidth - ALD(264) - 10, 1000));
    if (size.height + 5 > ALD(57)) {
        return size.height + 5;
    }else{
        return ALD(57);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (self.cellClickBlock) {
        self.cellClickBlock(nil);
    }
}
@end
