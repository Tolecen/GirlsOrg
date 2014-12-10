//
//  GSCameraLibraryViewController.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/12/10.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSCameraLibraryViewController.h"
#import "DBCameraLoadingView.h"
#import "DBLibraryManager.h"
#import "DBCollectionViewCell.h"
#import "DBCollectionViewFlowLayout.h"
#import "DBCameraSegueViewController.h"
#import "DBCameraCollectionViewController.h"
#import "DBCameraMacros.h"

#import "UIImage+Crop.h"
#import "UIImage+TintColor.h"
#import "UIImage+Asset.h"
#import "DXPopover.h"

#ifndef DBCameraLocalizedStrings
#define DBCameraLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"DBCamera", nil)
#endif

#define kGSItemIdentifier   @"kGSItemIdentifier"
#define kGSCellIdentifier   @"kGSCellIdentifier"

@interface GSCameraLibraryViewController () <DBCameraCollectionControllerDelegate , UITableViewDataSource, UITableViewDelegate,DXPopoverDelegate> {
    UILabel *_titleLabel;
    NSMutableArray *_items;
    BOOL _isEnumeratingGroups;
    DBCameraCollectionViewController *_collectionViewController;
    CGFloat _popoverWidth;
}

@property (nonatomic, strong)   UIView *bottomContainerBar, *loading;
@property (nonatomic, weak)     NSString *selectedItemID;
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   UIImageView *jianTouV;
@property (nonatomic, strong)   DXPopover *popover;

@end

@implementation GSCameraLibraryViewController
@synthesize cameraSegueConfigureBlock = _cameraSegueConfigureBlock;
@synthesize forceQuadCrop = _forceQuadCrop;
@synthesize useCameraSegue = _useCameraSegue;
@synthesize tintColor = _tintColor;
@synthesize selectedTintColor = _selectedTintColor;

#pragma mark -- Properties

- (UIView *)loading {
    if(!_loading) {
        _loading = [[DBCameraLoadingView alloc] initWithFrame:(CGRect){ 0, 0, 100, 100 }];
        [_loading setCenter:self.view.center];
    }
    return _loading;
}

- (UIView *)bottomContainerBar
{
    if (!_bottomContainerBar) {
        _bottomContainerBar = [[UIView alloc] initWithFrame:(CGRect){0, CGRectGetHeight(self.view.bounds) - 65, CGRectGetWidth(self.view.bounds), 65}];
        [_bottomContainerBar setBackgroundColor:RGBColor(0x000000, 1)];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setBackgroundColor:[UIColor clearColor]];
        [closeButton setImage:[[UIImage imageNamed:@"close"] tintImageWithColor:self.tintColor] forState:UIControlStateNormal];
        [closeButton setFrame:(CGRect){ 10, 10, 45, 45 }];
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_bottomContainerBar addSubview:closeButton];
        
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRect){ CGRectGetMaxX(closeButton.frame), 0, CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(closeButton.bounds) * 2), CGRectGetHeight(_bottomContainerBar.bounds)}];
        _titleLabel.userInteractionEnabled = YES;
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:self.tintColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCameraLibrary:)];
        [_titleLabel addGestureRecognizer:tapGesture];
        [_bottomContainerBar addSubview:_titleLabel];
        
        self.jianTouV = [[UIImageView alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width, 10, 0, 0)];
        [self.jianTouV setImage:[UIImage imageNamed:@"lib_select_down"]];
        [_bottomContainerBar addSubview:self.jianTouV];
        self.jianTouV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCameraLibrary:)];
        [_jianTouV addGestureRecognizer:tapGesture2];
    }
    return _bottomContainerBar;
}

