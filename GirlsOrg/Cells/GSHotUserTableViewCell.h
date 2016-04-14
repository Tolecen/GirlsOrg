//
//  GSHotUserTableViewCell.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/27.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface GSHotUserTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView * avatarImageV;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * desLabel;
@property (nonatomic,strong) UIButton * relationBtn;
@end
