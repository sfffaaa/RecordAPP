//
//  RecordInfoHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/3.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfoHandler.h"
#import "DebugUtil.h"

@implementation RecordInfoHandler
@synthesize recordInfo = _recordInfo;

- (id) init
{
    self = [super init];
    if (nil != self) {
        [self setRecordInfo:[[RecordInfo alloc] init]];
    }
    return self;
}

+(RecordInfoHandler*) getRecordInfoHandler
{
    static RecordInfoHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[RecordInfoHandler alloc] init];
        });
    }
    return inst;
}

@end
