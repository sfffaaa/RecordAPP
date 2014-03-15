//
//  TimerHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIMER_TICK_EVENT @"timerTickEvent"
#define TIMER_STOP_EVENT @"timerStopEvent"
#define REMAIN_TIME @"remainTime"

@interface TimerHandler : NSObject

+ (BOOL) getRemainTimeFromEvent:(NSNotification*) notification float:(float*)value;
- (BOOL) timeToStart: (float) time;
- (BOOL) stop: (BOOL) needSendEvent;

@end
