//
//  UserSettingHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "UserSettingHandler.h"
#import "DebugUtil.h"
#import "WakeupSettingHandler.h"
#import "EmailSettingHandler.h"
#import "RecordSettingHandler.h"

#pragma mark - UserSetting
@implementation UserSetting
@synthesize eMail = _eMail;
@synthesize periodDate = _periodDate;
@synthesize nextWakeupDate = _nextWakeupDate;
@synthesize runwakeup = _runwakeup;
@synthesize recordPeriod = _recordPeriod;

- (id) init
{
    self = [super init];
    if (nil != self) {

#pragma mark (TODO) below should be the singleton?
        EmailSettingHandler* emailSettingHandler = [[EmailSettingHandler alloc] init];
        _eMail = [[emailSettingHandler eMail] copy];

        WakeupSettingHandler* wakeupSettingHandler = [[WakeupSettingHandler alloc] init];
        _periodDate = [[wakeupSettingHandler periodDate] copy];
        _nextWakeupDate = [[wakeupSettingHandler nextWakeupDate] copy];
        _runwakeup = [wakeupSettingHandler runWakeUp];
        
        RecordSettingHandler* recordSettingHandler = [[RecordSettingHandler alloc] init];
        _recordPeriod = [recordSettingHandler recordTime];
    }
    return self;
}

-(void) setEMail:(NSString *)eMail
{
#pragma mark (TODO) not finished
    CHECK_NOT_ENTER_HERE;
}

-(void) setPeriodDate:(NSDate *)periodDate
{
#pragma mark (TODO) not finished
    CHECK_NOT_ENTER_HERE;
}

-(void) setNextWakeupDate:(NSDate *)nextWakeupDate
{
#pragma mark (TODO) not finished
    CHECK_NOT_ENTER_HERE;
}

-(void) setRunwakeup:(BOOL)runwakeup
{
#pragma mark (TODO) not finished
    CHECK_NOT_ENTER_HERE;
}

-(void) setRecordPeriod:(int)recordPeriod
{
#pragma mark (TODO) not finished
    CHECK_NOT_ENTER_HERE;
}
@end

@implementation UserSettingHandler
@synthesize userSetting = _userSetting;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _userSetting = [[UserSetting alloc] init];
    }
    return self;
}

- (NSString*) getEMail
{
    return [_userSetting eMail];
}

- (void) setEMail: (NSString*) eMail
{
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setEMail:eMail];
}

- (NSDate*) getPeriodDate
{
    return [_userSetting periodDate];
}

- (void) setPeriodDate: (NSDate*) date
{
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setPeriodDate:date];
}

- (int) getRecordPeiod
{
    return [_userSetting recordPeriod];
}

- (void) setRecordPeriod: (int) second
{
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setRecordPeriod:second];
}

- (BOOL) getRunWakeup
{
    return [_userSetting runwakeup];
}

- (void) setRunWakeup: (BOOL) flag
{
    if (nil == _userSetting) {
        DLog(@"_userSetting is null");
        assert(0);
    }
    [_userSetting setRunwakeup:flag];
}

#pragma mark - Protocol
- (id<BusinessLogicProtocol>) goTo:(STATE_TYPE)nextState
{
    return 0;
}

- (int) checkTo:(STATE_TYPE)nextState
{
    int ret = -1;
    STATE_TYPE nowState = [BusinessLogicHandler getNowStat];
    //From each state
    if (STATISTIC_ROUGH_STATE != nowState ||
        STATISTIC_DETAIL_STATE != nowState ||
        RESTART_STATE != nowState) {
        goto END;
    }
    //To here
    if (SETTING_STATE != nextState) {
        goto END;
    }
    ret = 0;
END:
    if (0 != ret) {
        DLog(@"Wrong state from [%i] to [%i]", nowState, nextState);
    }
    return ret;
}


@end
