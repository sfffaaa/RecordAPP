//
//  RecordingViewController.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/27.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordingViewController.h"
#import "RecordLevelHandler.h"
#import "RecordingInfoVC.h"
#import "DebugUtil.h"

@implementation RecordingViewController

//Doesn't call by storyboard
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (NSOrderedSame == [nibNameOrNil compare:@"RecordStartView"]) {
            [self setBaseLevelHandler:[[RecordLevelHandler alloc]initWithNowVC:self]];
        } else if (NSOrderedSame == [nibNameOrNil compare:@"RecordListenStartView"]) {
            CHECK_NOT_ENTER_HERE;
        } else {
            CHECK_NOT_ENTER_HERE;
        }
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBaseLevelHandler:[[RecordLevelHandler alloc]initWithNowVC:self]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)actionStart:(UIButton *)sender
{
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    if (FALSE == [[self baseLevelHandler] conformsToProtocol:@protocol(RecordActionProtocol)]) {
        DLog(@"baselevelhandler doesn't has RecordActionProtocol (%@)", NSStringFromClass([[self baseLevelHandler] class]));
        CHECK_NOT_ENTER_HERE;
    }
    id<RecordActionProtocol> recordAction = (id<RecordActionProtocol>)[self baseLevelHandler];
    if (FALSE == [recordAction start]) {
        DLog(@"Class() record cannot start");
        CHECK_NOT_ENTER_HERE;
    }
}

- (IBAction)actionStop:(UIButton *)sender
{
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    if (FALSE == [[self baseLevelHandler] conformsToProtocol:@protocol(RecordActionProtocol)]) {
        DLog(@"baselevelhandler doesn't has RecordActionProtocol (%@)", NSStringFromClass([[self baseLevelHandler] class]));
        CHECK_NOT_ENTER_HERE;
    }
    id<RecordActionProtocol> recordAction = (id<RecordActionProtocol>)[self baseLevelHandler];
    if (FALSE == [recordAction stop]) {
        DLog(@"Class() record cannot start");
        CHECK_NOT_ENTER_HERE;
    }
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toRecordingText"]) {
        RecordLevelHandler* handler = sender;
        RecordingInfoVC *vc = [segue destinationViewController];
        [handler setNextVC:vc];
    }
}
@end
