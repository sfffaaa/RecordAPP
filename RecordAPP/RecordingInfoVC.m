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
#import "WakeupHandler.h"
#import "DebugUtil.h"

@interface RecordingInfoVC ()

@end

@implementation RecordingInfoVC

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
//        [self setBaseLevelHandler:[[RecordInfoLevelHandler alloc]initWithNowVC:self]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [[NSString alloc] initWithFormat:@"%@", [[WakeupHandler getInst] nowWakeupDate]];
    
    [[WakeupHandler getInst] setSetuped:TRUE];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[WakeupHandler getInst] setSetuped:FALSE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordAgain:(id)sender
{
//    if (nil == [self baseLevelHandler]) {
//        CHECK_NOT_ENTER_HERE;
//    }
//    RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)[self baseLevelHandler];
//    if (FALSE == [handler recordAgain]) {
//        CHECK_NOT_ENTER_HERE;
//    }
}
- (IBAction)listen:(id)sender
{
//    if (nil == [self baseLevelHandler]) {
//        CHECK_NOT_ENTER_HERE;
//    }
//    RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)[self baseLevelHandler];
//    if (FALSE == [handler listen]) {
//        CHECK_NOT_ENTER_HERE;
//    }
}

- (IBAction)submit:(id)sender
{
//    if (nil == [self baseLevelHandler]) {
//        CHECK_NOT_ENTER_HERE;
//    }
//    RecordInfoLevelHandler* handler = (RecordInfoLevelHandler*)[self baseLevelHandler];
//    if (FALSE == [handler submit]) {
//        CHECK_NOT_ENTER_HERE;
//    }

#pragma mark (TODO) Need check why dismiss 2 controller;
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"test"];
//    [window setRootViewController:mainViewController];
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
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