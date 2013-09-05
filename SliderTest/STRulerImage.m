//
//  STRulerImage.m
//  SliderTest
//
//  Created by Andy on 9/4/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import "STRulerImage.h"

@implementation STRulerImage

+ (UIImage *)rulerImageWithStart:(int)start
                             end:(int)end
                          height:(int)height {
    
    CGSize size = CGSizeMake(end-start, height);
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int value = start ; value < end ; value++) {
        int x = value - start;
        if (value % 10 == 0) {
            CGPoint lineStart = CGPointMake(x, 0);
            CGFloat lineLength = value % 50 == 0 ? 40 : 20;
            if (value % 100 == 0 && value != 0) {
                lineLength = 60;
                [self drawNumberRight:value
                             withRect:CGRectMake(x-100, 40, 95, 20)
                                color:[UIColor blackColor]
                              context:context];
            }
            CGPoint lineEnd = CGPointMake(x, lineLength);
            [self drawLineWithColor:[UIColor blackColor]
                          fromPoint:lineStart
                            toPoint:lineEnd
                       usingContext:context];
        }
    }
    
    // start line and number
    int x = 0;
    [self drawLineWithColor:[UIColor blackColor]
                  fromPoint:CGPointMake(x, 0)
                    toPoint:CGPointMake(x, height)
               usingContext:context];
    [self drawNumberLeft:start
                withRect:CGRectMake(x+5, 40, (100), 20)
                   color:[UIColor blackColor]
                 context:context];

    // end line and number
    x = end - start;
    [self drawLineWithColor:[UIColor blackColor]
                  fromPoint:CGPointMake(x, 0)
                    toPoint:CGPointMake(x, height)
               usingContext:context];
    [self drawNumberRight:end
                 withRect:CGRectMake(x-100, 40, 95, 20)
                    color:[UIColor blackColor]
                  context:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)drawNumberLeft:(int)number
              withRect:(CGRect)rect
                 color:(UIColor *)color
               context:(CGContextRef)context {
    NSString *string = [NSString stringWithFormat:@"%i", number];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string
                                                                           attributes:@{
                                                                                        NSParagraphStyleAttributeName : paragraphStyle,
                                                                                        NSForegroundColorAttributeName : color
                                                                                        }];
    [attributedString drawInRect:rect];
}

+ (void)drawNumberRight:(int)number
               withRect:(CGRect)rect
                  color:(UIColor *)color
                context:(CGContextRef)context {
    NSString *string = [NSString stringWithFormat:@"%i", number];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentRight;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string
                                                                           attributes:@{
                                                                                        NSParagraphStyleAttributeName : paragraphStyle,
                                                                                        NSForegroundColorAttributeName : color
                                                                                        }];
    [attributedString drawInRect:rect];
}

+ (void)drawLineWithColor:(UIColor *)color
                fromPoint:(CGPoint)start
                  toPoint:(CGPoint)end
             usingContext:(CGContextRef)context {
    [color set];
    /* Set the width for the line */
    CGContextSetLineWidth(context,1.0f);
    /* Start the line at this point */
    CGContextMoveToPoint(context,start.x, start.y);
    /* And end it at this point */
    CGContextAddLineToPoint(context,end.x, end.y);
    /* Use the context's current color to draw the line */
    CGContextStrokePath(context);
}


@end
