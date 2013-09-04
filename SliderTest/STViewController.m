//
//  STViewController.m
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import "STViewController.h"

@interface STViewController ()

@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)otherButtonUp:(id)sender {
    [self.rulerScrollView setImageWithName:@"yellow-ruler.png"];
}

- (IBAction)rulerButtonUp:(id)sender {
    [self.rulerScrollView setImageWithName:@"ruler-image.jpeg"];
}

@end
