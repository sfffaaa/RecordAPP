//
//  DebugUtil.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#ifndef RecordAPP_DebugUtil_h
#define RecordAPP_DebugUtil_h

#define DEBUG_WAKEUP_PERIOD_DATE 1000000
#define DEBUG_WAKEUP_NEXT_WAKEUP_DATE 1000001
#define DEBUG_WAKEUP_RUN_WAKE TRUE

#define DEBUG_EMAIL_EMAIL @"sfffaaa@gmail.com"

#define DEBUG_RECORD_RECORDTIME 60

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#   define DLogWrongParam DLog(@"Wrong parameter");

#   define CHECK_NIL(name) \
if (nil == (name)) \
{   \
DLog(@"Why this is nil"); \
assert(0);\
}

# define CHECK_VALUE(value, name) \
if ((value) == (name)) \
{ \
DLog(@"two value is different"); \
assert(0); \
}

# define CHECK_TRUE(value) \
if ((value) != TRUE) \
{ \
DLog(@"Not true"); \
assert(0); \
}

# define CHECK_STRING_NOT_EMPTY(name) \
if (FALSE == [(NSString*)(name) isEqualToString:@""]) \
{ \
DLog(@"should not e empty"); \
assert(0); \
}

#define CHECK_NOT_ENTER_HERE \
{ \
DLog(@"should not enter here"); \
assert(0); \
}


#endif
