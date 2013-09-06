//
//  STViewController.m
//  SliderTest
//
//  Created by Andy Sweeny on 9/3/13.
//  Copyright (c) 2013 Andy Sweeny. All rights reserved.
//

#import "STViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface STViewController () <STRulerScrollViewDelegate, UITextFieldDelegate>

@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rulerScrollView.rulerScrollViewDelegate = self;
    
    [self setupTextFields];
    
    [self rulerButtonUp:Nil];
}

- (void)setupTextFields {
    [self setupTextFieldBorder:self.start];
    [self setupTextFieldBorder:self.end];
    [self setupTextFieldBorder:self.min];
    [self setupTextFieldBorder:self.max];
    [self setupTextFieldBorder:self.indexValueTextField];
    
    self.indexValueTextField.delegate = self;
}

- (void)setupTextFieldBorder:(UITextField *)textField {
    textField.layer.borderWidth = 1.0f;
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor = [[UIColor clearColor] CGColor];
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
    self.start.layer.borderColor = [color CGColor];
    self.end.layer.borderColor = [color CGColor];
    self.min.layer.borderColor = [color CGColor];
    self.max.layer.borderColor = [color CGColor];
}

- (IBAction)setIndexButtonUp:(id)sender {
    NSInteger newIndexValue = [self.indexValueTextField.text integerValue];
    if ([self.rulerScrollView numberWithinMinMaxRange:newIndexValue]) {
        self.rulerScrollView.indexValue = newIndexValue;
        self.indexValueTextField.layer.borderColor = [[UIColor clearColor] CGColor];
        [self.indexValueTextField resignFirstResponder];
    } else {
        self.indexValueTextField.layer.borderColor = [[UIColor redColor] CGColor];
    }
}

- (IBAction)rulerButtonUp:(id)sender {
    CGFloat height = self.rulerScrollView.frame.size.height;
    
    NSInteger start = [self.start.text integerValue];
    NSInteger end = [self.end.text integerValue];
    NSInteger min = [self.min.text integerValue];
    NSInteger max = [self.max.text integerValue];
    
    if ([self validateStart:start end:end min:min max:max]) {
        [self color:[UIColor clearColor]];
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
    self.indexValueTextField.text = [NSString stringWithFormat:@"%i", self.rulerScrollView.indexValue];
}

- (void)rulerScrollViewDidChange:(STRulerScrollView *)rulerScrollView {
    [self updateViewLabel];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.indexValueTextField) {
        [textField resignFirstResponder];
        NSInteger newIndexValue = [self.indexValueTextField.text integerValue];
        self.rulerScrollView.indexValue = newIndexValue;
        return NO;
    }
    return YES;
}

@end
