//
//  StatisticTableLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticTableLevelHandler.h"
#import "RecordInfoLevelHandler.h"
#import "DBHandler.h"
#import "AudioFileHandler.h"
#import "DebugUtil.h"
#import "RecordInfo.h"
#import "Util.h"
#import "NextWakeupTimeSetupElement.h"
#import "WakeupPeriodSetupElement.h"
#import "InvalidRecordInfo.h"
#import "ComposeRecordInfo.h"

@implementation RecordInfoWithVanishEntryBehavior
- (NSDate*) getInitialDate: (NSArray*) array
{
    if (nil == array || 0 == [array count]) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    id<RecordInfoProtocol> firstIdx = [array objectAtIndex:0];
    id<RecordInfoProtocol> lastIdx = [array objectAtIndex:[array count] - 1];
    return [[firstIdx date] earlierDate:[lastIdx date]];
}

- (NSDate*) getMaxDate
{
    NextWakeupTimeSetupElement* nextWakeupTimeSetupElement = [[NextWakeupTimeSetupElement alloc] init];
    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    int wakeupPeriod = [wakeupPeriodSetupElement getWakeupPeriod];
    NSDate* maxDate = [nextWakeupTimeSetupElement getNextWakeupTime];
    
    while (IS_DATE_EQUAL_OR_LATER([NSDate date], maxDate)) {
        maxDate = [maxDate dateByAddingTimeInterval:wakeupPeriod];
    }
    while (IS_DATE_EQUAL_OR_LATER(maxDate, [NSDate date])) {
        maxDate = [maxDate dateByAddingTimeInterval:-1 * wakeupPeriod];
    }
    return maxDate;
}

- (NSArray*) fillArray: (NSArray*) array
{
#pragma mark (TODO) Implement fillArray protocol (RecordInfoWithVanishEntryBehavior)
    if (nil == array || 0 == [array count]) {
        DLog(@"No data");
        return nil;
    }
    
    NSMutableArray* processArray = [[NSMutableArray alloc] init];
    
    WakeupPeriodSetupElement* wakeupPeriodSetupElement = [[WakeupPeriodSetupElement alloc] init];
    int wakeupPeriod = [wakeupPeriodSetupElement getWakeupPeriod];
    NSDate* recordInitialDate = [self getInitialDate:array];

    //先算最後一個的時間
    NSUInteger arrIdx = 0;
    NSDate* date = nil;
    
    //算第一個時間
    NSDate* initialDate = nil;
    while (IS_DATE_EARLIER(recordInitialDate, initialDate)) {
        initialDate = [initialDate dateByAddingTimeInterval:-1 * wakeupPeriod];
    }
    
    //時間的 loop 往回走（當 array 的 loop 走完，或是走到最早的時間 就停)
    for (date = [[self getMaxDate] dateByAddingTimeInterval:-1 * wakeupPeriod] ; IS_DATE_EQUAL_OR_EARLIER(initialDate, date); date = [date dateByAddingTimeInterval:-1 * wakeupPeriod]) {
        NSUInteger tmpIdx = arrIdx;
        //走 array 的 loop
        while (arrIdx < [array count] &&
               IS_DATE_EQUAL_OR_LATER([(id<RecordInfoProtocol>)[array objectAtIndex:arrIdx] date], date)) {
            arrIdx++;
        }
        id<RecordInfoProtocol> element = nil;
        if (tmpIdx == arrIdx) {
            InvalidRecordInfo* invalidRecordInfo = [[InvalidRecordInfo alloc] init];
            [invalidRecordInfo setDate:date];
            element = invalidRecordInfo;
        } else if (1 != arrIdx - tmpIdx) {
            ComposeRecordInfo* composeRecordInfo =
            [[ComposeRecordInfo alloc] init];
            [composeRecordInfo setDate:date];
            for (; tmpIdx < arrIdx; tmpIdx++) {
                if (FALSE == [composeRecordInfo pushRecordInfo:(id<RecordInfoProtocol>)[array objectAtIndex:tmpIdx]]) {
                    CHECK_NOT_ENTER_HERE;
                }
            }
            element = composeRecordInfo;
        } else {
            element = [array objectAtIndex:tmpIdx];
        }
        [processArray addObject:element];
        
        if (arrIdx == [array count]) {
            break;
        }
    }

    return processArray;
}
@end

@implementation RecordInfoWithoutVanishEntryBehavior
- (NSArray*) fillArray:(NSArray *)array
{
    return array;
}
@end


@interface StatisticTableLevelHandler()
@property (nonatomic, strong) id<RecordInfoFillProtocol> fillBehavior;
@property (nonatomic, strong) NSArray* infoArray;
@end

@implementation StatisticTableLevelHandler
@synthesize fillBehavior = _fillBehavior;
@synthesize infoArray =_infoArray;

+ (StatisticTableLevelHandler*) getInst
{
    static StatisticTableLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[StatisticTableLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        [self setFillBehavior:[[RecordInfoWithoutVanishEntryBehavior alloc] init]];

    }
    return self;
}

- (void) setFillBehavior:(id<RecordInfoFillProtocol>)fillBehavior
{
    if (nil == fillBehavior) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
    _fillBehavior = fillBehavior;
    if (FALSE == [self reloadInfoArray]) {
        CHECK_NOT_ENTER_HERE;
        return;
    }
}

- (BOOL) setRecordFillBehavior:(id<RecordInfoFillProtocol>)behavior
{
    [self setFillBehavior:behavior];
    return TRUE;
}

- (BOOL) reloadInfoArray
{
    NSArray* rawInfos = nil;
    DBHandler* dbHandler = [DBHandler getInst];
    if (nil == (rawInfos = [dbHandler selectAll])) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (nil == [self fillBehavior]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    _infoArray = [[self fillBehavior] fillArray:rawInfos];
    
    return TRUE;
}

- (NSInteger) getCount
{
    if (nil == _infoArray) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return [_infoArray count];
}
//if cmptr == nil; date latest is first
- (NSArray*)getInfoArray
{
    if (nil == _infoArray) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return _infoArray;
}

@end
