//
//  RecordingInfoVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/1.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordingInfoVC.h"
#import "RecordInfoLevelHandler.h"
#import "ListeningVC.h"
#import "DebugUtil.h"

@interface RecordingInfoVC ()

@end

@implementation RecordingInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        [self setBaseLevelHandler:[[RecordInfoLevelHandler alloc]initWithNowVC:self]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationController *nc = [self navigationController];
    [nc setNavigationBarHidden:TRUE];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordAgain:(id)sender
{
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)[self baseLevelHandler];
    if (FALSE == [handler recordAgain]) {
        CHECK_NOT_ENTER_HERE;
    }
}
- (IBAction)listen:(id)sender
{
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)[self baseLevelHandler];
    if (FALSE == [handler listen]) {
        CHECK_NOT_ENTER_HERE;
    }
}

- (IBAction)submit:(id)sender
{
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)[self baseLevelHandler];
    if (FALSE == [handler submit]) {
        CHECK_NOT_ENTER_HERE;
    }
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toListen"]) {
        RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)sender;
        ListeningVC *vc = [segue destinationViewController];
        [handler setNextVC:vc];
    }
}
@end