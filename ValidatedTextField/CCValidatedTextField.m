//
//  ValidatingTextField.m
//  anglerfish
//
//  Created by Chris Chares on 11/13/13.
//  Copyright (c) 2013 Eunoia Design Co. All rights reserved.
//

#import "CCValidatedTextField.h"


/*
 Unfotunately a UITextField cannot be its own delegate, due to a infinite loop in [self respondsToSelector]
 because of this, delegate methods are routed through another object
 Reference: http://www.cocoabuilder.com/archive/cocoa/241465-iphone-why-can-a-uitextfield-be-its-own-delegate.html#241505
 */
@interface DelegateRouter : NSObject<UITextFieldDelegate>
@property CCValidatedTextField *textField;
- (id)initWithValidatingTextField:(CCValidatedTextField *)textField;
@end

@interface CCValidatedTextField()
@property (strong, nonatomic) DelegateRouter *delegateRouter;
@end

@implementation CCValidatedTextField
@synthesize valid = _valid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        [self setup];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if ( self ) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    _delegateRouter = [[DelegateRouter alloc] initWithValidatingTextField:self];
    self.delegate = _delegateRouter;
}

- (void)setValid:(BOOL)valid
{
    _valid = valid;
    if ( _postValidationBlock ) {
        _postValidationBlock(_valid);
    }
}
- (BOOL)valid
{
    return _valid;
}
- (void)dealloc
{
    self.delegate = nil;
    _delegateRouter.textField = nil;
    _delegateRouter = nil;
    _validationBlock = nil;
    _postValidationBlock = nil;
    _shouldChangeCharactersInRangeWithReplacementStringBlock = nil;
    _shouldBeginEditingBlock = nil;
    _didEndEditingBlock = nil;
    _shouldEndEditingBlock = nil;
    _didEndEditingBlock = nil;
    _shouldClearBlock = nil;
    _shouldReturnBlock = nil;
}
@end

@implementation DelegateRouter
/*
 Managing Editing
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( _textField.shouldBeginEditingBlock ) {
        return _textField.shouldBeginEditingBlock();
    } else {
        return YES;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ( _textField.didBeginEditingBlock ) {
        _textField.didBeginEditingBlock();
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ( _textField.shouldEndEditingBlock ) {
        return _textField.shouldEndEditingBlock();
    } else {
        return YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( _textField.didEndEditingBlock ) {
        _textField.didEndEditingBlock();
    }
}
/*
 Editing the Text Field's Text
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( _textField.validationBlock != nil ) {
        _textField.valid = _textField.validationBlock([_textField.text stringByReplacingCharactersInRange:range withString:string]);
        if ( _textField.postValidationBlock != nil ) {
            _textField.postValidationBlock(_textField.valid);
        }
    }
    
    if ( _textField.shouldChangeCharactersInRangeWithReplacementStringBlock ) {
        return _textField.shouldChangeCharactersInRangeWithReplacementStringBlock(range, string);
    } else {
        return YES;
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ( _textField.shouldClearBlock ) {
        return _textField.shouldClearBlock();
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( _textField.shouldReturnBlock ) {
        return _textField.shouldReturnBlock();
    } else {
        return YES;
    }
}
- (id)initWithValidatingTextField:(CCValidatedTextField *)textField
{
    self = [super init];
    _textField = textField;
    return self;
}
- (void)dealloc
{
    self.textField = nil;
}

@end
