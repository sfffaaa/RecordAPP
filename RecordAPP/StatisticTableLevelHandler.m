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

@implementation RecordInfoWithVanishEntryBehavior
- (NSArray*) fillArray: (NSArray*) array
{
#pragma mark (TODO) Implement fillArray protocol (RecordInfoWithVanishEntryBehavior)
    return nil;
}
@end

@implementation RecordInfoWithoutVanishEntry
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
        [self setFillBehavior:[[RecordInfoWithoutVanishEntry alloc] init]];
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
    [self setRecordFillBehavior:behavior];
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

- (BOOL) removeInfo: (RecordInfo*) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (FALSE == [info isValid]) {
        return TRUE;
    }
    
//  Remove file
    if (FALSE == [AudioFileHandler removeAudioFile:info]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    
//  Remove db
    DBHandler* dbHandler = [DBHandler getInst];
    if (nil == dbHandler) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (FALSE == [dbHandler remove:info]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_EVENT object:self];
    
    return TRUE;
}

- (void)sortArray:(NSComparator)cmptr
{
#pragma mark (TODO) Implement sortArray
    NSArray* array = nil;
    if (nil == cmptr) {
        cmptr = ^NSComparisonResult(id obj1, id obj2) {
            RecordInfo* record1 = obj1;
            RecordInfo* record2 = obj2;
            return [[record2 date] compare:[record1 date]];
        };
    }
    if (nil != array) {
        array = [array sortedArrayUsingComparator:cmptr];
    }
}

@end
