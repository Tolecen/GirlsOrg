//
//  GSHotUserTableViewCell.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/27.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSHotUserTableViewCell.h"

@implementation GSHotUserTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.avatarImageV = [[DBImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.avatarImageV.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        //        self.avatarImageV.placeHolder = [UIImage imageNamed:@"avatarplaceholder"];
        [self.contentView addSubview:self.avatarImageV];
        self.avatarImageV.imageWithPath = @"http://onemin.qiniudn.com/FB607B10-0AA9-4D17-A3AA-4F3C98C5ABBD.jpg";
        self.avatarImageV.layer.cornerRadius = 20;
        self.avatarImageV.layer.masksToBounds = YES;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 200, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.text = @"我是大美妞";
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];
        
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 33, 150, 18)];
        [self.desLabel setText:@"182个动态，被赞2800次"];
        self.desLabel.backgroundColor = [UIColor clearColor];
        self.desLabel.textColor = [UIColor grayColor];
        self.desLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.desLabel];
        
        self.relationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.relationBtn setBackgroundColor:[UIColor clearColor]];
        [self.relationBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        self.relationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.relationBtn setFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-60, 11, 60, 30)];
        [self.relationBtn setTitleColor:RGBCOLOR(250, 89, 172, 1) forState:UIControlStateNormal];
        [self.contentView addSubview:self.relationBtn];
        
        float imW = (CGRectGetWidth([UIScreen mainScreen].bounds)-50)/4;
        
        for (int i = 0; i<4; i++) {
            DBImageView * imv = [[DBImageView alloc] initWithFrame:CGRectMake(10*(i+1)+imW*i, 60, imW, imW)];
            imv.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
            //            imv.imageWithPath = [NSString stringWithFormat:@"http://onemin.qiniudn.com/sam%d",i+1];
            imv.tag = i+1;
            [self.contentView addSubview:imv];
            
        }
        UIView * sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 60+imW+10, CGRectGetWidth([UIScreen mainScreen].bounds), 10)];
        [self.contentView addSubview:sepV];
        [sepV setBackgroundColor:RGBCOLOR(243, 243, 243, 1)];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i<4; i++) {
        DBImageView * im = (DBImageView *)[self.contentView viewWithTag:i+1];
        im.imageWithPath = [NSString stringWithFormat:@"http://onemin.qiniudn.com/sam%d",5-(i+1)];
    }
}
- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
