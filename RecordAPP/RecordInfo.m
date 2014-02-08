//
//  RecordInfo.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordInfo.h"
#import "DebugUtil.h"

#define DEBUG_RECORDINFO_NAME @"None"
#define DEBUG_RECORDINFO_PATH @"None"
#define DEBUG_RECORDINFO_BRIEF_EXPLAIN @"This is a good day"
#define DEBUG_RECORDINFO_SCORE 5

@implementation RecordInfo

@synthesize name = _name;
@synthesize recordPath = _recordPath;
@synthesize briefExplain = _briefExplain;
@synthesize score = _score;
@synthesize date = _date;
@synthesize isValid = _isValid;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _name = [[NSString alloc] initWithFormat:DEBUG_RECORDINFO_NAME];
        _recordPath = [[NSString alloc] initWithFormat:DEBUG_RECORDINFO_PATH];
        _briefExplain = [[NSString alloc] initWithFormat:DEBUG_RECORDINFO_BRIEF_EXPLAIN];
        _date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        _score = DEBUG_RECORDINFO_SCORE;
        _isValid = TRUE;
    }
    return self;
}

@end
