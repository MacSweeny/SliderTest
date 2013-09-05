//
//  STRulerScrollView.h
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRulerScrollView : UIScrollView

@property (readonly) NSInteger value;

- (void)displayRulerWithStart:(int)start
                          end:(int)end
                       height:(CGFloat)height;

- (void)displayRulerWithStart:(NSInteger)start
                          end:(NSInteger)end
                          min:(NSInteger)min
                          max:(NSInteger)max
                       height:(CGFloat)height;

- (void)setImageWithName:(NSString *)imageName;

@end
