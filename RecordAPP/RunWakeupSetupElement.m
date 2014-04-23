//
//  RunWakeupSetupElement.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/10.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RunWakeupSetupElement.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"

#define USER_SETUP_RUN_WAKEUP_KEY @"Run_Wakeup"
#define USER_SETUP_RUN_WAKEUP_DEFAULT FALSE

@interface RunWakeupSetupElement()
@property (nonatomic) BOOL runWakeup;
@end

@implementation RunWakeupSetupElement
@synthesize runWakeup = _runWakeup;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _runWakeup = [[NSUserDefaults standardUserDefaults] boolForKey:USER_SETUP_RUN_WAKEUP_KEY];
    }
    return self;
}

- (void) initInputView
{
    BOOL value = [self getWakeupValue];
    _runWakeup = value;
    
    [_switchView setOn:value];
}

- (void) exitInputView
{
    return;
}

- (void) setInputDelegate: (id) inputView
{
    _switchView = (UISwitch*) inputView;
}

- (id) getElementValue
{
    return [NSNumber numberWithBool:_runWakeup];
}

- (void) setElementValue: (id) value
{
    NSNumber* number = value;
    if (_runWakeup == [number boolValue]) {
        return;
    }
    _runWakeup = [number boolValue];
    //Set it into the value
    [[NSUserDefaults standardUserDefaults] setBool:_runWakeup forKey:USER_SETUP_RUN_WAKEUP_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BOOL aaa = [[NSUserDefaults standardUserDefaults] boolForKey:USER_SETUP_RUN_WAKEUP_KEY];


    if (TRUE == _runWakeup) {
        [WakeupHandler emitWakeupStartEvent];
    } else {
        [WakeupHandler emitWakeupStopEvent];
    }
}

- (NSArray*) returnDefaultKeyValue
{
    return [[NSArray alloc] initWithObjects:USER_SETUP_RUN_WAKEUP_KEY, [NSNumber numberWithBool: USER_SETUP_RUN_WAKEUP_DEFAULT], nil];
}

- (BOOL) getWakeupValue
{
    return [(NSNumber*)[self getElementValue] boolValue];
}

- (void) dismissInputView
{
    return;
}

- (void) reloadElement
{
    return;
}
@end
