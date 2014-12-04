//
//  GSMenuScroll.m
//  PeopleDaily2014
//
//  Created by Endless小白 on 14/12/1.
//  Copyright (c) 2014年 people. All rights reserved.
//

#define kGSMenuScrollDefaultHeight      30.f
#define kGSMenuManagerBtnDefaultWidth   40.f
#define kGSMenuButtonDefaultHeight      30.f
#define kGSMenuLeftShadowPadding        0.f//2.f
#define kGSMenuButtonPaddingX           0.f//30.f
#define kGSMenuButtonStarX              0.f//10.f
#define kGSMenuButtonBaseTag            100

#import "GSMenuScroll.h"
#import "GSScrollView.h"
#import "UIScrollView+visiableCenterScroll.h"


@interface GSMenuScroll()<UIScrollViewDelegate>

@property (nonatomic, weak) GSScrollView *scrollView;


@property (nonatomic, weak) UIImageView *leftShadowImageV;
@property (nonatomic, weak) UIImageView *rightShadowImageV;
@property (nonatomic, weak) UIButton *menuManagerBtn;
@property (nonatomic, strong) NSMutableArray *menuButtons;

@end

@implementation GSMenuScroll

#pragma mark -- UI Config

- (void)addScrollView {
    CGFloat originX = self.showLeftShadow ? CGRectGetMaxX(self.leftShadowImageV.frame) : 0;
    CGFloat rightMargin = self.showRightShadow ? CGRectGetWidth(self.rightShadowImageV.frame) : 0;
    rightMargin += (self.showManagerButton ? CGRectGetWidth(self.menuManagerBtn.frame) : 0);
    CGFloat width = CGRectGetWidth(self.bounds) - originX - rightMargin;
    GSScrollView *scrollView = [[GSScrollView alloc] initWithFrame:CGRectMake(originX, 0, width, CGRectGetHeight(self.bounds))];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

- (UIImageView *)addShadowImageV:(BOOL)isLeft {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kGSMenuLeftShadowPadding, 0, 7, CGRectGetHeight(self.bounds))];
    imageV.autoresizingMask = isLeft ? UIViewAutoresizingFlexibleRightMargin : UIViewAutoresizingFlexibleLeftMargin;
    imageV.backgroundColor = [UIColor clearColor];
    imageV.image = isLeft ? [UIImage imageNamed:@"leftShadow"] : [UIImage imageNamed:@"rightShadow"];
    return imageV;
}

- (void)addIndicatorView {
    GSIndicatorView *indicatorView = [GSIndicatorView indicatorView];
    indicatorView.backgroundColor = [UIColor greenColor];
    indicatorView.alpha = 0.f;
    [self.scrollView addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

- (void)addMenuManagerBtn {
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - kGSMenuManagerBtnDefaultWidth,
                               0,
                               kGSMenuManagerBtnDefaultWidth,
                               CGRectGetHeight(self.bounds));
    [menuBtn setImage:[UIImage imageNamed:@"managerMenuButton"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuManagerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuBtn];
    self.menuManagerBtn = menuBtn;
}

#pragma mark -- Life Cycle

- (void)configDefault {
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.showLeftShadow = NO;
    self.showRightShadow = NO;
    self.showManagerButton = NO;
    self.shouldUniformizeMenus = YES;
    self.selectedItemIndex = 0;
}

- (void)setUp {
    if (self.showManagerButton) {
        [self addMenuManagerBtn];
    }
    if (self.showLeftShadow) {
        UIImageView *leftShadow = [self addShadowImageV:YES];
        [self addSubview:leftShadow];
        self.leftShadowImageV = leftShadow;
    }
    if (self.showRightShadow) {
        UIImageView *rightShadow = [self addShadowImageV:NO];
        CGRect rightShadowViewFrame = rightShadow.frame;
        rightShadowViewFrame.origin = CGPointMake((self.showManagerButton ?
                                                   CGRectGetMinX(_menuManagerBtn.frame) :CGRectGetWidth(self.bounds)) - CGRectGetWidth(rightShadowViewFrame),
                                                  0);
        rightShadow.frame = rightShadowViewFrame;
        [self addSubview:rightShadow];
        self.rightShadowImageV = rightShadow;
    }
    [self addScrollView];
    [self addIndicatorView];
    [self sendSubviewToBack:self.scrollView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configDefault];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self setUp];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc {
    _menuButtons = nil;
    _menus = nil;
}

#pragma mark -- Properties

- (NSMutableArray *)menuButtons {
    if (!_menuButtons) {
        _menuButtons = [NSMutableArray arrayWithArray:self.menus];
    }
    return _menuButtons;
}

#pragma mark -- Action

- (void)menuButtonSelected:(UIButton *)sender {
    [self.menuButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj == sender) {
            sender.selected = YES;
        } else {
            UIButton *menuButton = obj;
            menuButton.selected = NO;
        }
    }];
    if (ABS(sender.tag - kGSMenuButtonBaseTag - self.selectedItemIndex) >= 2) {
        [self setSelectedIndex:sender.tag - kGSMenuButtonBaseTag animated:NO calledDelegate:YES];
    } else {
        [self setSelectedIndex:sender.tag - kGSMenuButtonBaseTag animated:YES calledDelegate:YES];
    }
}

