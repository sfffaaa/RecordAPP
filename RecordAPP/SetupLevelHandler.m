//
//  SetupLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "SetupLevelHandler.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"

@implementation SetupLevelHandler
@synthesize userSetting = _userSetting;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _userSetting = [[UserSetting alloc] init];
    }
    return self;
}

- (int) getRecordPeiod
{
#pragma mark (TODO) Implement getRecordPeiod
    return [_userSetting recordPeriod];
}

- (void) setRecordPeriod: (int) second
{
#pragma mark (TODO) Implement setRecordPeriod (check type)
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setRecordPeriod:second];
}

- (int) getWakeupPeriod
{
#pragma mark (TODO) Implement getPeriodDate
    return [_userSetting wakeupPeriod];
}

- (void) setWakeupPeriod: (int) date
{
#pragma mark (TODO) Implement setPeriodDate (check type)
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setWakeupPeriod:date];
    [[NSNotificationCenter defaultCenter] postNotificationName: WAKEUP_RELOAD_EVENT object:self];
}

- (BOOL) getRunWakeup
{
#pragma mark (TODO) Implement getRunWakeup
    return [_userSetting runwakeup];
}

- (void) setRunWakeup: (BOOL) flag
{
#pragma mark (TODO) Implement setRunWakeup (check type)
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setRunwakeup:flag];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: WAKEUP_RELOAD_EVENT object:self];
}

- (NSDate*) getNextWakeupTime
{
#pragma mark (TODO) Implement getRunWakeup
    return [_userSetting nextWakeupDate];
}

- (void) setNextWakeupTime: (NSDate*) date
{
#pragma mark (TODO) Implement setRunWakeup (check type)
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setNextWakeupDate:date];
    [[NSNotificationCenter defaultCenter] postNotificationName: WAKEUP_RELOAD_EVENT object:self];
}


- (NSString*) getEMail
{
#pragma mark (TODO) Implement getEMail
    return [_userSetting eMail];
}

- (void) setEMail: (NSString*) eMail
{
#pragma mark (TODO) Implement setEMail (check type)
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setEMail:eMail];
}

@end
