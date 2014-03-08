//
//  StatisticDetailLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticDetailLevelHandler.h"
#import "RecordActionLevelHandler.h"
#import "RecordInfo.h"
#import "ListeningAction.h"
#import "DebugUtil.h"
#import "AudioFileHandler.h"
#import "TimerHandler.h"

@interface StatisticDetailLevelHandler()
@property (nonatomic, strong) RecordActionLevelHandler* recordActionHandler;
@end

@implementation StatisticDetailLevelHandler
@synthesize recordActionHandler = _recordActionHandler;
@synthesize info = _info;

+ (StatisticDetailLevelHandler*) getInst
{
    static StatisticDetailLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[StatisticDetailLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        if (nil == _recordActionHandler) {
            _recordActionHandler = [[RecordActionLevelHandler alloc] init];
            [_recordActionHandler setAction:[[ListeningAction alloc] init]];
        }
    }
    return self;
}

- (int) getPerpareTime
{
    return [_recordActionHandler getPerpareTime];
}

- (float) getRecordTime
{
    return [_recordActionHandler getActionTime];
}

- (BOOL) prepareStart
{
    if (nil == _info || nil == [_info date]) {
        DLog("wron param in [%@] or [%@]", _info, [_info date]);
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    [_recordActionHandler setFileURL:[AudioFileHandler getFileURLFromDate:[_info date]]];
    
    if (FALSE == [_recordActionHandler prepareStart]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) start
{
    if (FALSE == [_recordActionHandler start]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) prepareStop
{
    if (FALSE == [_recordActionHandler prepareStop]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) stop
{
    if (FALSE == [_recordActionHandler stop]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) isPrepare
{
    return [_recordActionHandler isPrepare];
}

- (BOOL) manualStop
{
    if (false == [_recordActionHandler manualStop]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

@end
