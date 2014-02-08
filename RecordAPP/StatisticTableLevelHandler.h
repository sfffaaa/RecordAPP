//
//  StatisticTableLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecordInfoFillProtocol <NSObject>
- (NSArray*) fillArray: (NSArray*) array;
@end

@interface RecordInfoWithVanishEntryBehavior : NSObject <RecordInfoFillProtocol>
@end

@interface RecordInfoWithoutVanishEntry : NSObject <RecordInfoFillProtocol>
@end


@interface StatisticTableLevelHandler : NSObject
- (NSInteger) getCount;
- (NSArray*) getInfoArray;
- (void) sortArray:(NSComparator)cmptr;
- (BOOL) setRecordFillBehavior:(id<RecordInfoFillProtocol>) behavior;
@end
