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
@property (nonatomic, strong) SetupLevelHandler* levelHandler;
@end

@implementation SetupVC
@synthesize levelHandler = _levelHandler;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


@end
