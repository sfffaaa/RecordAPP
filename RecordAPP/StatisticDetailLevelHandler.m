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

- (void) setInfo:(RecordInfo *)info
{
    _info = info;
    [_recordActionHandler setDate:[_info date]];
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

- (float) getActionTime
{
    return [_recordActionHandler getActionTime];
}

- (BOOL) start
{
    if (nil == _info || nil == [_info date]) {
        DLog("wron param in [%@] or [%@]", _info, [_info date]);
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }

    if (FALSE == [_recordActionHandler start]) {
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
    return FALSE;
}

- (BOOL) manualStop
{
    if (false == [_recordActionHandler manualStop]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (int) getPerpareTime
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}
- (BOOL) prepareStart
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}
- (BOOL) prepareStop
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}


@end
