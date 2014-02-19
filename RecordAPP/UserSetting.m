//
//  UserSetting.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "UserSetting.h"
#import "DebugUtil.h"
#import "WakeupHandler.h"
#import "EmailSettingHandler.h"
#import "RecordSettingHandler.h"

#define USER_SETUP_EMAIL_KEY @"E-Mail"
#define USER_SETUP_WAKEUP_PERIOD_KEY @"Wakeup_Period"
#define USER_SETUP_NEXT_WAKEUP_DATE_KEY @"Next_Wakeup_Date"
#define USER_SETUP_RUN_WAKEUP_KEY @"Run_Wakeup"
#define USER_SETUP_RECORD_PERIOD_KEY @"Record_Period"

#define USER_SETUP_EMAIL_DEFAULT @"user@email.com"
#define USER_SETUP_WAKEUP_PERIOD_DEFAULT 20
#define USER_SETUP_NEXT_WAKEUP_DATE_DEFAULT 20
#define USER_SETUP_RUN_WAKEUP_DEFAULT FALSE
#define USER_SETUP_RECORD_PERIOD_DEFAULT 5

#pragma mark - UserSetting
@implementation UserSetting
@synthesize eMail = _eMail;
@synthesize wakeupPeriod = _wakeupPeriod;
@synthesize nextWakeupDate = _nextWakeupDate;
@synthesize runwakeup = _runwakeup;
@synthesize recordPeriod = _recordPeriod;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _eMail = [[NSUserDefaults standardUserDefaults] stringForKey:USER_SETUP_EMAIL_KEY];
        _wakeupPeriod = [[NSUserDefaults standardUserDefaults] integerForKey:USER_SETUP_WAKEUP_PERIOD_KEY];
        _nextWakeupDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:USER_SETUP_NEXT_WAKEUP_DATE_KEY];
        _runwakeup = [[NSUserDefaults standardUserDefaults] boolForKey:USER_SETUP_RUN_WAKEUP_KEY];
        _recordPeriod = [[NSUserDefaults standardUserDefaults] integerForKey:USER_SETUP_RECORD_PERIOD_KEY];
    }
    return self;
}

- (void) setEMail:(NSString *)eMail
{
    if (nil == eMail) {
        CHECK_NOT_ENTER_HERE;
    }
    _eMail = [[NSString alloc] initWithFormat:@"%@", eMail];
    [[NSUserDefaults standardUserDefaults] setObject:eMail forKey:USER_SETUP_EMAIL_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setRunwakeup:(BOOL)runwakeup
{
    _runwakeup = runwakeup;
    [[NSUserDefaults standardUserDefaults] setBool:runwakeup forKey:USER_SETUP_RUN_WAKEUP_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setNextWakeupDate:(NSDate *)nextWakeupDate
{
    _nextWakeupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate: nextWakeupDate];
    [[NSUserDefaults standardUserDefaults] setObject:nextWakeupDate forKey:USER_SETUP_NEXT_WAKEUP_DATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setWakeupPeriod:(int)wakeupPeriod
{
    _wakeupPeriod = wakeupPeriod;
    [[NSUserDefaults standardUserDefaults] setInteger:wakeupPeriod forKey:USER_SETUP_WAKEUP_PERIOD_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setRecordPeriod:(int)recordPeriod
{
    _recordPeriod = recordPeriod;
    [[NSUserDefaults standardUserDefaults] setInteger:recordPeriod forKey:USER_SETUP_RECORD_PERIOD_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) UserDefaultRegister
{
    NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
        USER_SETUP_EMAIL_DEFAULT, USER_SETUP_EMAIL_KEY,
        [NSNumber numberWithInt:USER_SETUP_WAKEUP_PERIOD_DEFAULT], USER_SETUP_WAKEUP_PERIOD_KEY,
        [NSDate dateWithTimeIntervalSinceNow:USER_SETUP_NEXT_WAKEUP_DATE_DEFAULT], USER_SETUP_NEXT_WAKEUP_DATE_KEY,
        [NSNumber numberWithBool:USER_SETUP_RUN_WAKEUP_DEFAULT], USER_SETUP_RUN_WAKEUP_KEY,
        [NSNumber numberWithInt:USER_SETUP_RECORD_PERIOD_DEFAULT], USER_SETUP_RECORD_PERIOD_KEY,
    nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end