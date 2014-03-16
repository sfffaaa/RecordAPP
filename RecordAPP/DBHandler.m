//
//  DBHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DBHandler.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "RecordInfo.h"
#import "Util.h"
#import "DebugUtil.h"

#define DB_NAME @"dbtest.db"
#define RECORD_TABLE @"Rtable"
#define RECORD_ID @"id"
#define RECORD_DATE @"date"
#define RECORD_LENGTH @"length"
#define RECORD_SCORE @"score"

#define COLUME_ALL @"*"

@interface DBHandler()
@property (nonatomic, strong) FMDatabase* db;
@end

@implementation DBHandler
@synthesize db = _db;

+ (DBHandler*) getInst
{
    static DBHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[DBHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    
    if (nil != self) {
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [docsPath stringByAppendingPathComponent:DB_NAME];
        
        _db = [FMDatabase databaseWithPath:dbPath];
        if (FALSE == [_db open]) {
            CHECK_NOT_ENTER_HERE;
        }
        [_db setShouldCacheStatements:YES];
        if (FALSE == [_db tableExists:RECORD_TABLE]) {
            NSString* sqlCmd = [[NSString alloc] initWithFormat:@"CREATE TABLE %@ (%@ text, %@ text, %@ integer, %@ float)", RECORD_TABLE, RECORD_ID, RECORD_DATE, RECORD_SCORE, RECORD_LENGTH];
            [_db executeUpdate:sqlCmd];
        }
    }
    return self;
}

- (NSString*) convertToID: (RecordInfo*) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
    }
    return [Util stringFromDate:[info date]];
}

//return false: no entry
//        true: has entry
-(BOOL) isRecordExist: (RecordInfo*) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return TRUE;
    }
    NSString* cmd = [[NSString alloc] initWithFormat:@"select count(%@) from %@ where %@ = \'%@\' limit 1", RECORD_DATE, RECORD_TABLE, RECORD_ID, [self convertToID:info]];

    if (0 == [_db intForQuery:cmd]) {
        return FALSE;
    } else {
        return TRUE;
    }
}

- (BOOL) push: (RecordInfo*) info
{
    BOOL ret = FALSE;
    NSString* dbID = nil, *sqlCmd = nil;
    
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    if (TRUE == [self isRecordExist:info]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    dbID = [[NSString alloc] initWithFormat:@"%@", [self convertToID:info]];
    sqlCmd = [[NSString alloc] initWithFormat:@"insert into %@ (%@, %@, %@, %@) values (\'%@\', \'%@\', \'%f\', \'%i\');", RECORD_TABLE, RECORD_ID, RECORD_DATE, RECORD_LENGTH, RECORD_SCORE, dbID, [Util stringFromDate:[info date]], [info length], [info score]];

    if (FALSE == [_db beginTransaction]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [_db executeUpdate:sqlCmd]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [_db commit]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    ret = TRUE;
END:
    return ret;
}

- (BOOL) remove: (RecordInfo*) info
{
    BOOL ret = FALSE;
    NSString* dbID = nil, *sqlCmd = nil;
    
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    dbID = [self convertToID:info];
    sqlCmd = [[NSString alloc] initWithFormat:@"delete from %@ where %@ = \'%@\'", RECORD_TABLE, RECORD_ID, dbID];
    
    if (FALSE == [_db beginTransaction]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [_db executeUpdate:sqlCmd]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [_db commit]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    ret = TRUE;
    
END:
    return ret;
}

- (RecordInfo*) extractFromDB: (FMResultSet*) rs
{
    RecordInfo* ret = nil, *info = nil;
    
    if (nil == rs) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    if (nil == (info = [[RecordInfo alloc] init])) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    [info setDate:[Util dateFromString:[rs stringForColumn:RECORD_DATE]]];
    [info setLength:[[rs objectForColumnName:RECORD_LENGTH] floatValue]];
    [info setScore:[[rs objectForColumnName:RECORD_SCORE] intValue]];
    [info setIsValid:TRUE];
    
    ret = info;
END:
    return ret;
}

- (RecordInfo*) get: (NSDate*) date
{
    RecordInfo* ret = nil, *info = nil;
    NSString* sqlCmd = nil;
    FMResultSet* rs = nil;
    
    if (nil == date) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    sqlCmd = [[NSString alloc] initWithFormat:@"select %@ from %@ where %@ = \'%@\' limit 1;", COLUME_ALL, RECORD_TABLE, RECORD_DATE, date];

    if (nil == (rs = [_db executeQuery:sqlCmd])) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    if (FALSE == [rs next]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    if (nil == (info = [self extractFromDB:rs])) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    ret = info;
END:
    return ret;
}

- (NSArray*) selectAll
{
    NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
    NSString* sqlCmd = [[NSString alloc] initWithFormat:@"select %@ from %@ order by %@ DESC;", COLUME_ALL, RECORD_TABLE, RECORD_DATE];
    FMResultSet* rs = [_db executeQuery:sqlCmd];
    RecordInfo* info = nil;
    while ([rs next]) {
        if (nil == (info = [self extractFromDB: rs])) {
            continue;
        }
        [tmpArray insertObject:info atIndex:[tmpArray count]];
    }
    return tmpArray;
}

@end
