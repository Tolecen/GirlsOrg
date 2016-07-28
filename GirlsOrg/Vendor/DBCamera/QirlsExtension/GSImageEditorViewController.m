//
//  GSImageEditorViewController.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 2/28/15.
//  Copyright (c) 2015 uzero. All rights reserved.
//

#import "GSImageEditorViewController.h"
#import "GSImageEditorHeaderView.h"
#import "GSImageEditorToolbar.h"

@interface GSImageEditorViewController ()<GSImageEditorHeaderDelegate>

@property (nonatomic, weak) GSImageEditorHeaderView *editorHeaderView;
@property (nonatomic, weak) GSImageEditorToolbar    *editorToolbar;
@property (nonatomic, weak) UIImageView *preViewImageView;

@property (nonatomic, strong) UIImage *sourceImage;

@end

@implementation GSImageEditorViewController

#pragma mark -- Life Cycle

- (id)initWithImage:(UIImage *)image
              thumb:(UIImage *)thumb
           delegate:(id<DBCameraContainerDelegate>)delegate {
    if (self = [super init]) {
        _sourceImage = image;
        _containerDelegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GSImageEditorHeaderView *editorHeaderView = [[GSImageEditorHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), DefaultNaviHeight)];
    editorHeaderView.delegate = self;
    [self.view addSubview:editorHeaderView];
    self.editorHeaderView = editorHeaderView;
    
    GSImageEditorToolbar *editorToolbar = [[GSImageEditorToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - DefaultCameraToolbarHeight, CGRectGetWidth(self.view.frame), DefaultCameraToolbarHeight)];
    [self.view addSubview:editorToolbar];
    self.editorToolbar = editorToolbar;
    
    UIImageView *preViewImageView = [[UIImageView alloc] initWithFrame:
                                     CGRectMake(0,
                                                DefaultNaviHeight,
                                                Screen_Width,
                                                Screen_Height-DefaultNaviHeight-DefaultCameraToolbarHeight)];
    [self.view addSubview:preViewImageView];
    self.preViewImageView = preViewImageView;
    preViewImageView.image = self.sourceImage;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

#pragma mark -- Header

- (void)headerLeftButtonSelected {
    if (!self.containerDelegate) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        [self.view setAlpha:0];
        [self.view setTransform:CGAffineTransformMakeScale(.8, .8)];
    } completion:^(BOOL finished) {
        [self.containerDelegate backFromController:self];
    }];
}

- (void)headerRightButtonSelected {
    
}

#pragma mark -- Toolbar

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _sourceImage = nil;
    _capturedImageMetadata = nil;
}

@end
