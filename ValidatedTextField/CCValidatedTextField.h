//
//  ValidatingTextField.h
//  anglerfish
//
//  Created by Chris Chares on 11/13/13.
//  Copyright (c) 2013 Active Website LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Validation blocks
 */
typedef BOOL(^ValidationBlock)(NSString *);
typedef void(^PostValidationBlock)(BOOL);

@interface CCValidatedTextField : UITextField

/*
 Validation blocks, called in textField:ShouldChangeCharactersInRange:ReplacementString:
 */
@property (strong, nonatomic) ValidationBlock validationBlock;
@property (strong, nonatomic) PostValidationBlock postValidationBlock;

/*
 Setting this method will trigger a postValidationBlock call, if set
 */
@property (nonatomic) BOOL valid;


/**
 * Revalidates the textfield against it's current text
 */
- (void)revalidate;

@end



