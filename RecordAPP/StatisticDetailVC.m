//
//  StatisticDetailVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticDetailVC.h"
#import "StatisticDetailLevelHandler.h"
#import "RecordInfo.h"
#import "Util.h"
#import "TimerHandler.h"
#import "DebugUtil.h"

#define kTimeLabelTag 1

#pragma mark (TODO) Change button color when touch
#pragma mark (TODO) Duplicate code with RecordActionVC

@interface StatisticDetailVC ()
@property (nonatomic, weak) StatisticDetailLevelHandler* levelHandler;
@end

@implementation StatisticDetailVC
@synthesize levelHandler = _levelHandler;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _levelHandler = [StatisticDetailLevelHandler getInst];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerTick:) name:TIMER_TICK_EVENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerStop:) name:TIMER_STOP_EVENT object:nil];

    NSString* title = [Util displayStringFromDate:[[[self levelHandler] info] date]];
    if (nil == title) {
        CHECK_NOT_ENTER_HERE;
    }
    [self setTitle:title];
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%.0f", [[[self levelHandler] info] length]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfo:(RecordInfo *)info
{
    [[self levelHandler] setInfo:info];
}

- (IBAction)listenStart:(id)sender {
    if (FALSE == [[self levelHandler] prepareStart]) {
        DLog(@"cannot start listen");
    }
}
- (IBAction)listenStop:(id)sender {
    if (false == [[self levelHandler] stop]) {
        DLog(@"cannot stop listen");
    }
}

#pragma mark - event handler
- (void)timerTick:(NSNotification*) notification
{
    //Get the second from notification
    float value = 0;
    if (FALSE == [TimerHandler getRemainTimeFromEvent:notification float:&value]) {
        DLog(@"cannot get the remain time");
        CHECK_NOT_ENTER_HERE;
    }
    //And show it.
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%f", value];
    
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
