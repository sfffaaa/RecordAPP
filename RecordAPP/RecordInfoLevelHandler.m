//
//  RecordInfoLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfoLevelHandler.h"
#import "RecordActionLevelHandler.h"
#import "RecordingAction.h"
#import "ListeningAction.h"
#import "WakeupHandler.h"
#import "DBHandler.h"
#import "RecordInfo.h"
#import "AudioFileHandler.h"
#import "NextWakeupTimeSetupElement.h"
#import "WakeupPeriodSetupElement.h"
#import "DebugUtil.h"
#import "Util.h"
#import "EventDefine.h"

@interface RecordInfoLevelHandler()
@end

@implementation RecordInfoLevelHandler
@synthesize date = _date;
@synthesize score = _score;
@synthesize timerHandler = _timerHandler;

+ (RecordInfoLevelHandler*) getInst
{
    static RecordInfoLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[RecordInfoLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        _date = nil;
        _score = 0;
        _timerHandler = [[TimerHandler alloc] init];
    }
    return self;
}

- (BOOL) setUp
{
    _date = [[[WakeupHandler getInst] nowWakeupDate] dateByAddingTimeInterval:0];
    
    [[WakeupHandler getInst] setSetuped:TRUE];
    return TRUE;
}

- (BOOL) setDown
{
    [[WakeupHandler getInst] setSetuped:FALSE];
    return TRUE;
}

- (BOOL) setAction:(RECORD_ACTION_TYPE)actionType
{
    RecordActionLevelHandler* handler = [RecordActionLevelHandler getInst];
    if (LISTEN_ACTION == actionType) {
        [handler setAction:[[ListeningAction alloc] init]];
    } else if (RECORD_ACTION == actionType) {
        [handler setAction:[[RecordingAction alloc] init]];
    }
    return TRUE;
}

- (BOOL) setActionWakupDate: (id)nextHandler;
{
    if (TRUE == [nextHandler isKindOfClass:[RecordActionLevelHandler class]]) {
        RecordActionLevelHandler* handler = nextHandler;
        [handler setDate:_date];
    }
    
    return TRUE;
}

- (BOOL) isRecorded
{
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:[[AudioFileHandler getFileURLFromDate:_date] path]]) {
        return FALSE;
    }
    return TRUE;
}

- (BOOL) submit
{
    //stat whether the file is exist or not
    if (FALSE == [self isRecorded]) {
        DLog(@"Cannot submit because not record yet");
        return FALSE;
    }
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:[[AudioFileHandler getFileURLFromDate:_date] path]]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    //Add information to db
    RecordInfo* info = nil;
    if (nil == (info = [self composeRecordInfo])) {
        CHECK_NOT_ENTER_HERE
        return FALSE;
    }
    DBHandler* handler = [DBHandler getInst];
    if (nil == handler) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (FALSE == [handler push:info]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];
    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    NSDate* date = [_date dateByAddingTimeInterval:0];
    
    while (IS_DATE_EQUAL_OR_EARLIER(date, [NSDate date])) {
        date = [date dateByAddingTimeInterval:[wakeupPeriodSetupElement getWakeupPeriod]];
    }
    [nextWakeupTimeSetupElement setElementValue:date];
    [[NSNotificationCenter defaultCenter] postNotificationName: TABLE_RELOAD_EVENT object:self];
    
    return TRUE;
}

- (RecordInfo*) composeRecordInfo
{
    RecordInfo* info = [[RecordInfo alloc] init];
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    [info setDate:_date];
#pragma mark (TODO) setup the score bar
    [info setScore:_score];

#pragma mark (TODO) when leave the recording, should stop recording, or now will get 0 length.
    float audioSecond = [AudioFileHandler getAudioLengthFromDate:_date];
    if (0 == audioSecond) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    [info setLength:audioSecond];
    
    return info;
}

@end
