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
#import "RecordInfo.h"
#import "DebugUtil.h"

#pragma mark (FEATURE) Need has filter for no record time

#define VALID_RECORD_INFO_HEIGHT 106
#define INVALID_RECORD_INFO_HEIGHT 20

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
    // Configure the cell...
#pragma mark (TODO) Connect tableviewcell with record info
    return cell;
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
