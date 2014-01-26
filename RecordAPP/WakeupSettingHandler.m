//
//  WakeupSettingHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "WakeupSettingHandler.h"
#import "DebugUtil.h"

@implementation WakeupSettingHandler
@synthesize periodDate = _periodDate;
@synthesize runWakeUp = _runWakeUp;
@synthesize nextWakeupDate = _nextWakeupDate;

- (id) init
{
    #pragma mark (TODO) below should be the singleton
    self = [super init];
    if (nil != self) {
        #pragma mark (TODO) now for debug
        _periodDate = [[NSDate alloc] initWithTimeIntervalSinceNow:DEBUG_WAKEUP_PERIOD_DATE];
        _nextWakeupDate = [[NSDate alloc] initWithTimeIntervalSinceNow:DEBUG_WAKEUP_NEXT_WAKEUP_DATE];
        _runWakeUp = DEBUG_WAKEUP_RUN_WAKE;
    }
    return self;
}

@end
