//
//  InitializatorLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/29.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "InitializatorLevelHandler.h"
#import "RecordLevelHandler.h"
#import "DebugUtil.h"

@interface InitializatorLevelHandler()
@property (nonatomic, strong) UIView* initialView;
@end

@implementation InitializatorLevelHandler
@synthesize initialView = _initialView;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _initialView = [[[NSBundle mainBundle] loadNibNamed:@"InitView" owner:[self nowVC] options:nil] objectAtIndex:0];
    }
    return self;
}

- (BOOL) startInitialize
{
    //   3. Add subview;

    [[self nowVC].view addSubview:[self initialView]];
    
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
    if (RECORDING_VOICE_STATE == nextState) {
        //1. go back to recording voice state
        //2. go to record text state immediately.
#pragma mark - (TODO) Not implement RECORDING_VOICE_STATE yet
        CHECK_NOT_ENTER_HERE;
    } else {
        [[self initialView] removeFromSuperview];
        return [[self nowVC] baseLevelHandler];
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
