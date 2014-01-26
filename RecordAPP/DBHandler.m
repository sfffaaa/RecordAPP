//
//  DBHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DBHandler.h"
#import "RecordInfo.h"
#import "DebugUtil.h"

@implementation DBHandler

- (BOOL) submit:(RecordInfo*) info
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}

// Return -1: failed
// Return >0: success and the array size;
- (int) getAllRecordInfo: (NSMutableArray**) array
{
#pragma mark (TODO) maybe we need sorter here
    CHECK_NOT_ENTER_HERE;
    return -1;
}

@end
