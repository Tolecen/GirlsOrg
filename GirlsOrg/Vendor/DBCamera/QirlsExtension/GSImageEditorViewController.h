//
//  GSImageEditorViewController.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 2/28/15.
//  Copyright (c) 2015 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCameraDelegate.h"

@interface GSImageEditorViewController : UIViewController

@property (nonatomic, weak) id <DBCameraContainerDelegate> containerDelegate;
@property (nonatomic, strong) NSDictionary *capturedImageMetadata;

- (id)initWithImage:(UIImage *)image
              thumb:(UIImage *)thumb
           delegate:(id<DBCameraContainerDelegate>)delegate;

@end
