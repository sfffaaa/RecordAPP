//
//  StatisticTableLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfoProtocol.h"

@protocol RecordInfoFillProtocol <NSObject>
- (NSArray*) fillArray: (NSArray*) array;
@end

@interface RecordInfoWithVanishEntryBehavior : NSObject <RecordInfoFillProtocol>
@end

@interface RecordInfoWithoutVanishEntryBehavior : NSObject <RecordInfoFillProtocol>
@end


@interface StatisticTableLevelHandler : NSObject
+ (StatisticTableLevelHandler*) getInst;
- (BOOL) reloadInfoArray;
- (NSInteger) getCount;
- (NSArray*) getInfoArray;
- (BOOL) setRecordFillBehavior:(id<RecordInfoFillProtocol>) behavior;
@end
