CCValidatedTextField
====================

Add real-time validation to UITextField with blocks

![sample](http://i.imgur.com/Gy8Ylvs.gif)

Easy block based methods with the opportunity for full customization

    NSString *emailPattern = @"^[_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4})$";
    _emailField.validationBlock = ^(NSString *text) {
      return ([text rangeOfString:emailPattern options:NSRegularExpressionSearch].location != NSNotFound );
    };
    _emailField.postValidationBlock = ^(BOOL valid){
      if ( valid ) {
        _emailStatus.image = [UIImage imageNamed:@"valid"];
      } else {
        _emailStatus.image = [UIImage imageNamed:@"invalid"];
      }
    };
    
CCValidatedTextField also exposes the rest of UITextFieldDelegate's methods as blocks for convenience

    @property (strong, nonatomic) ValidationBlock validationBlock;
    @property (strong, nonatomic) PostValidationBlock postValidationBlock;
    @property (strong, nonatomic) ShouldChangeCharactersInRangeWithReplacementStringBlock shouldChangeCharactersInRangeWithReplacementStringBlock;
    @property (strong, nonatomic) ShouldBeginEditingBlock shouldBeginEditingBlock;
    @property (strong, nonatomic) DidBeginEditingBlock didBeginEditingBlock;
    @property (strong, nonatomic) ShouldEndEditingBlock shouldEndEditingBlock;
    @property (strong, nonatomic) DidEndEditingBlock didEndEditingBlock;
    @property (strong, nonatomic) ShouldClearBlock shouldClearBlock;
    @property (strong, nonatomic) ShouldReturnBlock shouldReturnBlock;

##Installation##
Cocoapods - in the process of adding a podspec
