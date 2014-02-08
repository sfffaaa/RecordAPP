//
//  InitializatorLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/29.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//
#import "InitializatorLevelHandler.h"
#import "DebugUtil.h"

@interface InitializatorLevelHandler()
@end

@implementation InitializatorLevelHandler

- (BOOL) setStatus
{
    //Set business logic
    BusinessLogicHandler* handler = [BusinessLogicHandler getBusinessLogicHanlder];
    if (nil == handler) {
        return FALSE;
    }
    [handler setNowState:INIT_STATE];
    
    //Initialize (now just wait 3 second)
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fireInitialedEvent) userInfo:nil repeats:NO];
    return YES;
}

- (void) fireInitialedEvent
{
    [[NSNotificationCenter defaultCenter] postNotificationName: INITIAL_EVENT object:self];
}

@end
