//
//  GSImageEditorHeaderView.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 2/28/15.
//  Copyright (c) 2015 uzero. All rights reserved.
//

#import "GSImageEditorHeaderView.h"

@interface GSImageEditorHeaderView()

@property (nonatomic, weak) UIButton *leftBarButton;
@property (nonatomic, weak) UIButton *rightBarButton;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation GSImageEditorHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {        
        UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBarButton.frame = CGRectMake(0, 20, DefaultNavigationBarButtonWidth, DefaultNavigationBarButtonHeight);
        [leftBarButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
        [leftBarButton addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBarButton];
        self.leftBarButton = leftBarButton;
        
        UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarButton.frame = CGRectMake(frame.size.width - DefaultNavigationBarButtonWidth, 20, DefaultNavigationBarButtonWidth, DefaultNavigationBarButtonHeight);
        [rightBarButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
        [rightBarButton addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBarButton];
        self.rightBarButton = rightBarButton;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBarButton.frame), 20, self.bounds.size.width - 2 * DefaultNavigationBarButtonWidth, DefaultNavigationBarButtonHeight)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        titleLabel.text = @"照片编辑器";
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)leftBarButtonAction:(UIButton *)sender {
    [self.delegate headerLeftButtonSelected];
}

- (void)rightBarButtonAction:(UIButton *)sender {
    [self.delegate headerRightButtonSelected];
}

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    if (newSuperview == nil) {
//        return;
//    }
//    [super willMoveToSuperview:newSuperview];
//}

@end
