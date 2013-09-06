//
//  STRulerScrollView.h
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STRulerScrollViewDelegate;

@interface STRulerScrollView : UIScrollView

@property (nonatomic) NSInteger indexValue;
@property (nonatomic, weak) id<STRulerScrollViewDelegate> rulerScrollViewDelegate;
@property (nonatomic) BOOL snapsToGrid;

- (BOOL)numberWithinMinMaxRange:(NSInteger)number;

- (void)displayRulerWithStart:(int)start
                          end:(int)end
                       height:(CGFloat)height;

- (void)displayRulerWithStart:(NSInteger)start
                          end:(NSInteger)end
                          min:(NSInteger)min
                          max:(NSInteger)max
                       height:(CGFloat)height;

@end

@protocol STRulerScrollViewDelegate <NSObject>

- (void)rulerScrollViewDidChange:(STRulerScrollView *)rulerScrollView;

@end