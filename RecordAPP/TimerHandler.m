//
//  TimerHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "TimerHandler.h"
#import "DebugUtil.h"

@interface TimerHandler()
@property (nonatomic) float duration;
@property (nonatomic) float remainTime;
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation TimerHandler
@synthesize duration = _duration;
@synthesize remainTime = _remainTime;

+ (BOOL) getRemainTimeFromEvent:(NSNotification*) notification float:(float*)value
{
    BOOL ret = FALSE;
    NSDictionary* dict = nil;
    if (nil == value) {
        DLog(@"input value error");
        goto END;
    }
    if (![notification.name isEqualToString:TIMER_TICK_EVENT]) {
        DLog(@"wrong event (%@)", notification.name);
        goto END;
    }
    
    dict = notification.userInfo;
    *value = [[dict objectForKey:REMAIN_TIME] floatValue];
    
    ret = TRUE;
END:
    return ret;
}


- (BOOL) timeToStart: (float) time
{
    [self setDuration:time];
    [self setRemainTime:time];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    return TRUE;
}

- (BOOL) stop
{
    [self setDuration:0];
    [self setRemainTime:0];
    [_timer invalidate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TIMER_STOP_EVENT object:self];
    
    return TRUE;
}

- (void) tick
{
    _remainTime--;
    if (0 >= _remainTime) {
        if (FALSE == [self stop]) {
            DLog(@"cannot stop");
            CHECK_NOT_ENTER_HERE;
        }
        return;
    }
    
    NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:_remainTime] forKey:REMAIN_TIME];
    [[NSNotificationCenter defaultCenter] postNotificationName:TIMER_TICK_EVENT object:self userInfo:dict];
}

@end
