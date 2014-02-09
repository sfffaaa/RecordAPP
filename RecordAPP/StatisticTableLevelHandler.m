//
//  StatisticTableLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticTableLevelHandler.h"
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
@end

@implementation StatisticTableLevelHandler
@synthesize fillBehavior = _fillBehavior;

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

- (BOOL) setRecordFillBehavior:(id<RecordInfoFillProtocol>)behavior
{
    [self setRecordFillBehavior:behavior];
    return TRUE;
}

- (NSInteger) getCount
{
#pragma mark (TODO) Implement getCount
    return 1;
}
//if cmptr == nil; date latest is first
- (NSArray*)getInfoArray
{
#pragma mark (TODO) Implement getInfoArray
    NSArray* infos = [[NSArray alloc] initWithObjects:[[RecordInfo alloc] init], nil];
    return infos;
    
    NSArray* rawInfos = nil;
    if (nil == [self fillBehavior]) {
        CHECK_NOT_ENTER_HERE;
    }
    return [[self fillBehavior] fillArray:rawInfos];
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
