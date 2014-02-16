//
//  WakeupHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "WakeupHandler.h"
#import "UserSetting.h"
#import "DebugUtil.h"

@implementation WakeupHandler

+ (void) registHandler
{
    static WakeupHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[WakeupHandler alloc] init];
        });
    }
}

- (id) init
{
    self = [super init];
    if (nil != self) {

        //heard event
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start:) name:WAKEUP_START_EVENT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stop:) name:WAKEUP_STOP_EVNET object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:WAKEUP_RELOAD_EVENT object:nil];
    }
    return self;
}

+ (void) emitWakeupStartEvent
{
    [[NSNotificationCenter defaultCenter] postNotificationName: WAKEUP_START_EVENT object:self];
}

+ (void) emitWakeupStopEvent
{
    [[NSNotificationCenter defaultCenter] postNotificationName: WAKEUP_STOP_EVNET object:self];
}

+ (void) emitWakeupReloadEvent
{
    [[NSNotificationCenter defaultCenter] postNotificationName: WAKEUP_RELOAD_EVENT object:self];
}

- (void) start:(NSNotification*) notification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    DLog(@"start");
    [self setupLocalNotification];
//    [self presentVC];
}

- (void) reload:(NSNotification*) notification
{
    DLog(@"reload");
}

- (void) stop:(NSNotification*) notification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    DLog(@"stop");
}

- (void) presentVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RecordTime" bundle:nil];
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"timeToRecord"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:mainViewController animated:YES completion:nil];
}

- (BOOL) setupLocalNotification
{
    UserSetting* userSetting = [[UserSetting alloc] init];
    if (FALSE == [userSetting runwakeup]) {
        DLog(@"should enter in false");
        return TRUE;
    }

    for (int i = 0; i < 10; i++) {
        UILocalNotification* notification = [[UILocalNotification alloc] init];
#pragma mark (TODO) Need to check default time zone
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count] + 1;
        notification.alertAction = [[NSString alloc] initWithFormat:@"Just for test"];
        notification.alertBody = [[NSString alloc] initWithFormat:@"next date %@", [userSetting nextWakeupDate]];
        DLog(@"now date %@", [[NSDate alloc] initWithTimeIntervalSinceNow:0]);
        DLog(@"next date %@", [userSetting nextWakeupDate]);
        notification.fireDate= [[NSDate alloc] initWithTimeInterval:i*[userSetting wakeupPeriod] sinceDate:[userSetting nextWakeupDate]];
        
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];

    }

    return TRUE;
}

+ (void) wakeupAction
{
}

@end
