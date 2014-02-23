//
//  RecordLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordLevelHandler.h"
#import "DebugUtil.h"
#import <UIKit/UIKit.h>

@implementation RecordLevelHandler
#pragma mark RecordActionProtocol Implement
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

- (NSString*) getRecordingPath
{
    //call record file handler
    return @"aaaa";
}

- (BOOL) start
{
    /*
     * 1. Prepare all data.
     * 2. Register a event handler (callback function) for time up.
     * 3. goto next;
     *
     */
    
    // 3. goto next;
    [self setStoredNextState:RECORDING_VOICE_STATE];
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return NO;
    }

    return TRUE;
}

- (BOOL) stop
{
    //1. Call record handler to stop record
    //2. Maybe we can record the time into database?
    //3. Maybe we can upload the record file to ds?
    [self setStoredNextState:RECORD_TEXT_STATE];
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return NO;
    }
    

    return TRUE;
}

@end
