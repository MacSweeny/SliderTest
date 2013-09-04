//
//  STRulerImage.h
//  SliderTest
//
//  Created by Andy on 9/4/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRulerImage : NSObject

+ (UIImage *)rulerImageWithStart:(int)start
                             end:(int)end
                          height:(int)height;

@end
