//
//  GSContentTableViewCell.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/27.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface GSContentTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView * avatarImageV;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView * contentImageV;
@property (nonatomic,strong) UIImageView * timeIcon;
@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) UIView * hudongV;
@property (nonatomic,strong) UIButton * commentBtn;
@property (nonatomic,strong) UILabel * commentL;
@property (nonatomic,strong) UIButton * forwardBtn;
@property (nonatomic,strong) UILabel * forwardL;
@property (nonatomic,strong) UIButton * likeBtn;
@property (nonatomic,strong) UIImageView * likeImageV;
@property (nonatomic,strong) UILabel * likeL;
@end
