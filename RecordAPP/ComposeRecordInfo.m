//
//  ComposeRecordInfo.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ComposeRecordInfo.h"
#import "DebugUtil.h"
#import "ComposeRecordInfoTableViewCell.h"

@interface ComposeRecordInfo()
@property (nonatomic, strong) NSMutableArray* child;
@end

@implementation ComposeRecordInfo
@synthesize score = _score;
@synthesize date = _date;
@synthesize datePeriod = _datePeriod;
@synthesize name = _name;
@synthesize length = _length;
@synthesize child = _child;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _child = [[NSMutableArray alloc] init];
        _tableViewCellImp = [[ComposeRecordInfoTableViewCell alloc] init];
    }
    return self;
}

- (BOOL) isValid
{
    return TRUE;
}

- (void) setTableViewCellImp:(id<RecordInfoTableViewCellProtocol>)tableViewCellImp
{
    CHECK_NOT_ENTER_HERE;
}

#pragma mark (TODO) Remove all item;
- (BOOL) remove
{
    if (nil == _child) {
        return TRUE;
    }
    for (NSUInteger i = 0; i < [_child count]; i++) {
        if (FALSE == [(id<RecordInfoProtocol>)[_child objectAtIndex:i] remove]) {
            CHECK_NOT_ENTER_HERE;
            return FALSE;
        };
    }
    
    return TRUE;
}

- (BOOL) pushRecordInfo: (id<RecordInfoProtocol>) recordInfo
{
    if (nil == recordInfo) {
        return FALSE;
    }
    [_child addObject:recordInfo];
    return TRUE;
}

- (NSUInteger) getRecordInfoCount
{
    return [_child count];
}

- (id<RecordInfoProtocol>) getRecordInfo:(int) index
{
    if (index > [_child count]) {
        return nil;
    }
    return [_child objectAtIndex:index];
}

@end
