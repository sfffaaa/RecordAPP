//
//  ComposeRecordInfoTableViewCell.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/7.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ComposeRecordInfoTableViewCell.h"
#import "RecordInfoProtocol.h"
#import "DebugUtil.h"
#import "Util.h"

#define kRecordTableViewStartDateTextTag 1
#define kRecordTableViewEndDateTextTag 2
#define kRecordTableViewDataCountTextTag 3

#define COMPOSE_RECORD_INFO_HEIGHT 130

@implementation ComposeRecordInfoTableViewCell

- (void)tableView:(UITableView *)tableView didSelectRowAtRecordInfo:(id<RecordInfoProtocol>) info VC: (UIViewController*) VC
{
    if (nil == info || nil == VC) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    if (IS_NOT_CLASS_NAME(@"ComposeRecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    //For only record info
    [VC performSegueWithIdentifier:@"toComposeStatisticDetailVC" sender:info];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    if (IS_NOT_CLASS_NAME(@"ComposeRecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    
    static NSString *CellIdentifier = @"ComposeRecordInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StatisticComposeRecordInfo" owner:self options:nil] objectAtIndex:0];
    }
    DatePeriod* datePeriod = [info datePeriod];
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewStartDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[datePeriod startDate]], [Util displayStringFromDate:[datePeriod startDate]]];
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewEndDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[datePeriod endDate]], [Util displayStringFromDate:[datePeriod endDate]]];

    ((UILabel*)[cell viewWithTag:kRecordTableViewDataCountTextTag]).text = [[NSString alloc]initWithFormat:@"%lu data(s)", (unsigned long)[info getRecordInfoCount]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    if (IS_NOT_CLASS_NAME(@"ComposeRecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return COMPOSE_RECORD_INFO_HEIGHT;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (IS_NOT_CLASS_NAME(@"ComposeRecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    if (IS_NOT_CLASS_NAME(@"ComposeRecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (FALSE == [info remove]) {
            CHECK_NOT_ENTER_HERE;
        }
    }
}

@end
