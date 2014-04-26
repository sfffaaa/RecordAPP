//
//  WakeupHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "WakeupHandler.h"
#import "DebugUtil.h"
#import "Util.h"
#import "NextWakeupTimeSetupElement.h"
#import "WakeupPeriodSetupElement.h"
#import "RunWakeupSetupElement.h"

#define MAX_NOTIFICATION_NUM 10

@implementation WakeupHandler
@synthesize nowWakeupDate = _nowWakeupDate;
@synthesize setuped = _setuped;

+ (WakeupHandler*) getInst
{
    static WakeupHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[WakeupHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        _nowWakeupDate = nil;
        _setuped = FALSE;

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
    if (FALSE == [self setupLocalNotification]) {
        CHECK_NOT_ENTER_HERE;
    };
}

- (void) reload:(NSNotification*) notification
{
#pragma mark (TODO) Need to change!!
    [self start:notification];
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
    UIViewController *timeViewController = [storyboard instantiateViewControllerWithIdentifier:@"timeToRecord"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window makeKeyAndVisible];
    
    [window.rootViewController presentViewController:timeViewController animated:YES completion:nil];

}

- (UILocalNotification*) setupEachNotification:(NSDate*) date
{
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count] + 1;
    notification.alertAction = [[NSString alloc] initWithFormat:@"Just for test"];
    notification.fireDate = date;
    notification.alertBody = [[NSString alloc] initWithFormat:@"next date %@", notification.fireDate];
    
    return notification;
}

- (BOOL) setupLocalNotification
{
    int notifyNum = MAX_NOTIFICATION_NUM;
    RunWakeupSetupElement* runWakeupSetupElement = [[RunWakeupSetupElement alloc] init];
    if (FALSE == [runWakeupSetupElement getWakeupValue]) {
        DLog(@"should enter in false");
        return TRUE;
    }
    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];

    NSDate* nextWakupDate = [[nextWakeupTimeSetupElement getNextWakeupTime] dateByAddingTimeInterval:0];
    
    if (IS_DATE_EQUAL_OR_EARLIER(nextWakupDate, [NSDate date])) {
        UILocalNotification* notification = [self setupEachNotification:nextWakupDate];
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
        notifyNum--;
    }
    
    while (IS_DATE_EQUAL_OR_EARLIER(nextWakupDate, [NSDate date])) {
        nextWakupDate = [nextWakupDate dateByAddingTimeInterval:[wakeupPeriodSetupElement getWakeupPeriod]];
    }
    
    for (int i = 0; i < notifyNum; i++) {
        NSDate* date = [nextWakupDate dateByAddingTimeInterval:i*[wakeupPeriodSetupElement getWakeupPeriod]];
        UILocalNotification* notification = [self setupEachNotification:date];

        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
        DLog(@"test %i [%@]", i, notification.fireDate);
    }

    return TRUE;
}

+ (void) wakeUp
{
    WakeupHandler* wakeupHandler = [WakeupHandler getInst];
    RunWakeupSetupElement* runWakeupSetupElement = [[RunWakeupSetupElement alloc] init];
    if (FALSE == [runWakeupSetupElement getWakeupValue]) {
        return;
    }
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];
    NSDate* nowDate = [[NSDate date] dateByAddingTimeInterval:0];
    NSDate* nextDate = [[nextWakeupTimeSetupElement getNextWakeupTime] dateByAddingTimeInterval:0];

    if (IS_DATE_EQUAL_OR_LATER(nowDate, nextDate)) {
        [wakeupHandler wakeupStartAction];
    }
}

- (void) wakeupStartAction
{
    //1. cancel notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //2. schedule the new event
    if (FALSE == [self setupLocalNotification]) {
        CHECK_NOT_ENTER_HERE;
    }
    
    if (TRUE == [self setuped]) {
        return;
    }
    
    //3. setup now wakeup date in self
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];
    [self setNowWakeupDate:[nextWakeupTimeSetupElement getNextWakeupTime]];
    
    //4. setup the next date in user setup
    if (FALSE == [self nextWakeupTimeSet]) {
        CHECK_NOT_ENTER_HERE;
    }
    
    //5. wake up the vc
    [self presentVC];
}

- (BOOL) nextWakeupTimeSet
{
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];
    
    NSDate* nextWakeupDate = [[nextWakeupTimeSetupElement getNextWakeupTime] dateByAddingTimeInterval:0];

    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    
    while (IS_DATE_EQUAL_OR_EARLIER(nextWakeupDate, [NSDate date])) {
        nextWakeupDate = [nextWakeupDate dateByAddingTimeInterval:[wakeupPeriodSetupElement getWakeupPeriod]];
    }
    [nextWakeupTimeSetupElement setElementValue:nextWakeupDate];
    return TRUE;
}

@end