- (void)menuManagerAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(menuScrollDidManagerSelected:)]) {
        [self.delegate menuScrollDidManagerSelected:self];
    }
}

#pragma mark -- Private

- (UIButton *)buttonWithMenu:(GSMenu *)menu {
//    CGSize btnSize = [menu.title boundingRectWithSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.bounds) - 10)
//                                              options:NSStringDrawingUsesLineFragmentOrigin
//                                           attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16.f]}
//                                              context:nil].size;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) / self.menus.count, kGSMenuScrollDefaultHeight);
//    btn.frame = CGRectMake(0, 0, btnSize.width, kGSMenuButtonDefaultHeight);
    btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitle:menu.title forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"表格_按下"] forState:UIControlStateHighlighted];
    [btn setTitleColor:RGBCOLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setupIndicatorFrame:(CGRect)menuButtonFrame animated:(BOOL)animated callDelegate:(BOOL)called {
    [UIView animateWithDuration:(animated ? 0.15 : 0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _indicatorView.frame = CGRectMake(CGRectGetMinX(menuButtonFrame), CGRectGetHeight(self.bounds) - kGSMenuIndicatorDefaultHeight, CGRectGetWidth(menuButtonFrame), kGSMenuIndicatorDefaultHeight);
    } completion:^(BOOL finished) {
        if (called) {
            if ([self.delegate respondsToSelector:@selector(menuScrollDidSelected:menuIndex:)]) {
                [self.delegate menuScrollDidSelected:self menuIndex:self.selectedItemIndex];
            }
        }
    }];
}

#pragma mark -- Public

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate {
    if (_selectedItemIndex == selectedIndex) {
        return;
    }
    UIButton *towardsButton = [self.menuButtons objectAtIndex:selectedIndex];
    towardsButton.selected = YES;
    
    UIButton *prousButton = [self.menuButtons objectAtIndex:_selectedItemIndex];
    prousButton.selected = (_selectedItemIndex == selectedIndex && !selectedIndex);
    
    _selectedItemIndex = selectedIndex;
    UIButton *selectedMenuButton = [self menuButtonAtIndex:_selectedItemIndex];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.scrollView scrollRectToVisibleCenteredOn:selectedMenuButton.frame animated:NO];
    } completion:^(BOOL finished) {
        [self setupIndicatorFrame:selectedMenuButton.frame animated:aniamted callDelegate:calledDelgate];
    }];
}

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index {
    CGRect rect = ((UIView *)self.menuButtons[index]).frame;
    return rect;
}

- (UIButton *)menuButtonAtIndex:(NSUInteger)index {
    return self.menuButtons[index];
}

- (void)reloadData {
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [(UIButton *)obj removeFromSuperview];
        }
    }];
    if (self.menuButtons.count) {
        [self.menuButtons removeAllObjects];
    }
    
