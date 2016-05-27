//
//  UPDrawerCell.m
//  URLPlayer
//
//  Created by wubing on 16/5/27.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPDrawerCell.h"

@implementation UPDrawerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self layout];
    }

    return self;
}
-(void)layout{
    self.iconImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(ALD(19.5f), ALDHeight(11.f), 20.f, 20.f)];
    [self.contentView addSubview:self.iconImgView];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImgView.right +ALD(20.f), ALDHeight(11.f), 80.f, 20.f)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"000000"];
    self.titleLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.titleLab];
}
-(void)updateView:(id)datas{
    NSDictionary * dic = datas;
    self.iconImgView.image = [UIImage imageNamed:[dic allKeys][0]];
    self.titleLab.text = [dic allValues][0];


}
@end
