//
//  InitializatorLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/29.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "InitializatorLevelHandler.h"
#import "RecordLevelHandler.h"
#import "DebugUtil.h"
#import <UIKit/UIKit.h>

@implementation InitializatorLevelHandler

- (BOOL) startInitialize
{
    sleep(1);
    DLog(@"start initialization");
    return TRUE;
}

#pragma mark - Protocol

- (int) getNextState:(STATE_TYPE*) pNextState
{
    int ret = -1;
    if (NULL == pNextState) {
        DLog(@"Wrong parameter");
        goto END;
    }
    if (INIT_STATE == [self storedNextState]) {
        DLog(@"No next step");
        goto END;
    } else {
        *pNextState = [self storedNextState];
    }
    
    ret = 0;
END:
    return ret;
}

- (id<BusinessLogicProtocol>) goTo:(STATE_TYPE)nextState
{
    id nextHandler = nil;
    if (RECORDING_VOICE_STATE == nextState) {
        //1. go back to recording voice state
        //2. go to record text state immediately.
    } else {
        [[self nowVC].view removeFromSuperview];
        return [[self nowVC] recordAction];
    }
    return 0;
}

- (int) checkTo:(STATE_TYPE)nextState
{
    int ret = -1;
    STATE_TYPE nowState = [BusinessLogicHandler getNowStat];

    //From each state
    if (INIT_STATE != nowState) {
        goto END;
    }
    //To here
    if (INIT_STATE == nextState) {
        goto END;
    }
    
    ret = 0;
END:
    if (0 != ret) {
        DLog(@"Wrong state from [%i] to [%i]", nowState, nextState);
    }
    return ret;
}
@end
