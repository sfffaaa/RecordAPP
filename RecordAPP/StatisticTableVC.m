//
//  StatisticTableVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/8.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticTableVC.h"
#import "StatisticDetailVC.h"
#import "ComposeStatisticTableVCViewController.h"
#import "RecordInfoLevelHandler.h"
#import "RecordInfoProtocol.h"
#import "RecordInfoTableViewCell.h"
#import "Util.h"
#import "DebugUtil.h"
#import "EventDefine.h"

@interface StatisticTableVC ()
@property (nonatomic) BOOL fillPressed;
@end

@implementation StatisticTableVC
@synthesize levelHandler = _levelHandler;
@synthesize tableView = _tableView;
@synthesize fillPressed = _fillPressed;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _levelHandler = [[StatisticTableLevelHandler alloc] init];
        _fillPressed = true;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:TABLE_RELOAD_EVENT object:nil];
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
    [_tableView setEditing:NO];
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

    id<RecordInfoProtocol> info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    [[info tableViewCellImp] tableView:tableView didSelectRowAtRecordInfo:info VC:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self levelHandler] getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<RecordInfoProtocol> info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    return [[info tableViewCellImp] tableView:tableView cellForRowAtRecordInfo:info];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<RecordInfoProtocol> info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    return [[info tableViewCellImp] tableView:tableView heightForRowAtRecordInfo:info];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    id<RecordInfoProtocol> info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
    return [[info tableViewCellImp] tableView:tableView canEditRowAtRecordInfo:info];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id<RecordInfoProtocol> info = [[[self levelHandler] getInfoArray] objectAtIndex:[indexPath row]];
        [[info tableViewCellImp] tableView:tableView commitEditingStyle:editingStyle forRowAtRecordInfo:info];
        [[NSNotificationCenter defaultCenter] postNotificationName: TABLE_RELOAD_EVENT object:self];
    }
}

- (BOOL) setupNonFillerBarItem: (UIBarButtonItem*) item
{
    if (nil == item) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (FALSE == [[self levelHandler] setRecordFillBehavior:[[RecordInfoWithoutVanishEntryBehavior alloc] init]]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    item.title = [[NSString alloc] initWithFormat:@"Fill"];
    return TRUE;
}

- (BOOL) setupFillerBarItem: (UIBarButtonItem*) item
{
    if (nil == item) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (FALSE == [[self levelHandler] setRecordFillBehavior:[[RecordInfoWithVanishEntryBehavior alloc] init]]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    item.title = [[NSString alloc] initWithFormat:@"NoFill"];
    return TRUE;
}

- (IBAction)filter:(id)sender
{
    UIBarButtonItem* barItem = (UIBarButtonItem*)sender;
    if (FALSE == _fillPressed) {
        if (FALSE == [self setupFillerBarItem:barItem]) {
            CHECK_NOT_ENTER_HERE;
        }
    } else {
        if (FALSE == [self setupNonFillerBarItem:barItem]) {
            CHECK_NOT_ENTER_HERE;
        }
    }
    _fillPressed = !_fillPressed;
    [[NSNotificationCenter defaultCenter] postNotificationName: TABLE_RELOAD_EVENT object:self];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toStatisticDetailVC"]) {
        StatisticDetailVC *vc = [segue destinationViewController];
        [vc setInfo:(id<RecordInfoProtocol>)sender];
    } else if ([[segue identifier] isEqualToString:@"toComposeStatisticDetailVC"]) {
        ComposeStatisticTableVCViewController* vc = [segue destinationViewController];
        [vc setInfo:(id<RecordInfoProtocol>)sender];
    }
}

@end
