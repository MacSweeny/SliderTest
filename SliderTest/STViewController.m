//
//  STViewController.m
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import "STViewController.h"

@interface STViewController () <UIScrollViewDelegate>

@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rulerScrollView.delegate = self;
    
    [self rulerButtonUp:Nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)validateStart:(NSInteger)start
                  end:(NSInteger)end
                  min:(NSInteger)min
                  max:(NSInteger)max {
    return start <= end &&
           start <= min &&
           start <= max &&
           min <= max &&
           max <= end;
}

- (void)color:(UIColor *)color {
    self.start.textColor = color;
    self.end.textColor = color;
    self.min.textColor = color;
    self.max.textColor = color;
}

- (IBAction)rulerButtonUp:(id)sender {
    CGFloat height = self.rulerScrollView.frame.size.height;
    
    NSInteger start = [self.start.text integerValue];
    NSInteger end = [self.end.text integerValue];
    NSInteger min = [self.min.text integerValue];
    NSInteger max = [self.max.text integerValue];
    
    if ([self validateStart:start end:end min:min max:max]) {
        [self color:[UIColor blackColor]];
        [self.view endEditing:YES];
        [self.rulerScrollView displayRulerWithStart:start
                                                end:end
                                                min:min
                                                max:max
                                             height:height];
    } else {
        __weak STViewController *weakSelf = self;
        [UIView animateWithDuration:2
                         animations:^{
                             [weakSelf color:[UIColor redColor]];
                         }];
    }
}

- (void)viewDidLayoutSubviews {
    [self updateViewLabel];
}

- (void)updateViewLabel {
    self.valueLabel.text = [NSString stringWithFormat:@"%i", self.rulerScrollView.value];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateViewLabel];
}

@end
