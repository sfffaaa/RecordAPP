//
//  RecordLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordLevelHandler.h"

//Include recording and decide where to store.
@implementation RecordLevelHandler

- (NSString*) getRecordingPath
{
    //call record file handler
    return @"aaaa";
}

- (BOOL) startRecording:(NSString*) filePath
{
    //Call record handler to start record
    return FALSE;
}

- (BOOL) stopRecording
{
    //1. Call record handler to stop record
    //2. Maybe we can record the time into database?
    //3. Maybe we can upload the record file to ds?
    return FALSE;
}

- (int) getRemainRecordTime
{
    return 0;
}

@end
