//
//  STViewController.h
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STRulerScrollView.h"

@interface STViewController : UIViewController

@property (weak, nonatomic) IBOutlet STRulerScrollView *rulerScrollView;

@property (weak, nonatomic) IBOutlet UITextField *indexValueTextField;

@property (weak, nonatomic) IBOutlet UITextField *start;
@property (weak, nonatomic) IBOutlet UITextField *end;
@property (weak, nonatomic) IBOutlet UITextField *min;
@property (weak, nonatomic) IBOutlet UITextField *max;

- (IBAction)setIndexButtonUp:(id)sender;

- (IBAction)rulerButtonUp:(id)sender;

@end
