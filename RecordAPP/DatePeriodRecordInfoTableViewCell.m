//
//  DatePeriodRecordInfoTableViewCell.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/11.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DatePeriodRecordInfoTableViewCell.h"
#import "RecordInfoProtocol.h"
#import "DebugUtil.h"
#import "Util.h"

#define kRecordTableViewDateTextTag 1
#define kRecordTableViewLengthTextTag 3
#define kRecordTableViewStartDateTextTag 4
#define kRecordTableViewEndDateTextTag 5
#define kRecordTableViewPictureTagOffset 100

#define VALID_RECORD_INFO_HEIGHT 182

@implementation DatePeriodRecordInfoTableViewCell

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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StatisticDateRecordInfo" owner:self options:nil] objectAtIndex:0];
    }
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[info date]], [Util displayStringFromDate:[info date]]];
    
    DatePeriod* datePeriod = [info datePeriod];
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewStartDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[datePeriod startDate]], [Util displayStringFromDate:[datePeriod startDate]]];
    
    ((UILabel*)[cell viewWithTag:kRecordTableViewEndDateTextTag]).text = [[NSString alloc]initWithFormat:@"%@ %@", [Util displayWeekStringFromDate:[datePeriod endDate]], [Util displayStringFromDate:[datePeriod endDate]]];    
    
    if (FALSE == [self loadScorePicture:cell info:info]) {
        CHECK_NOT_ENTER_HERE;
    }
    ((UILabel*)[cell viewWithTag:kRecordTableViewLengthTextTag]).text = [[NSString alloc]initWithFormat:SECOND_FORMAT, [info length]];
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

@end
