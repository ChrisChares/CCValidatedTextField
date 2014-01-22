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

/**
 * The forward delegate for this tableView
 *
 * This UITextField implements some methods of UITextFieldDelegate to assist in validation, however
 * since we still want the user to be able to use a UITextField delegate, we use this to store the user's
 * delegate and forward methods calls to it.
 */
@property (nonatomic, assign) id <UITextFieldDelegate> forwardDelegate;


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

/**
 * Sets up the delegate to be the DelegateRouter
 */
- (void)setup
{
    // Init the delegate router with this text field
    _delegateRouter = [[DelegateRouter alloc] initWithValidatingTextField:self];
  
    // Set the delegate on super to enable use of the forward delegate
    [super setDelegate:_delegateRouter];
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
}

/**
 * Override setting the delegate to enable use of both the DelegateRouter and
 * a custom delegate designated by the user
 */
- (void)setDelegate:(id <UITextFieldDelegate>)delegate
{
  if (delegate == _delegateRouter) return;
  
  self.forwardDelegate = delegate;
}

/**
 * Validates the current field against a given string
 */
- (void)validateAgainstString:(NSString *)string
{
  if ( self.validationBlock != nil ) {
    self.valid = self.validationBlock(string);
    if ( self.postValidationBlock != nil ) {
      self.postValidationBlock(self.valid);
    }
  }
}

- (void)revalidate {
  [self validateAgainstString:self.text];
}

@end


@implementation DelegateRouter

/*
 Editing the Text Field's Text
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  [_textField validateAgainstString:[_textField.text stringByReplacingCharactersInRange:range withString:string]];
  
  if ([_textField.forwardDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:::)])
  {
    return [_textField.forwardDelegate textField:_textField shouldChangeCharactersInRange:range replacementString:string];
  }
  else
  {
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

#pragma mark - Delegate Forwarding

/**
 * Returns YES if DelegateRouter or the ForwardDelegate respond to the selector
 */
- (BOOL)respondsToSelector:(SEL)aSelector
{
  return [super respondsToSelector:aSelector] || [_textField.forwardDelegate respondsToSelector:aSelector];
}

/**
 * Pass off any methods not implemented by DelegateRouter to the delegate the user set on _textField
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
  if ([super respondsToSelector:aSelector]) return self;
  if ([_textField.forwardDelegate respondsToSelector:aSelector]) return _textField.forwardDelegate;
  
  return nil;
}


@end
