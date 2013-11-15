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
typedef BOOL(^ShouldChangeCharactersInRangeWithReplacementStringBlock)(NSRange, NSString*);
typedef BOOL(^ShouldBeginEditingBlock)();
typedef void(^DidBeginEditingBlock)();
typedef BOOL(^ShouldEndEditingBlock)();
typedef BOOL(^DidEndEditingBlock)();
typedef BOOL(^ShouldClearBlock)();
typedef BOOL(^ShouldReturnBlock)();

@interface CCValidatedTextField : UITextField

/*
 Validation blocks, called in textField:ShouldChangeCharactersInRange:ReplacementString:
 */
@property (strong, nonatomic) ValidationBlock validationBlock;
@property (strong, nonatomic) PostValidationBlock postValidationBlock;

@property (strong, nonatomic) ShouldChangeCharactersInRangeWithReplacementStringBlock shouldChangeCharactersInRangeWithReplacementStringBlock;
@property (strong, nonatomic) ShouldBeginEditingBlock shouldBeginEditingBlock;
@property (strong, nonatomic) DidBeginEditingBlock didBeginEditingBlock;
@property (strong, nonatomic) ShouldEndEditingBlock shouldEndEditingBlock;
@property (strong, nonatomic) DidEndEditingBlock didEndEditingBlock;
@property (strong, nonatomic) ShouldClearBlock shouldClearBlock;
@property (strong, nonatomic) ShouldReturnBlock shouldReturnBlock;

/*
 Setting this method will trigger a postValidationBlock call, if set
 */
@property (nonatomic) BOOL valid;


@end



