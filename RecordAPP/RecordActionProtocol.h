//
//  RecordActionProtocol.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _ACTION_PROTOCOL_
{
    ERROR_ACTION = -1,
    NO_ACTION,
    PREPARE_ACTION,
    RECORD_ACTION,
    LISTEN_ACTION
} RECORD_ACTION_TYPE;

@protocol RecordActionProtocol <NSObject>

- (RECORD_ACTION_TYPE) getActionType;

- (int) getTotalTime;
- (NSString*) getActionName;

- (BOOL) setFilePath: (NSURL*) fileURL;

- (BOOL) start;
- (BOOL) stop;
- (BOOL) prepare;

@end
