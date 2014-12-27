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
        self.backgroundColor = RGBCOLOR(243, 243, 243, 1);
        self.contentView.backgroundColor = RGBCOLOR(243, 243, 243, 1);
        
        self.avatarImageV = [[DBImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.avatarImageV.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//        self.avatarImageV.placeHolder = [UIImage imageNamed:@"avatarplaceholder"];
        [self.contentView addSubview:self.avatarImageV];
        self.avatarImageV.imageWithPath = @"http://onemin.qiniudn.com/FB607B10-0AA9-4D17-A3AA-4F3C98C5ABBD.jpg";
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
        
        self.contentImageV = [[DBImageView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds))];
        self.contentImageV.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        self.contentImageV.imageWithPath = @"http://onemin.qiniudn.com/35728-6Nqdc3Q.jpg";
        [self.contentView addSubview:self.contentImageV];
        
        UIView * sepV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetWidth([UIScreen mainScreen].bounds)+60, CGRectGetWidth([UIScreen mainScreen].bounds), 5)];
        [self.contentView addSubview:sepV];
        [sepV setBackgroundColor:[UIColor whiteColor]];
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
