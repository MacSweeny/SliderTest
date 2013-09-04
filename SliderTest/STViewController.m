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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)rulerButtonUp:(id)sender {
    // [self.rulerScrollView setImageWithName:@"ruler-image.jpeg"];
    CGFloat height = self.rulerScrollView.frame.size.height;
    [self.rulerScrollView displayRulerWithStart:0 end:2999 height:height];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int value = self.rulerScrollView. contentOffset.x;
    self.valueLabel.text = [NSString stringWithFormat:@"%i", value];
}

@end