//    CGFloat __block totalWidth = 10;
//    CGFloat __block totalButtonWidth = 0;
//    CGFloat __block contentWidth = 10;
//    [self.menus enumerateObjectsUsingBlock:^(GSMenu *menu, NSUInteger idx, BOOL *stop) {
//        UIButton *menuButton = [self buttonWithMenu:menu];
//        menuButton.tag = (NSInteger)(kGSMenuButtonBaseTag + idx);
//        CGRect menuButtonFrame = menuButton.frame;
//        if (idx > 0) {
//            totalWidth += kGSMenuButtonPaddingX + menuButtonFrame.size.width;
//        } else {
//            totalWidth = kGSMenuButtonStarX;
//        }
//        totalButtonWidth += menuButtonFrame.size.width;
//    }];
//    
//    [self.menus enumerateObjectsUsingBlock:^(GSMenu *menu, NSUInteger idx, BOOL *stop) {
//        UIButton *menuButton = [self buttonWithMenu:menu];
//        menuButton.tag = (NSInteger)(kGSMenuButtonBaseTag + idx);
//        CGRect menuButtonFrame = menuButton.frame;
//        CGFloat buttonX = 0;
//        if (self.shouldUniformizeMenus && totalWidth < CGRectGetWidth(self.scrollView.bounds)) {
//            CGFloat newPadding = (CGRectGetWidth(self.scrollView.bounds) - totalButtonWidth) / (self.menus.count + 1);
//            if (idx > 0) {
//                buttonX = newPadding + CGRectGetMaxX(((UIButton *)(self.menuButtons[idx - 1])).frame);
//            } else {
//                buttonX = newPadding;
//            }
//        }
//        else {
//            if (idx > 0) {
//                buttonX = kGSMenuButtonPaddingX + CGRectGetMaxX(((UIButton *)(self.menuButtons[idx - 1])).frame);
//            } else {
//                buttonX = kGSMenuButtonStarX;
//            }
//        }
//        
//        menuButtonFrame.origin = CGPointMake(buttonX, CGRectGetMidY(self.bounds) - (CGRectGetHeight(menuButtonFrame) / 2.0));
//        menuButton.frame = menuButtonFrame;
//        [self.scrollView addSubview:menuButton];
//        [self.menuButtons addObject:menuButton];
//        
//        if (idx == self.menus.count - 1) {
//            contentWidth += CGRectGetMaxX(menuButtonFrame);
//        }
//        
//        if (self.selectedItemIndex == idx) {
//            menuButton.selected = YES;
//            _indicatorView.alpha = 1.;
//            [self setupIndicatorFrame:menuButtonFrame animated:NO callDelegate:NO];
//        }
//    }];
//    [self.scrollView setContentSize:CGSizeMake(contentWidth, CGRectGetHeight(self.scrollView.frame))];
    
    [self.menus enumerateObjectsUsingBlock:^(GSMenu *menu, NSUInteger idx, BOOL *stop) {
        UIButton *menuButton = [self buttonWithMenu:menu];
        menuButton.tag = (NSInteger)(kGSMenuButtonBaseTag + idx);
        CGRect menuButtonFrame = menuButton.frame;
        CGFloat buttonX = 0;
        if (idx > 0) {
            buttonX = CGRectGetMaxX(((UIButton *)(self.menuButtons[idx - 1])).frame);
        }
        menuButtonFrame.origin = CGPointMake(buttonX, CGRectGetMidY(self.bounds) - (CGRectGetHeight(menuButtonFrame) / 2.0));
        menuButton.frame = menuButtonFrame;
        [self.scrollView addSubview:menuButton];
        [self.menuButtons addObject:menuButton];

        if (self.selectedItemIndex == idx) {
            menuButton.selected = YES;
            _indicatorView.alpha = 1.;
            [self setupIndicatorFrame:menuButtonFrame animated:NO callDelegate:NO];
        }
    }];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.scrollView.frame))];

    [self setSelectedIndex:self.selectedItemIndex animated:NO calledDelegate:YES];
}

#pragma mark -- ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat contentSizeWidth = (NSInteger)scrollView.contentSize.width;
    CGFloat scrollViewWidth = CGRectGetWidth(scrollView.bounds);
    if (contentSizeWidth == scrollViewWidth) {
        self.leftShadowImageV.hidden = YES;
        self.rightShadowImageV.hidden = YES;
    } else if (contentSizeWidth <= scrollViewWidth) {
        self.leftShadowImageV.hidden = YES;
        self.rightShadowImageV.hidden = YES;
    } else {
        if (contentOffsetX > 0) {
            self.leftShadowImageV.hidden = NO;
        } else {
            self.leftShadowImageV.hidden = YES;
        }
        
        if ((contentOffsetX + scrollViewWidth) >= contentSizeWidth) {
            self.rightShadowImageV.hidden = YES;
        } else {
            self.rightShadowImageV.hidden = NO;
        }
    }
}

@end
