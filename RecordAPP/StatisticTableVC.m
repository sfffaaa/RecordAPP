//
//  StatisticTableVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/8.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticTableVC.h"
#import "StatisticTableLevelHandler.h"
#import "StatisticDetailVC.h"
#import "RecordInfoLevelHandler.h"
#import "RecordInfo.h"
#import "Util.h"
#import "DebugUtil.h"

#pragma mark (FEATURE) Need has filter for no record time

#define VALID_RECORD_INFO_HEIGHT 115
#define INVALID_RECORD_INFO_HEIGHT 20

#define kRecordTableViewDateTextTag 1
#define kRecordTableViewLengthTextTag 3
#define kRecordTableViewPictureTagOffset 100

@interface StatisticTableVC ()
@property (nonatomic, strong) StatisticTableLevelHandler* levelHandler;
@end

@implementation StatisticTableVC
@synthesize levelHandler = _levelHandler;
@synthesize tableView = _tableView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _levelHandler = [StatisticTableLevelHandler getInst];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:RELOAD_EVENT object:nil];
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

- (void) viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadTable:(NSNotification*) notification
{
    if (FALSE == [[self levelHandler] reloadInfoArray]) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark (TODO) Implement didSelectRowAtIndexPath

    RecordInfo* info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"toStatisticDetailVC" sender:info];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [[self levelHandler] sortArray:nil];
    return [[self levelHandler] getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecordInfo";
    UITableViewCell *cell = NULL;
    RecordInfo* info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StatisticRecordInfo" owner:self options:nil] objectAtIndex:0];
    }
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[info date]], [Util displayStringFromDate:[info date]]];
    if (FALSE == [self loadScorePicture:cell info:info]) {
        CHECK_NOT_ENTER_HERE;
    }
    DLog(@"test %f", [info length]);
    ((UILabel*)[cell viewWithTag:kRecordTableViewLengthTextTag]).text = [[NSString alloc]initWithFormat:@"%.1f sec", [info length]];

    return cell;
}

- (BOOL) loadScorePicture:(UITableViewCell*)cell info:(RecordInfo*)info
{
    if (nil == cell || nil == info) {
        CHECK_NOT_ENTER_HERE;
    }
    int score = [info score];
    for (int i = 0; i < RECORD_SCORE_MAX; i++) {
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:i + kRecordTableViewPictureTagOffset];
        imageView.hidden = YES;
    }
    for (int i = 0; i < score; i++) {
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:i + kRecordTableViewPictureTagOffset];
        imageView.hidden = NO;
    }
    return true;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    RecordInfo* info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    if (TRUE == [info isValid]) {
        height = VALID_RECORD_INFO_HEIGHT;
    } else {
        height = INVALID_RECORD_INFO_HEIGHT;
    }
    return height;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RecordInfo* info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
        if (FALSE == [[self levelHandler] removeInfo: info]) {
            CHECK_NOT_ENTER_HERE;
        }
    }
}

- (IBAction)filter:(id)sender
{
#pragma mark (TODO) Implement filter
    DLog(@"filter");
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toStatisticDetailVC"]) {
        StatisticDetailVC *vc = [segue destinationViewController];
        [vc setInfo:(RecordInfo*)sender];
    }
}

@end
