//
//  ViewController.h
//  ValidatedTextFieldDemo
//
//  Created by Chris Chares on 11/14/13.
//  Copyright (c) 2013 Eunoia Design Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCValidatedTextField.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet CCValidatedTextField *emailField;
@property (weak, nonatomic) IBOutlet UIImageView *emailStatus;

@property (weak, nonatomic) IBOutlet CCValidatedTextField *lengthField;
@property (weak, nonatomic) IBOutlet CCValidatedTextField *numberField;


- (IBAction)submit:(id)sender;


@end
