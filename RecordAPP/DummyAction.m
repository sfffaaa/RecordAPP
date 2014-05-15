//
//  DummyAction.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/3/6.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DummyAction.h"
#import <AVFoundation/AVFoundation.h>
#import "DebugUtil.h"

#define PREPARE_TIME 3

@implementation DummyAction

- (BOOL) setFilePath: (NSURL*) fileURL
{
    return TRUE;
}

- (float) getTotalTime
{
    return PREPARE_TIME;
}

- (NSString*) getActionName
{
    return [[NSString alloc] initWithFormat:@"Prepare"];
}

- (RECORD_ACTION_TYPE) getActionType
{
    return PREPARE_ACTION;
}

- (BOOL) prepare
{
    return TRUE;
}

- (BOOL) start
{
    return TRUE;
}

- (BOOL) stop
{
    return TRUE;
}
@end
