//
//  RecordInfo.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfo.h"
#import "AudioFileHandler.h"
#import "DBHandler.h"
#import "DebugUtil.h"

#define DEBUG_RECORDINFO_NAME @"None"
#define DEBUG_RECORDINFO_PATH @"None"
#define DEBUG_RECORDINFO_BRIEF_EXPLAIN @"This is a good day"
#define DEBUG_RECORDINFO_SCORE 5

@implementation RecordInfo
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
        _score = DEBUG_RECORDINFO_SCORE;
        _tableViewCellImp = [[RecordInfoTableViewCell alloc] init];
    }
    return self;
}

- (BOOL) isValid
{
    return TRUE;
}

- (BOOL) remove
{
    if (FALSE == [self isValid]) {
        return TRUE;
    }
    
    //  Remove file
    if (FALSE == [AudioFileHandler removeAudioFile:self]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    
    //  Remove db
    DBHandler* dbHandler = [DBHandler getInst];
    if (nil == dbHandler) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (FALSE == [dbHandler remove:self]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    
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
