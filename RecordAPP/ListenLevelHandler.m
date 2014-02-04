//
//  ListenLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/4.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ListenLevelHandler.h"
#import "DebugUtil.h"
#import <UIKit/UIKit.h>

//Include recording and decide where to store.
@interface ListenLevelHandler()
@property (nonatomic, weak) UIView* stopView;
@end

@implementation ListenLevelHandler
@synthesize stopView = _stopView;

- (id) initWithNowVC: (id)VC
{
    id here = [self init];
    [self setNowVC:VC];
    return here;
}

#pragma mark BusinessLogicProtocol Implement
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
    if (LISTENING_VOICE_STATE == nextState) {
        if (nil !=[self stopView]) {
            CHECK_NOT_ENTER_HERE;
        }
        //1. Create the superview
        UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"RecordListenStop" owner:[self nowVC] options:nil] objectAtIndex:0];
        [self setStopView:view];
        
        // Animation
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:[self nowVC].view cache:YES];
        //2. Put view to view controller
        [[self nowVC].view addSubview:view];
        [UIView commitAnimations];
        *handler = [[self nowVC] baseLevelHandler];
        return 0;
    } else if (RECORD_TEXT_STATE == nextState) {
        CHECK_NOT_ENTER_HERE;
        //1. Remove the superview
        [[self stopView] removeFromSuperview];
        [self setStopView:nil];
        //2. Segue to next
        [[self nowVC] performSegueWithIdentifier:@"toRecordingText" sender:self];
        //3. Set view controller and baseLevelHandler;
        //4. Final setup
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
    if (LISTEN_VOICE_START_STATE != nextState) {
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
