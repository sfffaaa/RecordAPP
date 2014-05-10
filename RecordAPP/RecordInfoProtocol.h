//
//  RecordInfoProtocol.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePeriod.h"

#define RECORD_SCORE_MAX 5

//For breaking circular debpendacy in import.
@protocol RecordInfoTableViewCellProtocol;

//composite design pattern
@protocol RecordInfoProtocol <NSObject>
- (void) setName:(NSString *)name;
- (NSString*) name;
- (void) setDate:(NSDate *)date;
- (NSDate*) date;
- (void) setDatePeriod:(DatePeriod*) datePeriod;
- (DatePeriod*) datePeriod;
- (void) setScore:(int)score;
- (int) score;
- (void) setLength:(float)length;
- (float) length;
- (id<RecordInfoTableViewCellProtocol>) tableViewCellImp;
- (void) setTableViewCellImp: (id<RecordInfoTableViewCellProtocol>) tableViewCellImp;

- (BOOL) isValid;
- (BOOL) remove;

//For composite
- (BOOL) pushRecordInfo: (id<RecordInfoProtocol>) recordInfo;
- (NSUInteger) getRecordInfoCount;
//If leaf, return 0
- (id<RecordInfoProtocol>) getRecordInfo:(int) index;
//If leaf, return nil
@end