//
//  EMailSetupElement.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/17.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "EMailSetupElement.h"
#import "DebugUtil.h"

#define USER_SETUP_EMAIL_KEY @"E-Mail"
#define USER_SETUP_EMAIL_DEFAULT @"user@email.com"

@interface EMailSetupElement()
@property (nonatomic, strong) NSString* email;
@end

@implementation EMailSetupElement
@synthesize email = _email;
@synthesize textField = _textField;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _email = [[NSUserDefaults standardUserDefaults] stringForKey:USER_SETUP_EMAIL_KEY];
    }
    return self;
}

- (NSString*) getEmail
{
    return [[NSString alloc] initWithString:_email];
}

//SetupElementProtocol
- (id) getElementValue
{
    return [[NSString alloc] initWithString:_email];
}

//SetupElementProtocol
- (void) setElementValue: (id) value
{
    BOOL valueChanged = FALSE;
    if (FALSE == [_email isEqualToString:(NSString*)value]) {
        valueChanged = TRUE;
    }
    if (FALSE == valueChanged) {
        return;
    }
    _email = [[NSString alloc] initWithString:value];
    [[NSUserDefaults standardUserDefaults] setObject:_email forKey:USER_SETUP_EMAIL_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//SetupElementProtocol
- (NSArray*) returnDefaultKeyValue
{
    return [[NSArray alloc] initWithObjects:USER_SETUP_EMAIL_KEY, USER_SETUP_EMAIL_DEFAULT, nil];
}

//SetupElementProtocol
- (void) exitInputView
{
    if (nil == _textField) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    [_textField resignFirstResponder];
}

//SetupElementProtocol
- (void) initInputView
{
    _textField.text = [[NSString alloc] initWithFormat:@"%@", (NSString*)[self getElementValue]];
}

//SetupElementProtocol
- (void) setInputDelegate: (id) inputView
{
    _textField = inputView;
    _textField.delegate = self;
}

//SetupElementProtocol
- (void) dismissInputView
{
    if (TRUE == [_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setElementValue:textField.text];
    [self exitInputView];
    return YES;
}

@end
