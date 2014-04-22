//
//  StatisticTableLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfo.h"

@protocol RecordInfoFillProtocol <NSObject>
- (NSArray*) fillArray: (NSArray*) array;
@end

@interface RecordInfoWithVanishEntryBehavior : NSObject <RecordInfoFillProtocol>
@end

@interface RecordInfoWithoutVanishEntry : NSObject <RecordInfoFillProtocol>
@end


@interface StatisticTableLevelHandler : NSObject
+ (StatisticTableLevelHandler*) getInst;
- (BOOL) reloadInfoArray;
- (NSInteger) getCount;
- (NSArray*) getInfoArray;
- (BOOL) removeInfo: (RecordInfo*) info;
- (void) sortArray:(NSComparator)cmptr;
- (BOOL) setRecordFillBehavior:(id<RecordInfoFillProtocol>) behavior;
@end
