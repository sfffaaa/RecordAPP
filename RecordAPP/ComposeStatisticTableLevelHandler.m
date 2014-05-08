//
//  ComposeStatisticTableLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ComposeStatisticTableLevelHandler.h"
#import "DebugUtil.h"

@interface ComposeStatisticTableLevelHandler()
@property (nonatomic, strong) NSMutableArray* recordInfos;
@end

@implementation ComposeStatisticTableLevelHandler
@synthesize recordInfos = _recordInfos;

+ (ComposeStatisticTableLevelHandler*) getInst
{
    static ComposeStatisticTableLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[ComposeStatisticTableLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        _recordInfos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL) setInfo:(id<RecordInfoProtocol>)recordInfo
{
    if (nil == recordInfo) {
        CHECK_NOT_ENTER_HERE
        return FALSE;
    }
    if (0 == [recordInfo getRecordInfoCount]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    _recordInfos = [[NSMutableArray alloc] init];
    for (int i = 0; i < [recordInfo getRecordInfoCount]; ++i) {
        [_recordInfos addObject:[recordInfo getRecordInfo:i]];
    }
    return TRUE;
}

- (BOOL) reloadInfoArray
{
    return TRUE;
}

- (NSInteger) getCount
{
    if (nil == _recordInfos) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return [_recordInfos count];
}

//if cmptr == nil; date latest is first
- (NSArray*)getInfoArray
{
    if (nil == _recordInfos) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return _recordInfos;
}
@end
