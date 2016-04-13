//
//  GSTabBarController.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSTabBarController.h"
#import "UIViewController+GSTarBarController.h"
#import "GSBaseViewController.h"
#import "FSMaskControl.h"
#import "GSPublicView.h"
#import "FXBlurView.h"
#import "GSLogInViewController.h"
#import "SFHFKeychainUtils.h"
// Default height of the tab bar
static const int kDefaultTabBarHeight = 44;

// Default Push animation duration
static const float kPushAnimationDuration = 0.25;

@interface GSTabBarController ()<MaskViewButtonClickedDelegate> {
    NSArray *prevViewControllers;
    BOOL visible;
    // Bottom tab bar view
    
    
    // Content view
    GSTabBarView *tabBarView;
    
    // Tab Bar height
    NSUInteger tabBarHeight;
}

// Current active view controller
@property (nonatomic, strong) UINavigationController *selectedViewController;

@property (nonatomic, strong) FSMaskControl *maskControl;

@property (nonatomic, strong) GSPublicView *publicView;

@property (nonatomic,strong)FXBlurView * fBlurV;

- (void)loadTabs;


@end

@implementation GSTabBarController

- (FSMaskControl *)maskControl {
    if (!_maskControl) {
        _maskControl = [[FSMaskControl alloc] initWithContainerView:self.publicView];
        __block GSTabBar *_bTabBar = tabBar;
        _maskControl.didDismissHandler = ^ {
            [UIView animateWithDuration:.5f animations:^{
                [_bTabBar.tabs.lastObject setTabImageWithName:@"home_tab_icon_4"];
            }];
        };
    }
    return _maskControl;
}

- (GSPublicView *)publicView {
    if (!_publicView) {
        _publicView = [[GSPublicView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        __weak __typeof(self) wSelf = self;
        [_publicView setDismissHandle:^(NSInteger index) {
            NSLog(@"theIndex:%ld",(long)index);
            [wSelf.maskControl dismissIndex:index];
        }];
    }
    return _publicView;
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    // Setting the default tab bar height
    tabBarHeight = kDefaultTabBarHeight;
    
    return self;
}

- (id)initWithTabBarHeight:(NSUInteger)height
{
    self = [super init];
    if (!self) return nil;
    
    tabBarHeight = height;
    
    return self;
}

- (void)loadView
{
    [super loadView];

    // Creating and adding the tab bar view
    tabBarView = [[GSTabBarView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = tabBarView;
    
    // Creating and adding the tab bar
    CGRect tabBarRect = CGRectMake(0.0, CGRectGetHeight(self.view.bounds) - tabBarHeight, CGRectGetWidth(self.view.frame), tabBarHeight);
    tabBar = [[GSTabBar alloc] initWithFrame:tabBarRect];
    tabBar.delegate = self;
    
    tabBarView.tabBar = tabBar;
    tabBarView.contentView = _selectedViewController.view;
    [[self navigationItem] setTitle:[_selectedViewController title]];
    [self loadTabs];
}

- (void)loadTabs
{
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.viewControllers)
    {
        [[tabBarView tabBar] setBackgroundImageName:[self backgroundImageName]];
        [[tabBarView tabBar] setTabColors:[self tabCGColors]];
        [[tabBarView tabBar] setEdgeColor:[self tabEdgeColor]];

        GSTab *tab = [[GSTab alloc] init];
        [tab setTabImageWithName:[vc tabImageName]];
        [tab setBackgroundImageName:[self backgroundImageName]];
        [tab setSelectedBackgroundImageName:[self selectedBackgroundImageName]];
        [tab setTabIconColors:[self iconCGColors]];
        [tab setTabIconColorsSelected:[self selectedIconCGColors]];
        [tab setTabSelectedColors:[self selectedTabCGColors]];
        [tab setEdgeColor:[self tabEdgeColor]];
        [tab setGlossyIsHidden:[self iconGlossyIsHidden]];
        [tab setStrokeColor:[self tabStrokeColor]];
        [tab setTextColor:[self textColor]];
        [tab setSelectedTextColor:[self selectedTextColor]];
        [tab setTabTitle:[vc tabTitle]];
        
        [tab setTabBarHeight:tabBarHeight];
        
        if (_minimumHeightToDisplayTitle)
            [tab setMinimumHeightToDisplayTitle:_minimumHeightToDisplayTitle];
        
        if (_tabTitleIsHidden)
            [tab setTitleIsHidden:YES];
        
        if ([vc isEqual:self.viewControllers.lastObject]) {
            tab.delegate = self;
            [tab setRecognizerLongPress:YES];
        } else {
            [tab setRecognizerLongPress:NO];
        }
        
        if ([[vc class] isSubclassOfClass:[UINavigationController class]])
            ((UINavigationController *)vc).delegate = self;
        
        [tabs addObject:tab];
    }
    
    [tabBar setTabs:tabs];
    
    // Setting the first view controller as the active one
    [tabBar setSelectedTab:[tabBar.tabs objectAtIndex:0]];
}

- (NSArray *)selectedIconCGColors
{
    return _selectedIconColors ? @[(id)[[_selectedIconColors objectAtIndex:0] CGColor], (id)[[_selectedIconColors objectAtIndex:1] CGColor]] : nil;
}

- (NSArray *)iconCGColors
{
    return _iconColors ? @[(id)[[_iconColors objectAtIndex:0] CGColor], (id)[[_iconColors objectAtIndex:1] CGColor]] : nil;
}

- (NSArray *)tabCGColors
{
    return _tabColors ? @[(id)[[_tabColors objectAtIndex:0] CGColor], (id)[[_tabColors objectAtIndex:1] CGColor]] : nil;
}

- (NSArray *)selectedTabCGColors
{
    return _selectedTabColors ? @[(id)[[_selectedTabColors objectAtIndex:0] CGColor], (id)[[_selectedTabColors objectAtIndex:1] CGColor]] : nil;
}

#pragma - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    prevViewControllers = [navigationController viewControllers];
//    if (prevViewControllers.count>1)
//        [self hideTabBar:GSShowHideFromRight animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    prevViewControllers = [navigationController viewControllers];
    if (prevViewControllers.count>1)
        [self hideTabBar:GSShowHideFromRight animated:animated];
    else
        [self showTabBar:GSShowHideFromLeft animated:animated];
}

- (void)showTabBar:(GSShowHideFrom)showHideFrom animated:(BOOL)animated
{
    
    CGFloat directionVector;
    
    switch (showHideFrom) {
        case GSShowHideFromLeft:
            directionVector = -1.0;
            break;
        case GSShowHideFromRight:
            directionVector = 1.0;
            break;
        default:
            break;
    }
    
    tabBar.hidden = NO;
    tabBar.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) * directionVector, 0);
    // when the tabbarview is resized we can see the view behind
    
    [UIView animateWithDuration:((animated) ? kPushAnimationDuration : 0) animations:^{
        tabBar.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        tabBarView.isTabBarHidding = NO;
        [tabBarView setNeedsLayout];
    }];
}

