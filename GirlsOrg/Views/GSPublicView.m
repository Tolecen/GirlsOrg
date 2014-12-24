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
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        [self addGestureRecognizer:tap];
        UIButton *publicText = [self buttonWithImage:@"camrea_btn" selector:@selector(publicTextAction:)];
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
        tImage.alpha = 0.7;
        self.publicTextImage = tImage;
        
        UIImageView *vImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        vImage.image = [UIImage imageNamed:@"视频_"];
        [vImage sizeToFit];
        [self addSubview:vImage];
        vImage.alpha = 0.7;
        self.publicVideoImage = vImage;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.publicText.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-90*2-40)/2, [UIScreen mainScreen].bounds.size.height - 270, 90, 90);
    CGPoint tCenter = self.publicText.center;
    tCenter.y += 65;
    self.publicTextImage.center = tCenter;
    
    self.publicVideo.frame = CGRectMake(self.publicText.frame.origin.x+90+40, [UIScreen mainScreen].bounds.size.height - 270, 90, 90);
    CGPoint vCenter = self.publicVideo.center;
    vCenter.y += 65;
    self.publicVideoImage.center = vCenter;
    
    self.closeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3 / 4, [UIScreen mainScreen].bounds.size.height - 51, [UIScreen mainScreen].bounds.size.width / 4, 51);
}

- (void)publicTextAction:(UIButton *)sender {
    [self animationWithSender:sender];
    self.dismissHandle(1);
}

- (void)publicVideoAction:(UIButton *)sender {
    [self animationWithSender:sender];
    self.dismissHandle(2);
}

- (void)closeAction:(UIButton *)sender {
    self.dismissHandle(0);
}

-(void)animationDo
{
    [self animationWithSender:self.publicText];
    [self animationWithSender:self.publicVideo];
}

- (void)animationWithSender:(UIButton *)sender {
    CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    centerZoom.duration = .3f;
    centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [sender.layer addAnimation:centerZoom forKey:@"buttonScale"];
}

@end
