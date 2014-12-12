//
//  FSMaskControl.m
//  DXPopoverDemo
//
//  Created by Endless小白 on 14/12/10.
//  Copyright (c) 2014年 xiekw. All rights reserved.
//

#import "FSMaskControl.h"

@interface FSMaskControl()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation FSMaskControl

- (instancetype)initWithContainerView:(UIView *)containerView {
    if (self = [super init]) {
        [self setUp];
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return self;
}

- (void)setUp {
    self.maskType = FSMaskTypeBlack;
    self.animationIn = 0.4;
    self.animationOut = 0.3;
    self.alpha = 0.f;
    self.frame = [UIScreen mainScreen].bounds;
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMaskType:(FSMaskType)maskType {
    UIColor *maskColor;
    switch (maskType) {
        case FSMaskTypeBlack:
            maskColor = [UIColor colorWithWhite:0.3 alpha:0.55];
            break;
        case FSMaskTypeNone:
            maskColor = [UIColor clearColor];
            break;
        default:
            break;
    }
    self.backgroundColor = maskColor;
}

- (void)showInTargetView {
    [self showInTargetView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInTargetView:(UIView *)targetView {
    [UIView animateWithDuration:.5f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [targetView addSubview:self];
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.didShowHandler) {
                self.didShowHandler();
            }
        }
    }];
}

- (void)dismiss {
    if (self.superview) {
        [UIView animateWithDuration:self.animationOut delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                if (self.didDismissHandler) {
                    self.didDismissHandler();
                }
            }
        }];
    }
}


@end
