//
//  GSContentTableViewCell.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/27.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSContentTableViewCell.h"

@implementation GSContentTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.avatarImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.avatarImageV.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//        self.avatarImageV.placeHolder = [UIImage imageNamed:@"avatarplaceholder"];
        [self.contentView addSubview:self.avatarImageV];
        [self.avatarImageV sd_setImageWithURL:[NSURL URLWithString:@"http://onemin.qiniudn.com/FB607B10-0AA9-4D17-A3AA-4F3C98C5ABBD.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        self.avatarImageV.layer.cornerRadius = 20;
        self.avatarImageV.layer.masksToBounds = YES;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.text = @"高圆圆";
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];
        
        self.timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(62, 39, 10, 10)];
        [self.timeIcon setImage:[UIImage imageNamed:@"History_icon"]];
        [self.contentView addSubview:self.timeIcon];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 35, 150, 18)];
        [self.timeLabel setText:@"6小时前"];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.timeLabel];
        
        self.contentImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds))];
        self.contentImageV.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//        self.contentImageV.imageWithPath = @"http://onemin.qiniudn.com/35728-6Nqdc3Q.jpg";
        [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:@"http://onemin.qiniudn.com/35728-6Nqdc3Q.jpg"]];
        [self.contentView addSubview:self.contentImageV];
        
        self.hudongV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentImageV.frame), Screen_Width, 50)];
        self.hudongV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.hudongV];
        
        self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.commentBtn setFrame:CGRectMake(0, 5, Screen_Width/3, 40)];
        self.commentBtn.backgroundColor = [UIColor clearColor];
        [self.hudongV addSubview:self.commentBtn];
        
        UIImageView * cv = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width/3)/2-35, 5, 30, 30)];
        cv.backgroundColor = RGBCOLOR(240, 240, 240, 1);
        [self.commentBtn addSubview:cv];
        
        self.commentL = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width/3)/2+5, 5, (Screen_Width/3)/2-15, 30)];
        self.commentL.backgroundColor = [UIColor whiteColor];
        self.commentL.textColor = RGBCOLOR(120, 120, 120, 1);
        self.commentL.font = [UIFont systemFontOfSize:14];
        self.commentL.adjustsFontSizeToFitWidth = YES;
        [self.commentBtn addSubview:self.commentL];
        self.commentL.text = @"评论";
        
        self.forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.forwardBtn setFrame:CGRectMake(Screen_Width/3, 5, Screen_Width/3, 40)];
        self.forwardBtn.backgroundColor = [UIColor clearColor];
        [self.hudongV addSubview:self.forwardBtn];
        
        UIImageView * fv = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width/3)/2-35, 5, 30, 30)];
        fv.backgroundColor = RGBCOLOR(240, 240, 240, 1);
        [self.forwardBtn addSubview:fv];
        
        self.forwardL = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width/3)/2+5, 5, (Screen_Width/3)/2-15, 30)];
        self.forwardL.backgroundColor = [UIColor whiteColor];
        self.forwardL.textColor = RGBCOLOR(120, 120, 120, 1);
        self.forwardL.font = [UIFont systemFontOfSize:14];
        self.forwardL.adjustsFontSizeToFitWidth = YES;
        [self.forwardBtn addSubview:self.forwardL];
        self.forwardL.text = @"转发";
        
        self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.likeBtn setFrame:CGRectMake((Screen_Width/3)*2, 5, Screen_Width/3, 40)];
        self.likeBtn.backgroundColor = [UIColor clearColor];
        [self.hudongV addSubview:self.likeBtn];
        
        self.likeImageV = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width/3)/2-35, 5, 30, 30)];
        self.likeImageV.backgroundColor = RGBCOLOR(240, 240, 240, 1);
        [self.likeBtn addSubview:self.likeImageV];
        
        self.likeL = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width/3)/2+5, 5, (Screen_Width/3)/2-15, 30)];
        self.likeL.backgroundColor = [UIColor whiteColor];
        self.likeL.textColor = RGBCOLOR(120, 120, 120, 1);
        self.likeL.font = [UIFont systemFontOfSize:14];
        self.likeL.adjustsFontSizeToFitWidth = YES;
        [self.likeBtn addSubview:self.likeL];
        self.likeL.text = @"喜欢";
        
        UIView * l1 = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width/3, 10, 1, 30)];
        l1.backgroundColor = RGBCOLOR(230, 230, 230, 1);
        [self.hudongV addSubview:l1];
        UIView * l2 = [[UIView alloc] initWithFrame:CGRectMake((Screen_Width/3)*2, 10, 1, 30)];
        l2.backgroundColor = RGBCOLOR(230, 230, 230, 1);
        [self.hudongV addSubview:l2];

        
        UIView * sepV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hudongV.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 5)];
        [self.contentView addSubview:sepV];
        [sepV setBackgroundColor:RGBCOLOR(243, 243, 243, 1)];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
