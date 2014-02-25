//
//  RecordingInfoVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/1.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordingInfoVC.h"
#import "RecordInfoLevelHandler.h"
#import "DebugUtil.h"

#pragma mark (TODO) WakeupHandler should hide into levelHandler;

@interface RecordingInfoVC ()
@property (nonatomic, weak) RecordInfoLevelHandler* levelHandler;

@end

@implementation RecordingInfoVC
@synthesize levelHandler = _levelHandler;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        _levelHandler = [RecordInfoLevelHandler getInst];
    }
    return self;
}

- (void)viewDidLoad
{
    if (FALSE == [_levelHandler setUp]) {
        CHECK_NOT_ENTER_HERE;
    };

    [super viewDidLoad];
    self.title = [[NSString alloc] initWithFormat:@"%@", [_levelHandler date]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (FALSE == [_levelHandler setDown]) {
        CHECK_NOT_ENTER_HERE;
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
    if (FALSE == [_levelHandler submit]) {
        CHECK_NOT_ENTER_HERE;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (FALSE == [_levelHandler setActionWakupDate]) {
        CHECK_NOT_ENTER_HERE;
    }

    if ([[segue identifier] isEqualToString:@"toListen"]) {
        if (FALSE == [_levelHandler setAction:LISTEN_ACTION]) {
            CHECK_NOT_ENTER_HERE;
        };
    } else if ([[segue identifier] isEqualToString:@"toRecord"]) {
        if (FALSE == [_levelHandler setAction:RECORD_ACTION]) {
            CHECK_NOT_ENTER_HERE;
        }
    }
}
@end