//
//  RecordLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordLevelHandler.h"
#import "DebugUtil.h"

//Include recording and decide where to store.
@implementation RecordLevelHandler

- (RECORD_ACTION_TYPE) getActionType
{
    return RECORD_ACTION;
}

- (int) getTotalTime
{
    return 1000;
}
- (int) getRemainTime
{
    return 10;
}
- (BOOL) setFilePath: (NSString*) filePath
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}
- (NSString*) getFilePath
{
    CHECK_NOT_ENTER_HERE;
    return nil;
}

- (BOOL) start
{
    CHECK_NOT_ENTER_HERE;
    //1. Register a event handler (callback function)
    return FALSE;
}
- (BOOL) stop
{
    //1. Call record handler to stop record
    //2. Maybe we can record the time into database?
    //3. Maybe we can upload the record file to ds?
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}

- (NSString*) getRecordingPath
{
    //call record file handler
    return @"aaaa";
}

@end
