//
//  RecordSettingHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordSettingHandler.h"
#import "DebugUtil.h"

@implementation RecordSettingHandler
@synthesize recordTime = _recordTime;

- (id) init
{
#pragma mark (TODO) below should be the singleton
    self = [super init];
    if (nil != self) {
#pragma mark (TODO) now for debug
        _recordTime = DEBUG_RECORD_RECORDTIME;
    }
    return self;
}
@end
