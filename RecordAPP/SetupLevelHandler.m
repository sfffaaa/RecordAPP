//
//  SetupLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "SetupLevelHandler.h"
#import "WakeupHandler.h"
#import "CreateSetupElementFactory.h"
#import "RunWakeupSetupElement.h"
#import "DebugUtil.h"

@interface SetupLevelHandler()
@property (nonatomic, strong) NSMutableArray* setupArray;

@end

@implementation SetupLevelHandler
@synthesize wakeupPeriodElement = _wakeupPeriodElement;
@synthesize runWakeupElement = _runWakeupElement;
@synthesize recordPeriodElement = _recordPeriodElement;
@synthesize nextWakeupPeriodElement = _nextWakeupPeriodElement;
@synthesize emailElement = _emailElement;
@synthesize setupArray = _setupArray;

- (id) init
{
    self = [super init];
    if (nil != self) {
        CreateSetupElementFactory* setupFactory = [[CreateSetupElementFactory alloc] init];
        _wakeupPeriodElement = [setupFactory createSetupElement:@"WakeupPeriodSetupElement"];
        _runWakeupElement = [setupFactory createSetupElement:@"RunWakeupSetupElement"];
        _recordPeriodElement = [setupFactory createSetupElement:@"RecordPeriodSetupElement"];
        _nextWakeupPeriodElement = [setupFactory createSetupElement:@"NextWakeupTimeSetupElement"];
        _emailElement = [setupFactory createSetupElement:@"EMailSetupElement"];
        
        _setupArray = [[NSMutableArray alloc] initWithObjects:_wakeupPeriodElement, _runWakeupElement, _recordPeriodElement, _nextWakeupPeriodElement, _emailElement, nil];
    }
    return self;
}

- (BOOL) initAllInputView
{
    if (nil == _setupArray) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    for (id<SetupElementProtocol> obj in _setupArray) {
        [obj initInputView];
    }
    return TRUE;
}

- (BOOL) dismissAllInputView
{
    if (nil == _setupArray) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    for (id<SetupElementProtocol> obj in _setupArray) {
        [obj dismissInputView];
    }
    return TRUE;
}

- (BOOL) editBeginElement: (id) element
{
    if (nil == _setupArray) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    for (id<SetupElementProtocol> obj in _setupArray) {
        [obj editBegin:element];
    }
    return TRUE;

}

- (BOOL) reloadSetupElement
{
    if (nil == _setupArray) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    for (id<SetupElementProtocol> obj in _setupArray) {
        [obj reloadElement];
    }
    return TRUE;
}

- (BOOL) setupDefaultUserSetting
{
    if (nil == _setupArray) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    NSMutableDictionary* defaultDict = [[NSMutableDictionary alloc] init];
    for (id<SetupElementProtocol> obj in _setupArray) {
        NSArray* defaultArray = [obj returnDefaultKeyValue];
        if (nil == defaultArray) {
            CHECK_NOT_ENTER_HERE;
            return FALSE;
        }
        [defaultDict setObject:[defaultArray objectAtIndex:DEFAULT_SETUP_VALUE_INDEX] forKey:[defaultArray objectAtIndex:DEFAULT_SETUP_KEY_INDEX]];
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultDict];
    [[NSUserDefaults standardUserDefaults] synchronize];

    return TRUE;
}

@end
