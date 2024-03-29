//
//  NextWakeupTimeSetupElement.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "NextWakeupTimeSetupElement.h"
#import "RunWakeupSetupElement.h"
#import "RecordInfoLevelHandler.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"
#import "Util.h"

#define USER_SETUP_NEXT_WAKEUP_DATE_KEY @"Next_Wakeup_Date"
#define USER_SETUP_NEXT_WAKEUP_DATE_DEFAULT 20

#define MAX_DATE_CONSTRAINT (6*24*60*60)
#define AUTO_INCREASE_TIME 0

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
        _nextWakeupDate = [(NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:USER_SETUP_NEXT_WAKEUP_DATE_KEY] dateByAddingTimeInterval:0];
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
    int dateInterval = 0;

    if (nil != value) {
        nextTempWakeupDate = [(NSDate*)value dateByAddingTimeInterval:0];
    } else {
        if (nil == _textField) {
            CHECK_NOT_ENTER_HERE;
        }
        UIDatePicker* datePicker = (UIDatePicker*)[_textField inputView];
        nextTempWakeupDate = [[datePicker date] dateByAddingTimeInterval:0];
    }
    if (TRUE == [_nextWakeupDate isEqualToDate:nextTempWakeupDate]) {
        return;
    }
    if (IS_DATE_EQUAL_OR_EARLIER(nextTempWakeupDate, [NSDate date])) {
        dateInterval = AUTO_INCREASE_TIME;
    } else {
        dateInterval = 0;
    }
    _nextWakeupDate = [nextTempWakeupDate dateByAddingTimeInterval:dateInterval];
    
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
}
//protocol
- (void) setInputDelegate: (id) inputView
{
    _textField = inputView;
}

- (NSDate*) getNextWakeupTime
{
    return [_nextWakeupDate dateByAddingTimeInterval:0];
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

//protocol
- (void) reloadElement
{
    if (nil == _textField) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    _nextWakeupDate = [(NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:USER_SETUP_NEXT_WAKEUP_DATE_KEY] dateByAddingTimeInterval:0];
    
    _textField.text = (NSString*)[self getTextString];
}

- (void) editBegin: (id) inputElement
{
    if (_textField != inputElement) {
        return;
    }
    UIDatePicker* datePickerView = (UIDatePicker*)[_textField inputView];

    if (nil == _textField || nil == datePickerView) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    datePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:AUTO_INCREASE_TIME];
    datePickerView.maximumDate = [NSDate dateWithTimeIntervalSinceNow:MAX_DATE_CONSTRAINT];
    datePickerView.date = _nextWakeupDate;
}
@end
