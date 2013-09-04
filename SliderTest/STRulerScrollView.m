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

@interface STRulerScrollView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation STRulerScrollView


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIScrollView *scrollView = self;
        
        // set subviews...
        UIView *leftOffsetView = [[UIView alloc] init];
        [leftOffsetView setBackgroundColor:[UIColor purpleColor]];
        [scrollView addSubview:leftOffsetView];
        
        UIView *rightOffsetView = [[UIView alloc] init];
        [rightOffsetView setBackgroundColor:[UIColor blueColor]];
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
        
        // TODO :: To keep midpoint within mins and max ranges of slider... set offset views off negatively from superview
        // ?? :: Must do this later, when min-max set ?? So maybe alter constraints... based on new values.
        
        // [scrollView addConstraints:
        //  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-25)-[leftOffsetView][imageView][rightOffsetView]-(-25)-|"
       
        [scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftOffsetView][imageView][rightOffsetView]|"
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

@end
