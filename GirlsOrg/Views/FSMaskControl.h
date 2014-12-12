//
//  FSMaskControl.h
//  DXPopoverDemo
//
//  Created by Endless小白 on 14/12/10.
//  Copyright (c) 2014年 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
typedef NS_ENUM(NSUInteger, FSMaskType) {
    FSMaskTypeBlack,
    FSMaskTypeNone,
};

@protocol MaskViewButtonClickedDelegate <NSObject>

-(void)blurMaskDidClickedBtnIndex:(NSInteger)index;

@end

@interface FSMaskControl : UIControl

@property (nonatomic, assign) FSMaskType maskType;

@property (nonatomic, assign) id <MaskViewButtonClickedDelegate> delegate;

@property (nonatomic, assign) CGFloat animationIn;

@property (nonatomic, assign) CGFloat animationOut;

@property (nonatomic, copy) dispatch_block_t didDismissHandler;

@property (nonatomic, copy) dispatch_block_t didShowHandler;

- (instancetype)initWithContainerView:(UIView *)containerView;

- (void)showInTargetView:(UIView *)targetView;

- (void)showInTargetView;

- (void)dismissIndex:(NSInteger)index;

@end
