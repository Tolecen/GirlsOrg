//
//  GSPublicView.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/12/12.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSPublicView.h"

@interface GSPublicView()

@property (nonatomic, weak) UIButton *publicText;
@property (nonatomic, weak) UIButton *publicVideo;

@property (nonatomic, weak) UIButton *closeButton;
@property (nonatomic, weak) UIImageView *publicTextImage;
@property (nonatomic, weak) UIImageView *publicVideoImage;

@end

@implementation GSPublicView

- (UIButton *)buttonWithImage:(NSString *)image selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *publicText = [self buttonWithImage:@"public_text_icon" selector:@selector(publicTextAction:)];
        [self addSubview:publicText];
        self.publicText = publicText;
        
        UIButton *publicVideo = [self buttonWithImage:@"public_video_icon" selector:@selector(publicVideoAction:)];
        [self addSubview:publicVideo];
        self.publicVideo = publicVideo;
        
        UIButton *closeButton = [self buttonWithImage:@"cancel_public_icon" selector:@selector(closeAction:)];
        [closeButton setBackgroundColor:RGBCOLOR(249, 137, 195, .5)];
        [self addSubview:closeButton];
        self.closeButton = closeButton;
        
        UIImageView *tImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        tImage.image = [UIImage imageNamed:@"文字_"];
        [tImage sizeToFit];
        [self addSubview:tImage];
        self.publicTextImage = tImage;
        
        UIImageView *vImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        vImage.image = [UIImage imageNamed:@"视频_"];
        [vImage sizeToFit];
        [self addSubview:vImage];
        self.publicVideoImage = vImage;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.publicText.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 270, 90, 90);
    CGPoint tCenter = self.publicText.center;
    tCenter.y += 65;
    self.publicTextImage.center = tCenter;
    
    self.publicVideo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 110, [UIScreen mainScreen].bounds.size.height - 270, 90, 90);
    CGPoint vCenter = self.publicVideo.center;
    vCenter.y += 65;
    self.publicVideoImage.center = vCenter;
    
    self.closeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3 / 4, [UIScreen mainScreen].bounds.size.height - 51, [UIScreen mainScreen].bounds.size.width / 4, 51);
}

- (void)publicTextAction:(UIButton *)sender {
    [self animationWithSender:sender];
    self.dismissHandle();
}

- (void)publicVideoAction:(UIButton *)sender {
    [self animationWithSender:sender];
    self.dismissHandle();
}

- (void)closeAction:(UIButton *)sender {
    self.dismissHandle();
}

- (void)animationWithSender:(UIButton *)sender {
    CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    centerZoom.duration = .3f;
    centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [sender.layer addAnimation:centerZoom forKey:@"buttonScale"];
}

@end
