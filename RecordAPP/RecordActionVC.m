//
//  RecordActionVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordActionVC.h"
#import "TimerHandler.h"
#import "RecordActionLevelHandler.h"
#import "RecordingInfoVC.h"
#import "DebugUtil.h"

#define kTimeLabelTag 1

@interface RecordActionVC ()
@property (nonatomic, weak) RecordActionLevelHandler* levelHandler;
@end

@implementation RecordActionVC
@synthesize levelHandler = _levelHandler;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        _levelHandler = [RecordActionLevelHandler getInst];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerTick:) name:TIMER_TICK_EVENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerStop:) name:TIMER_STOP_EVENT object:nil];
    
#pragma mark (TODO) Configure record info to vc
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%i", [[self levelHandler] getPerpareTime]];
    
    [_levelHandler prepareStart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event handler
- (void)timerTick:(NSNotification*) notification
{
    float value = 0;
    if (FALSE == [TimerHandler getRemainTimeFromEvent:notification float:&value]) {
        DLog(@"cannot get the remain time");
        CHECK_NOT_ENTER_HERE;
    }
    //And show it.
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%.0f", value];
}

- (void)timerStop:(NSNotification*) notification
{
    if (TRUE == [_levelHandler isPrepare]) {
        [self prepareStop];
    } else {
        [self actionStop];
    }
}

- (void) prepareStop
{
    if (FALSE == [_levelHandler prepareStop]) {
        CHECK_NOT_ENTER_HERE;
    }
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%.0f", [[self levelHandler] getRecordTime]];
    if (FALSE == [_levelHandler start]) {
        CHECK_NOT_ENTER_HERE;
    }
}

- (void) actionStop
{
    if (FALSE == [_levelHandler stop]) {
        CHECK_NOT_ENTER_HERE;
    }
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%i", [[self levelHandler] getPerpareTime]];

}

@end