//
//  WakeupPeriodSetupElement.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/5.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "WakeupPeriodSetupElement.h"
#import "RunWakeupSetupElement.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"

#define USER_SETUP_WAKEUP_PERIOD_KEY @"Wakeup_Period"
#define USER_SETUP_WAKEUP_PERIOD_DEFAULT 60

#define DAY_ROW_INDEX 0
#define HOUR_ROW_INDEX 1
#define MIN_ROW_INDEX 2
#define MAX_ROW_INDEX 3

#define DAY_CONSTRAINT 8
#define HOUR_CONSTRAINT 24
#define MIN_CONSTRAINT 60

@interface WakeupPeriodSetupElement()
@property (nonatomic, strong) NSArray* elementArray;
@property (nonatomic, strong) NSMutableArray* wakeupTempPeriodArray;
@property (nonatomic, strong) NSMutableArray* wakeupPeriodArray;
@end

@implementation WakeupPeriodSetupElement
@synthesize elementArray = _elementArray;
@synthesize wakeupTempPeriodArray = _wakeupTempPeriodArray;
@synthesize wakeupPeriodArray = _wakeupPeriodArray;
@synthesize textField = _textField;

- (void) setPeriod: (NSMutableArray*) array value: (NSInteger) value
{
    NSInteger minValue = value;
    [array replaceObjectAtIndex:DAY_ROW_INDEX withObject:[NSNumber numberWithInteger:minValue / (24 * 60 * 60)]];
    [array replaceObjectAtIndex:HOUR_ROW_INDEX withObject:[NSNumber numberWithInteger:(minValue / (60 * 60)) % 24]];
    [array replaceObjectAtIndex:MIN_ROW_INDEX withObject:[NSNumber numberWithInteger:minValue / 60]];
}

- (NSUInteger) getPeriod: (NSMutableArray*) array
{
    NSUInteger totalMin = 0;
    NSNumber* number = [array objectAtIndex:DAY_ROW_INDEX];
    totalMin += [number integerValue] * 24 * 60 * 60;
    number = [array objectAtIndex:HOUR_ROW_INDEX];
    totalMin += [number integerValue] * 60 * 60;
    number = [array objectAtIndex:MIN_ROW_INDEX];
    totalMin += [number integerValue] * 60;
    return totalMin;
}

- (void) setArray
{
    _wakeupTempPeriodArray = [[NSMutableArray alloc] init];
    _wakeupPeriodArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < MAX_ROW_INDEX; i++) {
        [_wakeupPeriodArray addObject:[NSNumber numberWithInteger:0]];
        [_wakeupTempPeriodArray addObject:[NSNumber numberWithInteger:0]];
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
        NSInteger wakeupPeriod = [[NSUserDefaults standardUserDefaults] integerForKey:USER_SETUP_WAKEUP_PERIOD_KEY];
        [self setArray];
        [self setPeriod:_wakeupPeriodArray value:wakeupPeriod];
        [self setPeriod:_wakeupTempPeriodArray value:wakeupPeriod];
    }
    return self;
}

- (BOOL) setupElementArray
{
    if (nil != [self elementArray]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    // Day to Week (7)
    NSMutableArray* dayArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < DAY_CONSTRAINT; i++) {
        [dayArray addObject: [[NSString alloc] initWithFormat:@"%@ day", [NSNumber numberWithInt:i]]];
    }
    // hour (24)
    NSMutableArray* hourArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < HOUR_CONSTRAINT; i++) {
        [hourArray addObject: [[NSString alloc] initWithFormat:@"%@ hour", [NSNumber numberWithInt:i]]];
    }
    // min (60)
    NSMutableArray* minArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < MIN_CONSTRAINT; i++) {
        [minArray addObject: [[NSString alloc] initWithFormat:@"%@ min", [NSNumber numberWithInt:i]]];
    }
    [self setElementArray:[[NSArray alloc] initWithObjects:dayArray, hourArray, minArray, nil]];
    
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
    
    [_wakeupTempPeriodArray replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:row]];
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
    NSNumber* day = [_wakeupPeriodArray objectAtIndex:DAY_ROW_INDEX];
    NSNumber* hour = [_wakeupPeriodArray objectAtIndex:HOUR_ROW_INDEX];
    NSNumber* min = [_wakeupPeriodArray objectAtIndex:MIN_ROW_INDEX];
    
    NSString* value = [[NSString alloc] initWithFormat:@"%ldD %ldH %ldM", (long)[day integerValue], (long)[hour integerValue], (long)[min integerValue]];
    
    return value;
}

- (id) getElementValue
{
    return [NSNumber numberWithInteger:[self getPeriod:_wakeupPeriodArray]];
}

- (int) getWakeupPeriod
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

    if ([self getPeriod:_wakeupPeriodArray] != [self getPeriod:_wakeupTempPeriodArray]) {
        valueChanged = TRUE;
    }
    if (FALSE == valueChanged) {
        return;
    }

    NSUInteger secValue = [self getPeriod:_wakeupTempPeriodArray];
    [self setPeriod:_wakeupPeriodArray value:secValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:[self getPeriod:_wakeupPeriodArray] forKey:USER_SETUP_WAKEUP_PERIOD_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    RunWakeupSetupElement* runWakeupElement = [[RunWakeupSetupElement alloc] init];
    if (nil == runWakeupElement) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    if (TRUE == [runWakeupElement getWakeupValue] && TRUE == valueChanged) {
        [WakeupHandler emitWakeupReloadEvent];
    }
}

- (NSArray*) returnDefaultKeyValue
{
    return [[NSArray alloc] initWithObjects:USER_SETUP_WAKEUP_PERIOD_KEY, [NSNumber numberWithInteger: USER_SETUP_WAKEUP_PERIOD_DEFAULT], nil];
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
        [pickerView selectRow:[[_wakeupPeriodArray objectAtIndex:i] integerValue] inComponent:i animated:NO];
    }
}

- (void) setInputDelegate: (id) inputView
{
    _textField = inputView;
}

//protocol
- (void) reloadElement
{
    if (nil == _textField) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    NSInteger wakeupPeriod = [[NSUserDefaults standardUserDefaults] integerForKey:USER_SETUP_WAKEUP_PERIOD_KEY];
    [self setPeriod:_wakeupPeriodArray value:wakeupPeriod];
    [self setPeriod:_wakeupTempPeriodArray value:wakeupPeriod];
    
    _textField.text = (NSString*)[self getTextString];
}

@end
