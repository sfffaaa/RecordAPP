//
//  ComposeStatisticTableVCViewController.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ComposeStatisticTableVCViewController.h"
#import "RecordInfoLevelHandler.h"
#import "RecordInfoTableViewCellProtocol.h"
#import "StatisticDetailVC.h"
#import "DebugUtil.h"

@interface ComposeStatisticTableVCViewController ()
@end

@implementation ComposeStatisticTableVCViewController
@synthesize levelHandler = _levelHandler;
@synthesize tableView = _tableView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _levelHandler = [[ComposeStatisticTableLevelHandler alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:RELOAD_EVENT object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfo:(id<RecordInfoProtocol>)info
{
    [[self levelHandler] setInfo:info];
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
        [[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_EVENT object:self];
    }
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toStatisticDetailVC"]) {
        StatisticDetailVC *vc = [segue destinationViewController];
        [vc setInfo:(id<RecordInfoProtocol>)sender];
    }
}

@end
