//
//  RecordPeriodSetupElement.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordPeriodSetupElement.h"
#import "RunWakeupSetupElement.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"

#define USER_SETUP_RECORD_PERIOD_KEY @"Record_Period"
#define USER_SETUP_RECORD_PERIOD_DEFAULT 5

#define MIN_ROW_INDEX 0
#define SEC_ROW_INDEX 1
#define MAX_ROW_INDEX 2

#define MAX_MIN_CONSTRAINT 5
#define MAX_SEC_CONSTRAINT 59

@interface RecordPeriodSetupElement()
@property (nonatomic, strong) NSArray* elementArray;
@property (nonatomic, strong) NSMutableArray* recordTempPeriodArray;
@property (nonatomic, strong) NSMutableArray* recordPeriodArray;
@end

@implementation RecordPeriodSetupElement
@synthesize elementArray = _elementArray;
@synthesize recordTempPeriodArray = _recordTempPeriodArray;
@synthesize recordPeriodArray = _recordPeriodArray;
@synthesize textField = _textField;

- (void) setPeriod: (NSMutableArray*) array value: (NSInteger) value
{
    [array replaceObjectAtIndex:MIN_ROW_INDEX withObject:[NSNumber numberWithInteger:value / 60]];
    [array replaceObjectAtIndex:SEC_ROW_INDEX withObject:[NSNumber numberWithInteger:value % 60]];
}

- (NSUInteger) getPeriod: (NSMutableArray*) array
{
    NSUInteger totalMin = 0;
    NSNumber* number = [array objectAtIndex:MIN_ROW_INDEX];
    totalMin += [number integerValue] * 60;
    number = [array objectAtIndex:SEC_ROW_INDEX];
    totalMin += [number integerValue];
    return totalMin;
}

- (void) setArray
{
    _recordTempPeriodArray = [[NSMutableArray alloc] init];
    _recordPeriodArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < MAX_ROW_INDEX; i++) {
        [_recordPeriodArray addObject:[NSNumber numberWithInteger:0]];
        [_recordTempPeriodArray addObject:[NSNumber numberWithInteger:0]];
    }
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        if (FALSE == [self setupElementArray]) {
            CHECK_NOT_ENTER_HERE;
            return nil;
        }
        NSInteger recordPeriod = [[NSUserDefaults standardUserDefaults] integerForKey:USER_SETUP_RECORD_PERIOD_KEY];
        [self setArray];
        [self setPeriod:_recordPeriodArray value:recordPeriod];
        [self setPeriod:_recordTempPeriodArray value:recordPeriod];
    }
    return self;
}

- (BOOL) setupElementArray
{
    if (nil != [self elementArray]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    // min (5)
    NSMutableArray* minArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < MAX_MIN_CONSTRAINT; i++) {
        [minArray addObject: [[NSString alloc] initWithFormat:@"%@ min", [NSNumber numberWithInt:i]]];
        
    }
    // sec (59)
    NSMutableArray* secArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < MAX_SEC_CONSTRAINT; i++) {
        [secArray addObject: [[NSString alloc] initWithFormat:@"%@ sec", [NSNumber numberWithInt:i]]];
    }
    [self setElementArray:[[NSArray alloc] initWithObjects:minArray, secArray, nil]];
    
    return TRUE;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [[self elementArray] count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component >= [[self elementArray] count]) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    NSArray* element = [[self elementArray] objectAtIndex:component];
    if (nil == element) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return [element count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component >= [[self elementArray] count]) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    NSArray* colArray = [[self elementArray] objectAtIndex:component];
    if (nil == colArray) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    NSString* rowName = [colArray objectAtIndex:row];
    return rowName;
}

-(void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == [_elementArray count] || component > [_elementArray count]) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    if (0 == [[_elementArray objectAtIndex:component] count] || row > [[_elementArray objectAtIndex:component] count]) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    
    [_recordTempPeriodArray replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:row]];
}

- (id) createInputView
{
    UIPickerView* pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    return pickerView;
}

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

- (void) clickDone: (id) sender
{
    [self setElementValue:nil];
    [self exitInputView];
}

- (NSString*) getTextString
{
    NSNumber* min = [_recordPeriodArray objectAtIndex:MIN_ROW_INDEX];
    NSNumber* sec = [_recordPeriodArray objectAtIndex:SEC_ROW_INDEX];
    
    NSString* value = [[NSString alloc] initWithFormat:@"%ldM %ldS", (long)[min integerValue], (long)[sec integerValue]];

    return value;
}

- (id) getElementValue
{
    return [NSNumber numberWithInteger:[self getPeriod:_recordPeriodArray]];
}

- (int) getRecordPeriod
{
    NSNumber* value = [self getElementValue];
    return [value intValue];
}

- (void) setElementValue: (id) noUse
{
    BOOL valueChanged = FALSE;
    if (nil != noUse) {
        CHECK_NOT_ENTER_HERE;
        return;
    }

    if ([self getPeriod:_recordPeriodArray] != [self getPeriod:_recordTempPeriodArray]) {
        valueChanged = TRUE;
    }
    if (FALSE == valueChanged) {
        return;
    }
    for (int i = 0; i < MAX_ROW_INDEX; i++) {
        [_recordPeriodArray replaceObjectAtIndex:i withObject:[_recordTempPeriodArray objectAtIndex:i]];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:[self getPeriod:_recordPeriodArray] forKey:USER_SETUP_RECORD_PERIOD_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray*) returnDefaultKeyValue
{
    return [[NSArray alloc] initWithObjects:USER_SETUP_RECORD_PERIOD_KEY, [NSNumber numberWithInteger: USER_SETUP_RECORD_PERIOD_DEFAULT], nil];
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

- (void) initInputView
{
    _textField.inputView = [self createInputView];
    _textField.inputAccessoryView = [self createInputAccessoryView];
    _textField.text = [[NSString alloc] initWithFormat:@"%@", (NSString*)[self getTextString]];
    
    UIPickerView* pickerView = (UIPickerView*)[_textField inputView];
    if (nil == _textField || nil == pickerView) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    for (int i = 0; i < MAX_ROW_INDEX; i++) {
        [pickerView selectRow:[[_recordPeriodArray objectAtIndex:i] integerValue] inComponent:i animated:NO];
    }
}

- (void) setInputDelegate: (id) inputView
{
    _textField = inputView;
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
    NSInteger recordPeriod = [[NSUserDefaults standardUserDefaults] integerForKey:USER_SETUP_RECORD_PERIOD_KEY];
    [self setPeriod:_recordPeriodArray value:recordPeriod];
    [self setPeriod:_recordTempPeriodArray value:recordPeriod];
    
    _textField.text = (NSString*)[self getTextString];
}
@end
