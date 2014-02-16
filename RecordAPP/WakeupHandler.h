//
//  WakeupHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WAKEUP_RELOAD_EVENT @"wakeupReloadEvent"
#define WAKEUP_START_EVENT @"wakeupStartEvent"
#define WAKEUP_STOP_EVNET @"wakeupStopEvent"

@interface WakeupHandler : NSObject
+ (void) registHandler;
+ (void) emitWakeupStartEvent;
+ (void) emitWakeupReloadEvent;
+ (void) emitWakeupStopEvent;
+ (void) wakeupAction;
@end
