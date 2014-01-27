//
//  RecordInfoLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfoLevelHandler.h"
#import "DebugUtil.h"
#import "RecordInfo.h"

@interface RecordInfoLevelHandler()

@property (nonatomic, strong) RecordInfo* recordInfo;
@end

@implementation RecordInfoLevelHandler
@synthesize recordInfo = _recordInfo;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _recordInfo = [[RecordInfo alloc] init];
    }
    return self;
}

- (BOOL) setRecordInfoName
{
    CHECK_NOT_ENTER_HERE;
    return FALSE;
}

- (BOOL) submit
{
    CHECK_NOT_ENTER_HERE
    return FALSE;
}

- (BOOL) listen
{
    //goto listen page
    CHECK_NOT_ENTER_HERE
    return FALSE;
}

- (BOOL) recordAgain
{
    //goto record page
    CHECK_NOT_ENTER_HERE
    return FALSE;
}

@end
