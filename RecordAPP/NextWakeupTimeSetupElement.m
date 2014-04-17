//
//  NextWakeupTimeSetupElement.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "NextWakeupTimeSetupElement.h"
#import "RunWakeupSetupElement.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"

#define USER_SETUP_NEXT_WAKEUP_DATE_KEY @"Next_Wakeup_Date"
#define USER_SETUP_NEXT_WAKEUP_DATE_DEFAULT 20

#define MAX_DATE_CONSTRAINT (6*24*60*60)

@interface NextWakeupTimeSetupElement()
@property (nonatomic, strong) NSDate* nextWakeupDate;
@end

@implementation NextWakeupTimeSetupElement
@synthesize textField = _textField;
@synthesize nextWakeupDate = _nextWakeupDate;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _nextWakeupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:(NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:USER_SETUP_NEXT_WAKEUP_DATE_KEY]];
    }
    return self;
}
//protocol
- (id) createInputView
{
    UIDatePicker* datePickerView = [[UIDatePicker alloc] init];
    datePickerView.date = [NSDate date];
    datePickerView.timeZone = [NSTimeZone localTimeZone];
    datePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
    datePickerView.maximumDate = [NSDate dateWithTimeIntervalSinceNow:MAX_DATE_CONSTRAINT];
    datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    
    return datePickerView;
}
//protocol
- (id) createInputAccessoryView
{
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0,0,320,44);
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickDone:)];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    return toolbar;
}
//protocol
- (id) getElementValue
{
    return _nextWakeupDate;
}
//protocol
- (void) setElementValue: (id) value
{
    NSDate* nextTempWakeupDate = nil;
    if (nil != value) {
        nextTempWakeupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:value];
    } else {
        if (nil == _textField) {
            CHECK_NOT_ENTER_HERE;
        }
        UIDatePicker* datePicker = (UIDatePicker*)[_textField inputView];
        nextTempWakeupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[datePicker date]];
    }
    if (TRUE == [_nextWakeupDate isEqualToDate:nextTempWakeupDate]) {
        return;
    }
    _nextWakeupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:nextTempWakeupDate];
    
    [[NSUserDefaults standardUserDefaults] setObject:_nextWakeupDate forKey:USER_SETUP_NEXT_WAKEUP_DATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //After setting up value
    RunWakeupSetupElement* runWakeupSetupElement = [[RunWakeupSetupElement alloc] init];
    if (TRUE == [runWakeupSetupElement getWakeupValue]) {
        [WakeupHandler emitWakeupReloadEvent];
    }
}
//protocol
- (NSArray*) returnDefaultKeyValue
{
    return [[NSArray alloc] initWithObjects:USER_SETUP_NEXT_WAKEUP_DATE_KEY, [NSDate dateWithTimeIntervalSinceNow:USER_SETUP_NEXT_WAKEUP_DATE_DEFAULT], nil];
}
//protocol
- (void) initInputView
{
    _textField.inputView = [self createInputView];
    _textField.inputAccessoryView = [self createInputAccessoryView];
    _textField.text = [[NSString alloc] initWithFormat:@"%@", (NSString*)[self getTextString]];
    
    UIDatePicker* datePickerView = (UIDatePicker*)[_textField inputView];
    if (nil == _textField || nil == datePickerView) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    datePickerView.date = _nextWakeupDate;
}
//protocol
- (void) setInputDelegate: (id) inputView
{
    _textField = inputView;
}

- (NSDate*) getNextWakeupTime
{
    return [[NSDate alloc]initWithTimeInterval:0 sinceDate:_nextWakeupDate];
}

- (NSString*) getTextString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    return [dateFormatter stringFromDate:_nextWakeupDate];
}

- (void) clickDone: (id) sender
{
    [self setElementValue:nil];
    [self exitInputView];
}

- (void) exitInputView
{
    if (nil == _textField) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    [_textField resignFirstResponder];
    _textField.text = (NSString*)[self getTextString];
}

- (void) dismissInputView
{
    if (TRUE == [_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
}
@end
