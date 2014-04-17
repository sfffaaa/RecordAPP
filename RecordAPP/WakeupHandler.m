//
//  WakeupHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "WakeupHandler.h"
#import "DebugUtil.h"
#import "NextWakeupTimeSetupElement.h"
#import "WakeupPeriodSetupElement.h"
#import "RunWakeupSetupElement.h"

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
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"timeToRecord"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:mainViewController animated:YES completion:nil];
}

- (BOOL) setupLocalNotification
{
    RunWakeupSetupElement* runWakeupSetupElement = [[RunWakeupSetupElement alloc] init];
    if (FALSE == [runWakeupSetupElement getWakeupValue]) {
        DLog(@"should enter in false");
        return TRUE;
    }
    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];

    NSDate* nextWakupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[nextWakeupTimeSetupElement getNextWakeupTime]];
    NSDate* nowDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    while (NSOrderedDescending == [nowDate compare:nextWakupDate] ||
           NSOrderedSame == [nowDate compare:nextWakupDate]) {
        nextWakupDate = [[NSDate alloc] initWithTimeInterval:[wakeupPeriodSetupElement getWakeupPeriod] sinceDate:nextWakupDate];
    }
    
    for (int i = 0; i < 10; i++) {
        UILocalNotification* notification = [[UILocalNotification alloc] init];
#pragma mark (TODO) Need to check default time zone
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count] + 1;
        notification.alertAction = [[NSString alloc] initWithFormat:@"Just for test"];
        notification.fireDate= [[NSDate alloc] initWithTimeInterval:i*[wakeupPeriodSetupElement getWakeupPeriod] sinceDate:nextWakupDate];
        notification.alertBody = [[NSString alloc] initWithFormat:@"next date %@", notification.fireDate];

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
    NSDate* nowDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSDate* nextDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[nextWakeupTimeSetupElement getNextWakeupTime]];
    if (NSOrderedDescending == [nowDate compare:nextDate] ||
        NSOrderedSame == [nowDate compare:nextDate]) {
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
    NSDate* nextWakeupDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[nextWakeupTimeSetupElement getNextWakeupTime]];
    NSDate* nowDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    
    while (NSOrderedDescending == [nowDate compare:nextWakeupDate] ||
           NSOrderedSame == [nowDate compare:nextWakeupDate]) {
        nextWakeupDate = [[NSDate alloc] initWithTimeInterval:[wakeupPeriodSetupElement getWakeupPeriod] sinceDate:nextWakeupDate];
    }
    [nextWakeupTimeSetupElement setElementValue:nextWakeupDate];
    DLog(@"test %@", nextWakeupDate);
    
    //5. wake up the vc
    [self presentVC];
}

@end
