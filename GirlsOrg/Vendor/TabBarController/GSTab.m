//
//  GSTab.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSTab.h"

// cross fade animation duration.
static const float kAnimationDuration = 0.15;

// Padding of the content
static const float kPadding = 4.0;

// Margin between the image and the title
static const float kMargin = 2.0;

// Margin at the top
static const float kTopMargin = 0.0;

@interface GSTab()

- (void)animateContentWithDuration:(CFTimeInterval)duration;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation GSTab

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor clearColor];
        _titleIsHidden = NO;
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(customTabAction:)];
        longPressGesture.minimumPressDuration = .5f;
        [self addGestureRecognizer:longPressGesture];
        self.longPressGesture = longPressGesture;
    }
    return self;
}

#pragma mark - Touche handeling

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self animateContentWithDuration:kAnimationDuration];
}

- (void)customTabAction:(UILongPressGestureRecognizer *)longPressGesture {
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
            if ([self.delegate respondsToSelector:@selector(tabDidRecognizerLongPress:)]) {
                [self.delegate tabDidRecognizerLongPress:self];
            }
            break;
        case UIGestureRecognizerStateRecognized:
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
            break;
        default:
            break;
    }

}

- (void)setRecognizerLongPress:(BOOL)recognizerLongPress {
    self.longPressGesture.enabled = recognizerLongPress;
}

#pragma mark - Animation

- (void)animateContentWithDuration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:@"contents"];
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)setTabImageWithName:(NSString *)tabImageWithName {
    _tabImageWithName = tabImageWithName;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // If the height of the container is too short, we do not display the title
    CGFloat offset = 1.0;
    
    if (!_minimumHeightToDisplayTitle)
        _minimumHeightToDisplayTitle = _tabBarHeight - offset;
    
    BOOL displayTabTitle = (CGRectGetHeight(rect) + offset >= _minimumHeightToDisplayTitle) ? YES : NO;
    
    if (_titleIsHidden) {
        displayTabTitle = NO;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // Container, basically centered in rect
    CGRect container = CGRectInset(rect, kPadding, kPadding);
    container.size.height -= kTopMargin;
    container.origin.y += kTopMargin;

    // Tab's image
    UIImage *image = [UIImage imageNamed:_tabImageWithName];
    // Setting the imageContainer's size.
    CGRect imageRect = CGRectZero;
    imageRect.size = image.size;

    // Title label
    UILabel *tabTitleLabel = [[UILabel alloc] init];
    tabTitleLabel.text = _tabTitle;
    tabTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingMiddle;
    style.alignment = NSTextAlignmentCenter;

    CGSize labelSize = [tabTitleLabel.text boundingRectWithSize:rect.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: tabTitleLabel.font, NSParagraphStyleAttributeName: style} context:nil].size;
    
    CGRect labelRect = CGRectZero;
    
    labelRect.size.height = (displayTabTitle) ? labelSize.height : 0;
    
    // Container of the image + label (when there is room)
    CGRect content = CGRectZero;
    content.size.width = CGRectGetWidth(container);
    
    // We determine the height based on the longest side of the image (when not square) , presence of the label and height of the container
    content.size.height = MIN(MAX(CGRectGetWidth(imageRect), CGRectGetHeight(imageRect)) + ((displayTabTitle) ? (kMargin + CGRectGetHeight(labelRect)) : 0), CGRectGetHeight(container));
    
    // Now we move the boxes
    content.origin.x = floorf(CGRectGetMidX(container) - CGRectGetWidth(content) / 2);
    content.origin.y = floorf(CGRectGetMidY(container) - CGRectGetHeight(content) / 2);
    
    labelRect.size.width = CGRectGetWidth(content);
    labelRect.origin.x = CGRectGetMinX(content);
    labelRect.origin.y = CGRectGetMaxY(content) - CGRectGetHeight(labelRect);
    
    if (!displayTabTitle) {
        labelRect = CGRectZero;
    }
    
    CGRect imageContainer = content;
    imageContainer.size.height = CGRectGetHeight(content) - ((displayTabTitle) ? (kMargin + CGRectGetHeight(labelRect)) : 0);
    imageRect.origin.x = floorf(CGRectGetMidX(content) - CGRectGetWidth(imageRect) / 2);
    imageRect.origin.y = floorf(CGRectGetMidY(imageContainer) - CGRectGetHeight(imageRect) / 2);

    CGFloat offsetY = rect.size.height - ((displayTabTitle) ? (kMargin + CGRectGetHeight(labelRect)) : 0) + kTopMargin;
    if (!self.selected) {
        // We draw the vertical lines for the border
        CGContextSaveGState(ctx);
        {
            CGContextSetBlendMode(ctx, kCGBlendModeOverlay);
            CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
            CGContextFillRect(ctx, CGRectMake(0.1, kTopMargin, 0.1, rect.size.height - kTopMargin));
            CGContextFillRect(ctx, CGRectMake(rect.size.width - 0.1, 0, 0.1, rect.size.height));
        }
        CGContextRestoreGState(ctx);
    } else if (self.selected) {
        CGContextSaveGState(ctx);
        {
            [RGBCOLOR(249, 137, 195, 1) set];
            CGContextFillRect(ctx, rect);
        }
        CGContextRestoreGState(ctx);
        
        // We draw the vertical lines for the border
        CGContextSaveGState(ctx);
        {
            CGContextSetBlendMode(ctx, kCGBlendModeOverlay);
            CGContextSetFillColorWithColor(ctx, _strokeColor ? [_strokeColor CGColor] : [[UIColor colorWithRed:.7f green:.7f blue:.7f alpha:.4f] CGColor]);
            CGContextFillRect(ctx, CGRectMake(0.1, kTopMargin, 0.1, rect.size.height - kTopMargin));
            CGContextFillRect(ctx, CGRectMake(rect.size.width - 0.1, kTopMargin, 0.1, rect.size.height - kTopMargin));
        }
        CGContextRestoreGState(ctx);
    }
    CGContextSaveGState(ctx);
    {
        CGContextTranslateCTM(ctx, 0.0, offsetY);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, imageRect, image.CGImage);
    }
    CGContextRestoreGState(ctx);
}

@end
