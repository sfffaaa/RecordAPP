//
//  RecordLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordLevelHandler.h"
#import "DebugUtil.h"
#import <UIKit/UIKit.h>

//Include recording and decide where to store.
@interface RecordLevelHandler()
@property (nonatomic, weak) UIView* stopView;
@end

@implementation RecordLevelHandler
@synthesize stopView = _stopView;

- (id) initWithNowVC: (id)VC
{
    id here = [self init];
    [self setNowVC:VC];
    return here;
}

#pragma mark RecordActionProtocol Implement
- (RECORD_ACTION_TYPE) getActionType
{
    return RECORD_ACTION;
}

- (int) getTotalTime
{
    return 1000;
}
- (int) getRemainTime
{
    return 10;
}
- (BOOL) setFilePath: (NSString*) filePath
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}
- (NSString*) getFilePath
{
    CHECK_NOT_ENTER_HERE;
    return nil;
}

- (NSString*) getRecordingPath
{
    //call record file handler
    return @"aaaa";
}

- (BOOL) start
{
    /*
     * 1. Prepare all data.
     * 2. Register a event handler (callback function) for time up.
     * 3. goto next;
     *
     */
    
    // 3. goto next;
    [self setStoredNextState:RECORDING_VOICE_STATE];
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return NO;
    }

    return TRUE;
}
- (BOOL) stop
{
    //1. Call record handler to stop record
    //2. Maybe we can record the time into database?
    //3. Maybe we can upload the record file to ds?
    [self setStoredNextState:RECORD_TEXT_STATE];
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return NO;
    }
    

    return TRUE;
}

#pragma mark BusinessLogicProtocol Implement
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
        if (nil !=[self stopView]) {
            CHECK_NOT_ENTER_HERE;
        }
        //1. Create the superview
        UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"RecordStopView" owner:[self nowVC] options:nil] objectAtIndex:0];
        [self setStopView:view];
        
        // Animation
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:[self nowVC].view cache:YES];
        //2. Put view to view controller
        [[self nowVC].view addSubview:view];
        [UIView commitAnimations];
        return [[self nowVC] baseLevelHandler];
    } else if (RECORD_TEXT_STATE == nextState) {
        //1. Remove the superview
        [[self stopView] removeFromSuperview];
        [self setStopView:nil];
        //2. Segue to next
        [[self nowVC] performSegueWithIdentifier:@"toRecordingText" sender:nil];
        //3. Set view controller and baseLevelHandler;
        [[[self nowVC] navigationController] setNavigationBarHidden:FALSE];
        return [[self nowVC] baseLevelHandler];

    }
    return 0;
}

- (int) checkTo:(STATE_TYPE)nextState
{
    int ret = -1;
    STATE_TYPE nowState = [BusinessLogicHandler getNowStat];
    
    //From each state
    if (RECORD_VOICE_START_STATE != nowState &&
        RECORDING_VOICE_STATE != nowState) {
        goto END;
    }
    //To here
    if (RECORDING_VOICE_STATE != nextState &&
        RECORD_TEXT_STATE != nextState) {
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
