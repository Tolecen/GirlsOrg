//
//  GSContentTableViewCell.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/27.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBImageView.h"
@interface GSContentTableViewCell : UITableViewCell
@property (nonatomic,strong) DBImageView * avatarImageV;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) DBImageView * contentImageV;
@property (nonatomic,strong) UIImageView * timeIcon;
@property (nonatomic,strong) UILabel * timeLabel;
@end
