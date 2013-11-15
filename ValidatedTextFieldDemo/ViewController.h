//
//  ViewController.h
//  ValidatedTextFieldDemo
//
//  Created by Chris Chares on 11/14/13.
//  Copyright (c) 2013 Eunoia Design Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidatedTextField.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet ValidatedTextField *emailField;
@property (weak, nonatomic) IBOutlet ValidatedTextField *lengthField;
@property (weak, nonatomic) IBOutlet ValidatedTextField *numberField;


- (IBAction)submit:(id)sender;


@end