- (void)hideTabBar:(GSShowHideFrom)showHideFrom animated:(BOOL)animated
{
    
    CGFloat directionVector;
    switch (showHideFrom) {
        case GSShowHideFromLeft:
            directionVector = 1.0;
            break;
        case GSShowHideFromRight:
            directionVector = -1.0;
            break;
        default:
            break;
    }
    
    tabBarView.isTabBarHidding = YES;
    
    CGRect tmpTabBarView = tabBarView.contentView.frame;
    tmpTabBarView.size.height = tabBarView.bounds.size.height;
    tabBarView.contentView.frame = tmpTabBarView;
    
    [UIView animateWithDuration:((animated) ? kPushAnimationDuration : 0) animations:^{
        tabBar.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) * directionVector, 0);
    } completion:^(BOOL finished) {
        tabBar.hidden = YES;
        tabBar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - Setters

- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    // When setting the view controllers, the first vc is the selected one;
    [self setSelectedViewController:[viewControllers objectAtIndex:0]];
}

- (void)setSelectedViewController:(UINavigationController *)selectedViewController
{
    UIViewController *previousSelectedViewController = selectedViewController;
    if (_selectedViewController != selectedViewController)
    {
        
        _selectedViewController = selectedViewController;
        selectedViewController = selectedViewController;
        
        if (!self.childViewControllers && visible)
        {
            [previousSelectedViewController viewWillDisappear:NO];
            [selectedViewController viewWillAppear:NO];
        }
        
        [tabBarView setContentView:selectedViewController.view];
        
        if (!self.childViewControllers && visible)
        {
            [previousSelectedViewController viewDidDisappear:NO];
            [selectedViewController viewDidAppear:NO];
        }
        
        [tabBar setSelectedTab:[tabBar.tabs objectAtIndex:[self.viewControllers indexOfObject:selectedViewController]]];
    }
}

#pragma mark - Required Protocol Method

- (void)tabBar:(GSTabBar *)AKTabBarDelegate didSelectTabAtIndex:(NSInteger)index
{
    if (index == ([[tabBar tabs] count] - 1)) {
        
        
        GSTab *tab = [tabBar tabs][index];
        if ([tab.tabImageWithName isEqualToString:@"home_tab_icon_5"]) {
            tab.tabImageWithName = @"home_tab_icon_4";
        }
        else
        {
//            GSBaseViewController * baseV = (GSBaseViewController *)self.selectedViewController.viewControllers[0];
//            [baseV openCamera];

            tab.tabImageWithName = nil;
            [self.maskControl showInTargetView];
            self.maskControl.delegate = self;

        }
    } else {
        UINavigationController *vc = [self.viewControllers objectAtIndex:index];
        if (self.selectedViewController == vc)
        {
            if ([vc isKindOfClass:[UINavigationController class]])
                [(UINavigationController *)self.selectedViewController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [[self navigationItem] setTitle:[vc title]];
            self.selectedViewController = vc;
        }
    }
}

-(void)blurMaskDidClickedBtnIndex:(NSInteger)index
{
    
    if (![GSUserInfo isLogin]) {
        GSLogInViewController * loginV = [[GSLogInViewController alloc] init];
        UINavigationController * logNavi = [[UINavigationController alloc] initWithRootViewController:loginV];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNavi animated:YES completion:nil];
        return;
    }
    
    if (index==1) {
        GSBaseViewController * baseV = (GSBaseViewController *)self.selectedViewController.viewControllers[0];
        [baseV openCamera];
    }
    else if (index==2){
        GSBaseViewController * baseV = (GSBaseViewController *)self.selectedViewController.viewControllers[0];
        [baseV openCamera];
        NSLog(@"222222");
    }
}

- (void)tabDidRecognizerLongPress:(GSTab *)GSTab {
    GSTab.tabImageWithName = nil;
    [self.maskControl showInTargetView];
}

#pragma mark - Rotation Events

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.selectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    // Redraw with will rotating and keeping the aspect ratio
    for (GSTab *tab in [tabBar tabs])
        [tab setNeedsDisplay];
    
    [self.selectedViewController willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - ViewController Life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewDidAppear:animated];
    
    visible = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (![self respondsToSelector:@selector(addChildViewController:)])
        [self.selectedViewController viewDidDisappear:animated];
    
    visible = NO;
}

@end