- (void)setLibraryMaxImageSize:(NSUInteger)libraryMaxImageSize {
    if (libraryMaxImageSize > 0)
        _libraryMaxImageSize = libraryMaxImageSize;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 20, 300)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (DXPopover *)popover {
    if (!_popover) {
        _popover = [DXPopover popover];
        _popover.delegate = self;
        _popoverWidth = CGRectGetWidth(self.view.bounds) - 20;
        __weak __typeof(self) blockSelf = self;
        __weak NSMutableArray *blockItems = _items;
        __weak DBCameraCollectionViewController *collectionViewController = _collectionViewController;
        _popover.didDismissHandler = ^ {
            if (![blockSelf.selectedItemID isEqualToString:blockItems[collectionViewController.currentIndex][@"propertyID"]]) {
                [collectionViewController setItems:(NSArray *)blockItems[collectionViewController.currentIndex][@"groupAssets"]];
                [collectionViewController.collectionView reloadData];
                [blockSelf setNavigationTitleAtIndex:collectionViewController.currentIndex];
                [blockSelf setSelectedItemID:blockItems[collectionViewController.currentIndex][@"propertyID"]];
            } else {
                NSLog(@"same carema library");
            }
        };
    }
    return _popover;
}

#pragma mark -- Life Cycle

- (instancetype)init {
    return [[GSCameraLibraryViewController alloc] initWithDelegate:nil];
}

- (id)initWithDelegate:(id<DBCameraContainerDelegate>)delegate {
    if (self = [super init]) {
        _containerDelegate = delegate;
        _items = [NSMutableArray array];
        _libraryMaxImageSize = 1900;
        
        [self setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.bottomContainerBar];
    
    _collectionViewController = [[DBCameraCollectionViewController alloc] initWithCollectionIdentifier:kGSItemIdentifier];
    [_collectionViewController setCollectionControllerDelegate:self];
    [self addChildViewController:_collectionViewController];
    [self.view addSubview:_collectionViewController.view];
    [_collectionViewController didMoveToParentViewController:self];
    [_collectionViewController.view setFrame:(CGRect){0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) -  CGRectGetHeight(_bottomContainerBar.frame)}];
    [self.view addSubview:self.loading];
    [self loadLibraryGroups];
}

- (void)dealloc {
    //备注:init之后接着走dealloc
    _items = nil;
    _tableView = nil;
    _popover = nil;
    _loading = nil;
    _bottomContainerBar = nil;
    _collectionViewController = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
#endif
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification
                                                  object:[UIApplication sharedApplication]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)applicationDidBecomeActive:(NSNotification*)notifcation {
    [self loadLibraryGroups];
}

- (void)applicationDidEnterBackground:(NSNotification*)notifcation {
    [_collectionViewController.view setAlpha:0];
}

#pragma mark -- Private

- (void)loadLibraryGroups {
    if (_isEnumeratingGroups)
        return;
    __weak NSMutableArray *blockItems = _items;
    __weak typeof(self) blockSelf = self;
    __weak DBCameraCollectionViewController *collectionViewController = _collectionViewController;
    __block BOOL isEnumeratingGroupsBlock = _isEnumeratingGroups;
    isEnumeratingGroupsBlock = YES;

    [[DBLibraryManager sharedInstance] loadGroupsAssetWithBlock:^(BOOL success, NSArray *items) {
        if (success) {
            [blockSelf.loading removeFromSuperview];
            if (items.count > 0) {
                [blockItems removeAllObjects];
                [blockItems addObjectsFromArray:items];

                [collectionViewController setCurrentIndex:0];
                [collectionViewController setItems:(NSArray *)blockItems[0][@"groupAssets"]];
                [collectionViewController.collectionView reloadData];
                [blockSelf setNavigationTitleAtIndex:0];
                [blockSelf setSelectedItemID:blockItems[0][@"propertyID"]];

                [UIView animateWithDuration:.3 animations:^{
                    [_collectionViewController.view setAlpha:1];
                }];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:DBCameraLocalizedStrings(@"general.error.title") message:DBCameraLocalizedStrings(@"pickerimage.nophoto") delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                });
            }
        }
        isEnumeratingGroupsBlock = NO;
    }];
}
-(void)dismissSelf
{
    [_jianTouV setImage:[UIImage imageNamed:@"lib_select_down"]];
}

