//
//  GSCameraLibraryViewController.h
//  GirlsOrg
//
//  Created by Endless小白 on 14/12/10.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCameraDelegate.h"

@interface GSCameraLibraryViewController : UIViewController <DBCameraSegueSettings, DBCameraViewControllerSettings>

/**
 *  An id object compliant with the DBCameraContainerDelegate
 */
@property (nonatomic, weak) id <DBCameraContainerDelegate> containerDelegate;

/**
 *  An id object compliant with the DBCameraViewControllerDelegate
 */
@property (nonatomic, weak) id <DBCameraViewControllerDelegate> delegate;

/**
 *  Set the max resolution for the selected image
 */
@property (nonatomic, assign) NSUInteger libraryMaxImageSize;

/**
 *  The init method with an DBCameraContainerDelegate object
 *
 *  @param delegate The DBCameraContainerDelegate object
 *
 *  @return A DBCameraLibraryViewController
 */
- (id) initWithDelegate:(id<DBCameraContainerDelegate>)delegate;

@end
