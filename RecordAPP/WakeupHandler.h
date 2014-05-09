//
//  WakeupHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WakeupHandler : NSObject
@property (nonatomic, strong) NSDate* nowWakeupDate;
@property (nonatomic) BOOL setuped;
+ (WakeupHandler*) getInst;
+ (void) emitWakeupStartEvent;
+ (void) emitWakeupReloadEvent;
+ (void) emitWakeupStopEvent;
+ (void) wakeUp;

- (BOOL) rescheduleNotification;
@end
