//
//  ViewController.m
//  ValidatedTextFieldDemo
//
//  Created by Chris Chares on 11/14/13.
//  Copyright (c) 2013 Eunoia Design Co. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    /*
     Email Validation
     */
    NSString *emailPattern = @"^[_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4})$";
    _emailField.validationBlock = ^(NSString *text) {
        return [self validateString:text withPattern:emailPattern];
    };
    _emailField.postValidationBlock = ^(BOOL valid){
        if ( valid ) {
            _emailStatus.image = [UIImage imageNamed:@"valid"];
        } else {
            _emailStatus.image = [UIImage imageNamed:@"invalid"];
        }
    };
    
    /*
     Length Validation
     */
    _lengthField.validationBlock = ^(NSString *text) {
        if ( text.length > 5 ) {
            return YES;
        } else {
            return NO;
        }
    };
    _lengthField.postValidationBlock = ^(BOOL valid) {
        if ( valid ) {
            _lengthField.backgroundColor = [UIColor greenColor];
        } else {
            _lengthField.backgroundColor = [UIColor redColor];
        }
    };
    
    /*
     Number validation
     */
    NSString *numberPattern = @"^[0-9]+$";
    
    _numberField.validationBlock = ^(NSString *text) {
        return [self validateString:text withPattern:numberPattern];
    };
    _numberField.postValidationBlock = ^(BOOL valid) {
        if ( valid) {
            _numberField.backgroundColor = [UIColor greenColor];
        } else {
            _numberField.backgroundColor = [UIColor redColor];
        }
    };
    

}

- (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    return ([string rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound );
}


- (IBAction)submit:(id)sender
{
    NSString *title = @"Error";
    NSString *message;
    
    if ( ! _emailField.valid ) {
        message = @"Please enter a valid email";
    } else if ( ! _lengthField.valid ) {
        message = @"Please enter a string longer than 5 characters into the second field";
    } else if ( ! _numberField.valid ) {
        message = @"Please enter a valid number into the third field";
    } else {
        title = @"Success!";
        message = @"All fields succesfully validated";
    }

    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    
    
    
    
    
    
}






@end
