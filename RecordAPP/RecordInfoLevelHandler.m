//
//  RecordInfoLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfoLevelHandler.h"
#import "RecordActionLevelHandler.h"
#import "RecordingAction.h"
#import "ListeningAction.h"
#import "WakeupHandler.h"
#import "DebugUtil.h"
#import "RecordInfo.h"

@interface RecordInfoLevelHandler()
@end

@implementation RecordInfoLevelHandler
@synthesize date = _date;
@synthesize timerHandler = _timerHandler;

+ (RecordInfoLevelHandler*) getInst
{
    static RecordInfoLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[RecordInfoLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        _date = nil;
        _timerHandler = [[TimerHandler alloc] init];
    }
    return self;
}

- (BOOL) setUp
{
    _date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[[WakeupHandler getInst] nowWakeupDate]];
    
    [[WakeupHandler getInst] setSetuped:TRUE];
    return TRUE;
}

- (BOOL) setDown
{
    [[WakeupHandler getInst] setSetuped:FALSE];
    return TRUE;
}

- (BOOL) setAction:(RECORD_ACTION_TYPE)actionType
{
    RecordActionLevelHandler* handler = [RecordActionLevelHandler getInst];
    if (LISTEN_ACTION == actionType) {
        [handler setAction:[[ListeningAction alloc] init]];
    } else if (RECORD_ACTION == actionType) {
        [handler setAction:[[RecordingAction alloc] init]];
    }
    return TRUE;
}

- (BOOL) setActionWakupDate
{
    RecordActionLevelHandler* handler = [RecordActionLevelHandler getInst];
    [handler setFileURL:[self getFileURL]];
    
    return TRUE;
}

- (BOOL) submit
{
    //stat whether the file is exist or not
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:[[self getFileURL] path]]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    //Add information to db
    
    return TRUE;
}

- (NSURL*) getFileURL
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm"];
    NSString* file = [[NSString alloc] initWithFormat:@"%@.m4a", [dateFormatter stringFromDate:_date]];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               file,
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    return outputFileURL;
}


@end
