//
//  FSMaskControl.h
//  DXPopoverDemo
//
//  Created by Endless小白 on 14/12/10.
//  Copyright (c) 2014年 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FSMaskType) {
    FSMaskTypeBlack,
    FSMaskTypeNone,
};

@interface FSMaskControl : UIControl

@property (nonatomic, assign) FSMaskType maskType;

@property (nonatomic, assign) CGFloat animationIn;

@property (nonatomic, assign) CGFloat animationOut;

@property (nonatomic, copy) dispatch_block_t didDismissHandler;

@property (nonatomic, copy) dispatch_block_t didShowHandler;

- (instancetype)initWithContainerView:(UIView *)containerView;

- (void)showInTargetView:(UIView *)targetView;

- (void)showInTargetView;

- (void)dismiss;

@end
