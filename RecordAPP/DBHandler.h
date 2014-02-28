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
//get inst
- (NSString*) convertToID: (RecordInfo*) info;

- (BOOL) push: (RecordInfo*) info;
- (RecordInfo*) get: (NSDate*) date;
- (NSArray*) selectAll;

@end