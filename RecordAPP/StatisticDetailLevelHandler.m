//
//  StatisticDetailLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticDetailLevelHandler.h"
#import "RecordInfo.h"
#import "DebugUtil.h"
#import "TimerHandler.h"

@interface StatisticDetailLevelHandler()
@property (nonatomic, strong) TimerHandler* timerHandler;
@end

@implementation StatisticDetailLevelHandler
@synthesize timerHandler = _timerHandler;
@synthesize info = _info;

+ (StatisticDetailLevelHandler*) getInst
{
    static StatisticDetailLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
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
        if (nil == [self timerHandler]) {
            [self setTimerHandler:[[TimerHandler alloc] init]];
        }
    }
    return self;
}

- (float) getRecordTime
{
#pragma mark (TODO) Shold get Record Time by Functional handler (should here?)
    return 5;
}

- (BOOL) start
{
    if (nil == [self timerHandler]) {
        DLog(@"Doesn't have timer");
        CHECK_NOT_ENTER_HERE;
    }
    if (FALSE == [[self timerHandler] timeToStart:[self getRecordTime]]) {
        DLog(@"Cannot start the timer");
        CHECK_NOT_ENTER_HERE;
    }
    return TRUE;
}

- (BOOL) stop
{
    if (FALSE == [[self timerHandler] stop]) {
        DLog(@"Cannot stop the timer");
        CHECK_NOT_ENTER_HERE;
    }
    return TRUE;
}


@end
