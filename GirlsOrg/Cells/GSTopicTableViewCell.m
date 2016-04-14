//
//  GSTopicTableViewCell.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/27.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSTopicTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation GSTopicTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.topicTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-50, 20)];
        self.topicTitleL.backgroundColor = [UIColor clearColor];
        self.topicTitleL.text = @"今天穿的什么";
        [self.contentView addSubview:self.topicTitleL];
        
        self.topicDesL = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 20)];
        self.topicDesL.backgroundColor = [UIColor clearColor];
        self.topicDesL.textColor = [UIColor grayColor];
        self.topicDesL.font = [UIFont systemFontOfSize:13];
        self.topicDesL.text = @"晒一下今天穿的什么吧，不会穿的小盆友不是合格的小盆友哦思密达";
        [self.contentView addSubview:self.topicDesL];
        
        UIImageView * arrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-25, 12, 6, 12)];
        [arrow setImage:[UIImage imageNamed:@"arrow_right"]];
        [self.contentView addSubview:arrow];
        arrow.alpha = 0.8;
        
        float imW = (CGRectGetWidth([UIScreen mainScreen].bounds)-50)/4;
        
        for (int i = 0; i<4; i++) {
            UIImageView * imv = [[UIImageView alloc] initWithFrame:CGRectMake(10*(i+1)+imW*i, 60, imW, imW)];
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
        UIImageView * im = (UIImageView *)[self.contentView viewWithTag:i+1];
        [im sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://onemin.qiniudn.com/sam%d",i+1]]];
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
