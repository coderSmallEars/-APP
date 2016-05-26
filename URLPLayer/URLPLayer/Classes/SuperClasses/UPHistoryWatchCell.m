//
//  UPHistoryWatchCell.m
//  URLPlayer
//
//  Created by wubing on 16/5/25.
//  Copyright © 2016年 Player. All rights reserved.
//

#import "UPHistoryWatchCell.h"
#import "UIImageView+WebCache.h"
@implementation UPHistoryWatchCell
/**
 height ALDHeight(114.5)
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layout];
    }
    return self;
}
-(void)layout{
    _picImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ALD(19.5f), ALDHeight(10.f) ,ALD(135.f) ,ALDHeight(94.f))];
    _picImgView.layer.cornerRadius = 8.0;
    _picImgView.clipsToBounds = YES;
    [self.contentView addSubview:_picImgView];
    _titleLab = [[UILabel alloc]init];
    _titleLab.numberOfLines = 0;
    _titleLab.textColor =[UIColor colorWithHexString:@"000000"];
    _titleLab.font = [UIFont systemFontOfSize:15.f];
    [self.contentView addSubview:_titleLab];
    _descriptLab = [[UILabel alloc]init];
    _descriptLab.textColor = [UIColor colorWithHexString:@"989898"];
    _descriptLab.font = [UIFont systemFontOfSize:12.0];
    _descriptLab.numberOfLines = 0;
    [self.contentView addSubview: _descriptLab];
   
}
-(void)updateView:(id)datas{
    [_picImgView sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    _titleLab.text = @"dnskmamdlsmdl";
    _descriptLab.text = @"ahsiskjdlsadldmsldasl;,sdl;s,a";
     CGSize titleSize = [_titleLab.text boundingRectWithSize:CGSizeMake(kScreenWidth - _picImgView.right - ALD(29.5f), 18.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
    _titleLab.frame = CGRectMake(_picImgView.right + ALD(10.f),ALDHeight(15.f), kScreenWidth - _picImgView.right -ALD(29.5f), titleSize.height);
    
    CGSize desSize = [_descriptLab.text boundingRectWithSize:CGSizeMake(kScreenWidth - _picImgView.right - ALD(29.5f), 30.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
    _descriptLab.frame = CGRectMake(_picImgView.right + ALD(10.f), _titleLab.bottom +ALDHeight(7.5f), kScreenWidth - _picImgView.right -ALD(29.5f), desSize.height);


}

@end
