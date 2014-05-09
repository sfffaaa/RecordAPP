//
//  SetupVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/12.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "SetupVC.h"
#import "SetupLevelHandler.h"
#import "DebugUtil.h"
#import "RecordInfoLevelHandler.h"
#import "Util.h"
#import "EventDefine.h"

@interface SetupVC ()
@property (weak, nonatomic) IBOutlet UITextField *recordLengthTextField;
@property (weak, nonatomic) IBOutlet UISwitch *runWakeUpSwitch;
@property (weak, nonatomic) IBOutlet UITextField *wakeUpNextTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *wakeUpPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) SetupLevelHandler* levelHandler;
@end

@implementation SetupVC
@synthesize levelHandler = _levelHandler;
@synthesize recordLengthTextField = _recordLengthTextField;
@synthesize runWakeUpSwitch = _runWakeUpSwitch;
@synthesize wakeUpNextTimeTextField = _wakeUpNextTimeTextField;
@synthesize wakeUpPeriodTextField = _wakeUpPeriodTextField;
@synthesize emailTextField = _emailTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _levelHandler = [[SetupLevelHandler alloc] init];
        [[self levelHandler] setupDefaultUserSetting];
    }
    return self;
}

-(void)viewWillLayoutSubviews
{
    if (FALSE == [Util seperateViewStatusBar:self.view]) {
        CHECK_NOT_ENTER_HERE;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self levelHandler] recordPeriodElement] setInputDelegate:_recordLengthTextField];
    [[[self levelHandler] runWakeupElement] setInputDelegate:_runWakeUpSwitch];
    [[[self levelHandler] nextWakeupPeriodElement] setInputDelegate:_wakeUpNextTimeTextField];
    [[[self levelHandler] wakeupPeriodElement] setInputDelegate:_wakeUpPeriodTextField];
    [[[self levelHandler] emailElement] setInputDelegate:_emailTextField];
    
    if (FALSE == [[self levelHandler] initAllInputView]) {
        CHECK_NOT_ENTER_HERE;
    };
    if (FALSE == [[self levelHandler] reloadSetupElement]) {
        CHECK_NOT_ENTER_HERE;
    }

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSetupElement:) name:TABLE_RELOAD_EVENT object:nil];
}

- (void) viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) reloadSetupElement:(NSNotification*) notification
{
    if (FALSE == [[self levelHandler] reloadSetupElement]) {
        CHECK_NOT_ENTER_HERE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    if (FALSE == [[self levelHandler] dismissAllInputView]) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
}
- (IBAction)editDidBegin:(id)sender
{
    if (FALSE == [[self levelHandler] editBeginElement:sender]) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
}

- (IBAction)switchWakeup:(id)sender
{
    if (2 == [sender tag]) {
        [[[self levelHandler] runWakeupElement] setElementValue:[NSNumber numberWithBool:[(UISwitch*)sender isOn]]];
    }
}
@end