- (void)setNavigationTitleAtIndex:(NSUInteger)index {
    [_titleLabel setText:[_items[index][@"groupTitle"] uppercaseString]];
//    CGSize theSize = [[_items[index][@"groupTitle"] uppercaseString] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:_titleLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [[_items[index][@"groupTitle"] uppercaseString] boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [_titleLabel setFrame:CGRectMake((self.view.frame.size.width-labelSize.width)/2, 0, labelSize.width, _titleLabel.frame.size.height)];
    [_jianTouV setFrame:CGRectMake(_titleLabel.frame.size.width+_titleLabel.frame.origin.x+5, 28, 15, 9)];
    
}

- (NSInteger)indexForSelectedItem {
    __weak typeof(self) blockSelf = self;
    __block NSUInteger blockIndex = -1;
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([blockSelf.selectedItemID isEqualToString:obj[@"propertyID"]]) {
            *stop = YES;
            blockIndex = idx;
        }
    }];
    return blockIndex;
}

- (void)close {
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

#pragma mark -- TapGesture

- (void)changeCameraLibrary:(UITapGestureRecognizer *)gesture {
    [self showPopover];
    [_jianTouV setImage:[UIImage imageNamed:@"lib_select_up"]];
}

- (void)showPopover {
    CGRect tableViewRect = self.tableView.bounds;
    tableViewRect.size.height = _items.count * 44;
    self.tableView.frame = tableViewRect;
    CGPoint startPoint = CGPointMake(CGRectGetMidX(_bottomContainerBar.frame), CGRectGetMinY(_bottomContainerBar.frame) - 5);
    [self.popover showAtPoint:startPoint popoverPostion:DXPopoverPositionUp withContentView:self.tableView inView:self.view];
}

#pragma mark -- UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = kGSCellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.textColor = RGBCOLOR(53, 53, 53, 1);
        cell.detailTextLabel.textColor = RGBColor(0x8b8b8b, 1);
    }
    cell.textLabel.text = _items[indexPath.row][@"groupTitle"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[_items[indexPath.row][@"groupAssets"] count]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_collectionViewController setCurrentIndex:indexPath.row];
    [self.popover dismiss];
    [_jianTouV setImage:[UIImage imageNamed:@"lib_select_down"]];
}

#pragma mark -- DBCaremaSegueDelegate

- (void)collectionView:(UICollectionView *)collectionView itemURL:(NSURL *)URL {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:self.loading];
        
        __weak typeof(self) weakSelf = self;
        [[[DBLibraryManager sharedInstance] defaultAssetsLibrary] assetForURL:URL resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
            NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithDictionary:[defaultRep metadata]];
            metadata[@"DBCameraSource"] = @"Library";
            
            UIImage *image = [UIImage imageForAsset:asset maxPixelSize:_libraryMaxImageSize];
            
            if ( !weakSelf.useCameraSegue ) {
                if ( [weakSelf.delegate respondsToSelector:@selector(camera:didFinishWithImage:withMetadata:)] )
                    [weakSelf.delegate camera:self didFinishWithImage:image withMetadata:metadata];
            } else {
                DBCameraSegueViewController *segue = [[DBCameraSegueViewController alloc] initWithImage:image thumb:[UIImage imageWithCGImage:[asset aspectRatioThumbnail]]];
                [segue setTintColor:self.tintColor];
                [segue setSelectedTintColor:self.selectedTintColor];
                [segue setForceQuadCrop:_forceQuadCrop];
                [segue enableGestures:YES];
                [segue setCapturedImageMetadata:metadata];
                [segue setDelegate:weakSelf.delegate];
                [segue setCameraSegueConfigureBlock:self.cameraSegueConfigureBlock];
                
                [weakSelf.navigationController pushViewController:segue animated:YES];
            }
            
            [weakSelf.loading removeFromSuperview];
        } failureBlock:nil];
    });
}

@end
