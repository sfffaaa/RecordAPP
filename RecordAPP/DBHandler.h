//
//  DBHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "RecordInfo.h"

@interface DBHandler : NSObject
+ (DBHandler*) getInst;

- (NSString*) convertToID: (id<RecordInfoProtocol>) info;

- (BOOL) push: (id<RecordInfoProtocol>) info;
- (id<RecordInfoProtocol>) get: (NSDate*) date;
- (NSArray*) selectAll;
- (BOOL) remove: (id<RecordInfoProtocol>) info;

@end