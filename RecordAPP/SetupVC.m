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
#pragma mark (TODO) singleton?
        _levelHandler = [[SetupLevelHandler alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _recordLengthTextField.text = [[NSString alloc] initWithFormat:@"%i", [[self levelHandler] getRecordPeiod]];
    
    [_runWakeUpSwitch setOn:[[self levelHandler] getRunWakeup]];
    
    _wakeUpNextTimeTextField.text = [[NSString alloc] initWithFormat:@"%@", [[self levelHandler] getNextWakeupTime]];
    
    _wakeUpPeriodTextField.text = [[NSString alloc] initWithFormat:@"%i", [[self levelHandler] getWakeupPeriod]];
    
    _emailTextField.text = [[NSString alloc] initWithFormat:@"%@", [[self levelHandler] getEMail]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Text delegate
#pragma mark (TODO) picker view + focus
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CHECK_NOT_ENTER_HERE;
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

#pragma mark (TODO) Remove keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (IBAction)switchWakeup:(id)sender {
    if (2 == [sender tag]) {
        [[self levelHandler] setRunWakeup:[(UISwitch*)sender isOn]];
    }
}

@end
