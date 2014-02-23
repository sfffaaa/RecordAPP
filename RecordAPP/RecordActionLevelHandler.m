//
//  RecordActionLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordActionLevelHandler.h"
#import "TimerHandler.h"
#import "UserSetting.h"
#import "DebugUtil.h"

typedef enum _ACTION_STATUS_
{
    NON_STATUS = -1,
    PREPARE_STATUS,
    ACTION_STATUS
} ACTIONS_STATUS;

#define PREPARE_TIME 3

@interface RecordActionLevelHandler()
@property (nonatomic, strong) TimerHandler* timerHandler;
@property (nonatomic) ACTIONS_STATUS status;
@end

@implementation RecordActionLevelHandler
@synthesize action = _action;
@synthesize wakeupTime = _wakeupTime;
@synthesize timerHandler = _timerHandler;
@synthesize status = _status;

+ (RecordActionLevelHandler*) getInst
{
    static RecordActionLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[RecordActionLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        _action = nil;
        _wakeupTime = nil;
        _timerHandler = [[TimerHandler alloc] init];
        _status = NON_STATUS;
    }
    return self;
}

- (int) getPerpareTime
{
    return PREPARE_TIME;
}

- (float) getRecordTime
{
    UserSetting* userSetting = [[UserSetting alloc] init];
    return [userSetting recordPeriod];
}

- (BOOL) start
{
    //Timer start
    if (FALSE == [[self timerHandler] timeToStart:[self getRecordTime]]) {
        DLog(@"Cannot start the timer");
        CHECK_NOT_ENTER_HERE;
    }
    _status = ACTION_STATUS;
    //Record or listen start;
    return TRUE;
}

- (BOOL) stop
{
    //Timer stop
    //Record or listen stop;
    _status = NON_STATUS;
    return TRUE;
}

- (BOOL) prepareStart
{
    if (FALSE == [[self timerHandler] timeToStart:[self getPerpareTime]]) {
        DLog(@"Cannot start the timer");
        CHECK_NOT_ENTER_HERE;
    }
    _status = PREPARE_STATUS;
    return TRUE;
}

- (BOOL) prepareStop
{
    _status = NON_STATUS;
    return TRUE;
}

- (BOOL) isPrepare
{
    return _status == PREPARE_STATUS;
}
@end
