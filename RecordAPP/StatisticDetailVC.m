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
#import "TimerHandler.h"
#import "DebugUtil.h"

#define kTimeLabelTag 1

#pragma mark (TODO) Change button color when touch

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

	// Do any additional setup after loading the view.
#pragma mark (TODO) Configure record info to vc
    if (nil == [[self levelHandler] info]) {
        DLog(@"info isn't correct");
        CHECK_NOT_ENTER_HERE;
    }
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%f", [[self levelHandler] getRecordTime]];
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
    if (FALSE == [[self levelHandler] start]) {
        DLog(@"cannot start listen");
    }
}
- (IBAction)listenStop:(id)sender {
    if (false == [[self levelHandler] stop]) {
        DLog(@"cannot stop listen");
    }
}

- (IBAction)forTestPush:(id)sender {
#pragma mark (TODO) Need remove
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RecordTime" bundle:nil];
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"timeToRecord"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:mainViewController animated:YES completion:nil];

//    [self addChildViewController:mainViewController];
//    [self.view addSubview: mainViewController.view];

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
    ((UILabel*)[self.view viewWithTag:kTimeLabelTag]).text = [[NSString alloc] initWithFormat:@"%f", [[self levelHandler] getRecordTime]];
}

@end
