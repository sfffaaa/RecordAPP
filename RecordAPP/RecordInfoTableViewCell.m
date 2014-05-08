//
//  RecordInfoTableViewCell.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/4.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfoTableViewCell.h"
#import "RecordInfoProtocol.h"
#import "DebugUtil.h"
#import "Util.h"

#define kRecordTableViewDateTextTag 1
#define kRecordTableViewLengthTextTag 3
#define kRecordTableViewPictureTagOffset 100

#define VALID_RECORD_INFO_HEIGHT 115


@implementation RecordInfoTableViewCell

- (void)tableView:(UITableView *)tableView didSelectRowAtRecordInfo:(id<RecordInfoProtocol>) info VC: (UIViewController*) VC
{
    if (nil == info || nil == VC) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    if (IS_NOT_CLASS_NAME(@"RecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    //For only record info
    [VC performSegueWithIdentifier:@"toStatisticDetailVC" sender:info];
}

- (BOOL) loadScorePicture:(UITableViewCell*)cell info:(id<RecordInfoProtocol>)info
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    if (IS_NOT_CLASS_NAME(@"RecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }

    static NSString *CellIdentifier = @"RecordInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StatisticRecordInfo" owner:self options:nil] objectAtIndex:0];
    }
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[info date]], [Util displayStringFromDate:[info date]]];
    if (FALSE == [self loadScorePicture:cell info:info]) {
        CHECK_NOT_ENTER_HERE;
    }
    ((UILabel*)[cell viewWithTag:kRecordTableViewLengthTextTag]).text = [[NSString alloc]initWithFormat:@"%.1f sec", [info length]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    if (IS_NOT_CLASS_NAME(@"RecordInfo", [info class])) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return VALID_RECORD_INFO_HEIGHT;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtRecordInfo:(id<RecordInfoProtocol>) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (IS_NOT_CLASS_NAME(@"RecordInfo", [info class])) {
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
    if (IS_NOT_CLASS_NAME(@"RecordInfo", [info class])) {
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
