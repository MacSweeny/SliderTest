//
//  STRulerScrollView.m
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

/*
 Integrate ruler code.
 Constraints to limit slider to within Min & Max.
 Setup/Change Ruler method w/ start, end, min, max, etc.
 Property to get or set slider value.
 
 ? Height, font, scale, colors ?
 */

#import "STRulerScrollView.h"

#import "STRulerImage.h"

@interface STRulerScrollView()

@property (nonatomic, strong) UIView *leftOffsetView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *rightOffsetView;


@property (nonatomic) NSInteger min;
@property (nonatomic) NSInteger max;

@property (nonatomic, strong) NSLayoutConstraint *leftOffsetLeadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightOffsetLeadingConstraint;

@end

@implementation STRulerScrollView


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIScrollView *scrollView = self;
        
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

- (void)setImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    [self.imageView setImage:image];
    
// NOT NEEDED !?!
//        [self addConstraint:
//         [NSLayoutConstraint constraintWithItem:self.imageView
//                                      attribute:NSLayoutAttributeWidth
//                                      relatedBy:NSLayoutRelationEqual
//                                         toItem:nil
//                                      attribute:NSLayoutAttributeNotAnAttribute
//                                     multiplier:1
//                                       constant:image.size.width]];
//    
    [self updateConstraints];
}

- (NSInteger)value {
    return MIN(self.max, MAX(self.min, self.contentOffset.x + self.min));
    return self.contentOffset.x + self.min;
}

@end
