//
//  RecordInfoLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfoLevelHandler.h"
#import "RecordingViewController.h"
#import "RecordInfoHandler.h"
#import "DebugUtil.h"
#import "RecordInfo.h"

@interface RecordInfoLevelHandler()

@property (nonatomic, weak) RecordInfoHandler* handler;
@end

@implementation RecordInfoLevelHandler
@synthesize handler = _handler;

- (id) initWithNowVC: (id)VC
{
    id here = [self init];
    [self setNowVC:VC];
    
    return here;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        RecordInfoHandler* handler = [RecordInfoHandler getRecordInfoHandler];
        if (nil == handler) {
            CHECK_NOT_ENTER_HERE;
        }
        _handler = handler;
    }
    return self;
}

- (BOOL) setRecordInfoName
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}

- (BOOL) submit
{
//    CHECK_NOT_ENTER_HERE
    return FALSE;
}

- (BOOL) listen
{
    //goto listen page
    [self setStoredNextState:LISTEN_VOICE_START_STATE];
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return FALSE;
    }
    return TRUE;
}

- (BOOL) recordAgain
{
    //1. Store some information user enter.
#pragma mark (TODO) Need to store some information user enters.
    /*
     *  The record info should extract to a handler to deal with it.
     *  It is because info should be show when reentering recordinfoVC.
     */
    //2. Set business logic things.
    [self setStoredNextState:RECORD_VOICE_START_STATE];
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return NO;
    }
    //3. Goto next;
    RecordLevelHandler* handler = (RecordLevelHandler*)[[BusinessLogicHandler getBusinessLogicHanlder] handler];
    RecordingViewController* vc = (RecordingViewController*)[handler nowVC];
    [vc actionStart:nil];
#pragma mark (TODO) Maybe has memory leak.


    return TRUE;
}

#pragma mark - BusinessLogicProtocol Implement
- (int) getNextState:(STATE_TYPE*) pNextState
{
    int ret = -1;
    if (NULL == pNextState) {
        DLog(@"Wrong parameter");
        goto END;
    }
    *pNextState = [self storedNextState];
    
    ret = 0;
END:
    return ret;
}

- (int) goTo:(STATE_TYPE)nextState levelHandler: (id<BusinessLogicProtocol>*) handler
{
    if (RECORD_VOICE_START_STATE == nextState) {
        //1. Popout to previous view controller
        [[[self nowVC] navigationController] popViewControllerAnimated:TRUE];
        NSArray* array = [[[self nowVC] navigationController] viewControllers];
        //3. Set view controller and baseLevelHandler;
        RecordingViewController* vc = [array objectAtIndex:[array count] - 1];
        //4. Final setup
        *handler = [vc baseLevelHandler];
        return 0;
    } else if (LISTEN_VOICE_START_STATE == nextState) {
        //segue to other view controller;
        [[self nowVC] performSegueWithIdentifier:@"toListen" sender:self];
        *handler = [[self nextVC] baseLevelHandler];
        [self setNextVC:nil];
        return 0;
    }
    return -1;
}

- (int) checkTo:(STATE_TYPE)nextState
{
    int ret = -1;
    STATE_TYPE nowState = [BusinessLogicHandler getNowStat];
    
    //From each state
    if (RECORD_TEXT_STATE != nowState) {
        goto END;
    }
    //To here
    if (RECORD_VOICE_START_STATE != nextState &&
        LISTEN_VOICE_START_STATE != nextState) {
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
