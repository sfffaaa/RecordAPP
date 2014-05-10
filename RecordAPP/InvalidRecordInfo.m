//
//  InvalidRecordInfo.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "InvalidRecordInfo.h"
#import "InvaildRecordInfoTableViewCell.h"
#import "DebugUtil.h"

@implementation InvalidRecordInfo

@synthesize score = _score;
@synthesize date = _date;
@synthesize datePeriod = _datePeriod;
@synthesize name = _name;
@synthesize length = _length;
@synthesize tableViewCellImp = _tableViewCellImp;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _date = [[NSDate date] dateByAddingTimeInterval:0];
        _tableViewCellImp = [[InvaildRecordInfoTableViewCell alloc] init];
    }
    return self;
}

- (void) setTableViewCellImp:(id<RecordInfoTableViewCellProtocol>)tableViewCellImp
{
    CHECK_NOT_ENTER_HERE;
}

- (BOOL) isValid
{
    return FALSE;
}

- (BOOL) remove
{
    return TRUE;
}

//For composite
- (BOOL) pushRecordInfo: (id<RecordInfoProtocol>) recordInfo
{
    return FALSE;
}
- (NSUInteger) getRecordInfoCount
{
    return 0;
}

//If leaf, return 0
- (id<RecordInfoProtocol>) getRecordInfo:(int) index
{
    return self;
}

@end


