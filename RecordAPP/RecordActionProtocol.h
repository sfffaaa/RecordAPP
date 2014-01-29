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
    UNKNOW_ACTION = -1,
    RECORD_ACTION,
    LISTEN_ACTION
} RECORD_ACTION_TYPE;

@protocol RecordActionProtocol <NSObject>

- (RECORD_ACTION_TYPE) getActionType;

- (int) getTotalTime;
- (int) getRemainTime;
- (BOOL) setFilePath: (NSString*) filePath;
- (NSString*) getFilePath;

- (BOOL) start;
- (BOOL) stop;

@end
