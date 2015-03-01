//
//  GSImageEditorHeaderView.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 2/28/15.
//  Copyright (c) 2015 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GSImageEditorHeaderDelegate <NSObject>

- (void)headerLeftButtonSelected;
- (void)headerRightButtonSelected;

@end

//typedef NS_ENUM(NSUInteger, GSImageEditorHeaderType) {
//    GSImageEditorHeaderTypeCrop     = 0,
//    GSImageEditorHeaderTypeFliter   = 1
//};

@interface GSImageEditorHeaderView : UIView

@property (nonatomic, weak) id<GSImageEditorHeaderDelegate> delegate;

@end
