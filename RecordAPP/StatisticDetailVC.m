//
//  StatisticDetailVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticDetailVC.h"
#import "StatisticDetailLevelHandler.h"
#import "RecordInfoProtocol.h"
#import "Util.h"
#import "TimerHandler.h"
#import "DebugUtil.h"

#define kTimeLabelTag 1
#define kListenLabelTag 2

#define kListenStartButtonTag 3
#define kListenStopButtonTag 4

#define NO_LISTEN_LABEL @"Listen"
#define LISTENING_LABEL @"Listening"

#pragma mark (TODO) Change button color when touch
#pragma mark (TODO) Duplicate code with RecordActionVC

@interface StatisticDetailVC ()
@property (nonatomic) BOOL listening;
@property (nonatomic, weak) StatisticDetailLevelHandler* levelHandler;
@end

@implementation StatisticDetailVC
@synthesize levelHandler = _levelHandler;
@synthesize listening = _listening;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _levelHandler = [StatisticDetailLevelHandler getInst];
        _listening = FALSE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerTick:) name:TIMER_TICK_EVENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerStop:) name:TIMER_STOP_EVENT object:nil];

    [self setTitle:[Util displayStringFromDate:[[[self levelHandler] info] date]]];
    
    if (FALSE == [_levelHandler prepareActions]) {
        CHECK_NOT_ENTER_HERE;
    }
    
    [self setListenRelatedView];
}

- (void) setListenRelatedView
{
    if (FALSE == _listening) {
        ((UILabel*)[self.view viewWithTag:kListenLabelTag]).text = [[NSString alloc] initWithFormat:@"%@", NO_LISTEN_LABEL];
        
        UIButton* button = ((UIButton*)[self.view viewWithTag:kListenStartButtonTag]);
        [button setTitleColor:[Util userClickableButtonColor] forState:UIControlStateNormal];
        button = ((UIButton*)[self.view viewWithTag:kListenStopButtonTag]);
        [button setTitleColor:[Util userDisableButtonColor] forState:UIControlStateNormal];
        
        ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:SECOND_FORMAT, [[self levelHandler] getActionTime]];
    } else {
        ((UILabel*)[self.view viewWithTag:kListenLabelTag]).text = [[NSString alloc] initWithFormat:@"%@", LISTENING_LABEL];
        
        UIButton* button = ((UIButton*)[self.view viewWithTag:kListenStartButtonTag]);
        [button setTitleColor:[Util userDisableButtonColor] forState:UIControlStateNormal];
        button = ((UIButton*)[self.view viewWithTag:kListenStopButtonTag]);
        [button setTitleColor:[Util userClickableButtonColor] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfo:(id<RecordInfoProtocol>)info
{
    [[self levelHandler] setInfo:info];
}

- (IBAction)listenStart:(id)sender {
    _listening = TRUE;
    [self setListenRelatedView];
    if (FALSE == [[self levelHandler] start]) {
        DLog(@"cannot start listen");
    }
}
- (IBAction)listenStop:(id)sender {
    if (false == [[self levelHandler] manualStop]) {
        DLog(@"cannot stop listen");
    }
    _listening = FALSE;
    [self setListenRelatedView];
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
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:SECOND_FORMAT, value];
}

- (void)timerStop:(NSNotification*) notification
{
    [self actionStop];
}

- (void) actionStop
{
    if (FALSE == [_levelHandler stop]) {
        CHECK_NOT_ENTER_HERE;
    }
    _listening = FALSE;
    [self setListenRelatedView];

}

@end
