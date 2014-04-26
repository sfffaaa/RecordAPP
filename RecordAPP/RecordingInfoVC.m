//
//  RecordingInfoVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/1.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordingInfoVC.h"
#import "RecordActionVC.h"
#import "RecordInfoLevelHandler.h"
#import "DebugUtil.h"
#import "Util.h"

#pragma mark (TODO) WakeupHandler should hide into levelHandler;

#define kHappinessLabelTag 1
#define kRecordButtonTag 2
#define kListenButtonTag 3
#define kSubmitButtonTag 4

@interface RecordingInfoVC ()
@property (nonatomic, weak) RecordInfoLevelHandler* levelHandler;

@end

@implementation RecordingInfoVC
@synthesize levelHandler = _levelHandler;
@synthesize slider = _slider;

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
    self.title = [[NSString alloc] initWithFormat:@"%@", [Util displayStringFromDate:[_levelHandler date]]];
    [self updateButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
    if (FALSE == [_levelHandler isRecorded]) {
        DLog(@"Not recorded yet");
        return;
    }
    [_levelHandler setScore:(int)[_slider value]];
    if (FALSE == [_levelHandler submit]) {
        CHECK_NOT_ENTER_HERE;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window makeKeyAndVisible];
    
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    if (FALSE == [_levelHandler setDown]) {
        CHECK_NOT_ENTER_HERE;
    };
}

- (IBAction)happinessChange:(UISlider *)sender {
    long int theValue = lroundf(sender.value);
    [_slider setValue:theValue animated:YES];
    ((UILabel*)[self.view viewWithTag:kHappinessLabelTag]).text = [[NSString alloc] initWithFormat:@"%li", theValue];
}

- (void) updateButton
{
    if (FALSE == [_levelHandler isRecorded]) {
        UIButton* button = ((UIButton*)[self.view viewWithTag:kRecordButtonTag]);
        [button setTitleColor:[Util userClickableButtonColor] forState:UIControlStateNormal];
        button = ((UIButton*)[self.view viewWithTag:kListenButtonTag]);
        [button setTitleColor:[Util userDisableButtonColor] forState:UIControlStateNormal];
        button = ((UIButton*)[self.view viewWithTag:kSubmitButtonTag]);
        [button setTitleColor:[Util userDisableButtonColor] forState:UIControlStateNormal];
    } else {
        UIButton* button = ((UIButton*)[self.view viewWithTag:kRecordButtonTag]);
        [button setTitleColor:[Util userClickableButtonColor] forState:UIControlStateNormal];
        button = ((UIButton*)[self.view viewWithTag:kListenButtonTag]);
        [button setTitleColor:[Util userClickableButtonColor] forState:UIControlStateNormal];
        button = ((UIButton*)[self.view viewWithTag:kSubmitButtonTag]);
        [button setTitleColor:[Util userClickableButtonColor] forState:UIControlStateNormal];
    }
}

#pragma mark - segue
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"toListen"]) {
        if (FALSE == [_levelHandler isRecorded]) {
            DLog(@"Not recorded yet");
            return FALSE;
        }
    }
    return TRUE;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toListen"]) {
        if (FALSE == [_levelHandler setAction:LISTEN_ACTION]) {
            CHECK_NOT_ENTER_HERE;
        };
        RecordActionVC* vc = segue.destinationViewController;
        if (FALSE == [_levelHandler setActionWakupDate: [vc levelHandler]]) {
            CHECK_NOT_ENTER_HERE;
        }
    } else if ([[segue identifier] isEqualToString:@"toRecord"]) {
        RecordActionVC* vc = segue.destinationViewController;
        if (FALSE == [_levelHandler setAction:RECORD_ACTION]) {
            CHECK_NOT_ENTER_HERE;
        }
        if (FALSE == [_levelHandler setActionWakupDate: [vc levelHandler]]) {
            CHECK_NOT_ENTER_HERE;
        }
    }
}

- (IBAction) unwindToRecordInfoVC:(UIStoryboardSegue *)unwindSegue
{
    if (TRUE == [unwindSegue.sourceViewController isKindOfClass:[RecordActionVC class]]) {
        RecordActionVC* sourceViewController = unwindSegue.sourceViewController;
        [sourceViewController manualStop];
    }
    [self updateButton];
}

@end