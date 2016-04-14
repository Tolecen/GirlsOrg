//
//  SettingTableViewCell.m
//  GirlsOrg
//
//  Created by TaoXinle on 16/4/14.
//  Copyright © 2016年 uzero. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.iconV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
        self.iconV.backgroundColor = RGBCOLOR(240, 240, 240, 1);
        [self.contentView addSubview:self.iconV];
        self.iconV.layer.cornerRadius = 15;
        self.iconV.layer.masksToBounds = YES;
        
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 200, 30)];
        self.titleL.backgroundColor = [UIColor clearColor];
        self.titleL.textColor = RGBCOLOR(100, 100, 100, 1);
        self.titleL.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleL];

    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
