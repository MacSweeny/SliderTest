//
//  STRulerScrollView.m
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import "STRulerScrollView.h"

#import "STRulerImage.h"

@interface STRulerScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *leftOffsetView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *rightOffsetView;


@property (nonatomic) NSInteger min;
@property (nonatomic) NSInteger max;

@property (nonatomic) BOOL settingOffsetValue;

@property (nonatomic, strong) NSLayoutConstraint *leftOffsetLeadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightOffsetLeadingConstraint;

@end

@implementation STRulerScrollView

// ??? - Setup constraints in updateConstraints ???

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIScrollView *scrollView = self;
        scrollView.delegate = self;
        
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        
        // set subviews...
        self.leftOffsetView = [[UIView alloc] init];
        UIView *leftOffsetView = self.leftOffsetView;
        [leftOffsetView setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:leftOffsetView];
        
        self.rightOffsetView = [[UIView alloc] init];
        UIView *rightOffsetView = self.rightOffsetView;
        [rightOffsetView setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:rightOffsetView];
        
        self.imageView = [[UIImageView alloc] init];
        
        UIImageView *imageView = self.imageView;
        [scrollView addSubview:imageView];
        
        // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
        scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        leftOffsetView.translatesAutoresizingMaskIntoConstraints = NO;
        rightOffsetView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(scrollView, leftOffsetView, imageView, rightOffsetView);
        
        [scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftOffsetView][imageView][rightOffsetView]"
                                                 options:0
                                                 metrics: 0
                                                   views:viewsDictionary]];
        
        [scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                 options:0
                                                 metrics: 0
                                                   views:viewsDictionary]];
        
        
        [scrollView addConstraint:
         [NSLayoutConstraint constraintWithItem:leftOffsetView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:scrollView
                                      attribute:NSLayoutAttributeWidth
                                     multiplier:.5
                                       constant:0]];
        
        [scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftOffsetView]|"
                                                 options:0
                                                 metrics: 0
                                                   views:viewsDictionary]];
        
        viewsDictionary = NSDictionaryOfVariableBindings(scrollView, rightOffsetView, imageView);
        
        [scrollView addConstraint:
         [NSLayoutConstraint constraintWithItem:rightOffsetView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:scrollView
                                      attribute:NSLayoutAttributeWidth
                                     multiplier:.5
                                       constant:0]];
     
        [scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightOffsetView]|"
                                                 options:0
                                                 metrics: 0
                                                   views:viewsDictionary]];
        
    }
    return self;
}

- (BOOL)numberWithinMinMaxRange:(NSInteger)number {
    return self.min <= number && number <= self.max;
}

- (void)displayRulerWithStart:(NSInteger)start
                          end:(NSInteger)end
                       height:(CGFloat)height {
    [self displayRulerWithStart:start
                            end:end
                            min:start
                            max:end
                         height:height];
}

- (void)displayRulerWithStart:(int)start
                          end:(int)end
                          min:(NSInteger)min
                          max:(NSInteger)max
                       height:(CGFloat)height {
    self.min = min;
    self.max = max;
    UIImage *image = [STRulerImage rulerImageWithStart:start end:end height:height];
    [self.imageView setImage:image];
    
    [self removeConstraint:self.leftOffsetLeadingConstraint];
    
    self.leftOffsetLeadingConstraint =
    [NSLayoutConstraint constraintWithItem:self.leftOffsetView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:start-min];
    
    [self addConstraint:self.leftOffsetLeadingConstraint];
    
    [self removeConstraint:self.rightOffsetLeadingConstraint];
    
    self.rightOffsetLeadingConstraint =
    [NSLayoutConstraint constraintWithItem:self.rightOffsetView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:end-max];
    
    [self addConstraint:self.rightOffsetLeadingConstraint];
    
    [self updateConstraints];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.rulerScrollViewDelegate conformsToProtocol:@protocol(STRulerScrollViewDelegate)] &&
        !self.settingOffsetValue) {
        [self.rulerScrollViewDelegate rulerScrollViewDidChange:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.settingOffsetValue = NO;
}

// Excessively elaborate rounding method...

- (NSInteger)round:(NSInteger)toRound {
    NSDecimal toRoundDecimal = [[NSNumber numberWithInt:toRound] decimalValue];
    NSDecimalNumber *toRoundDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:toRoundDecimal];
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                             scale:-1
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    return [[toRoundDecimalNumber decimalNumberByRoundingAccordingToBehavior:handler] integerValue];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.snapsToGrid) {
        if (!decelerate) {
            NSInteger newIndex = [self round:self.indexValue];
            [self adjustIndexValue:newIndex informDelegate:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.snapsToGrid) {
        NSInteger newIndex = [self round:self.indexValue];
        [self adjustIndexValue:newIndex informDelegate:YES];
    }
}

- (NSInteger)indexValue {
    return MIN(self.max, MAX(self.min, self.contentOffset.x + self.min));
    return self.contentOffset.x + self.min;
}

- (void)adjustIndexValue:(NSInteger)newIndexValue informDelegate:(BOOL)informDelegate {
    // if newIndexValue == existing then we actually wont scroll
    // upon setting new offset... and things break.
    if (self.min <= newIndexValue &&
        newIndexValue <= self.max &&
        newIndexValue != self.indexValue) {
        CGPoint newContextOffset = CGPointMake(newIndexValue - self.min, self.contentOffset.y);
        if (!informDelegate) {
            self.settingOffsetValue = YES;
        }
        [self setContentOffset:newContextOffset animated:YES];
    }
}

- (void)setIndexValue:(NSInteger)indexValue {
    [self adjustIndexValue:indexValue informDelegate:NO];
}

@end
