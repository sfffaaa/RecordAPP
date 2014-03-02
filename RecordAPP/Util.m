//
//  Util.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "Util.h"
#import "DebugUtil.h"

#define DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define DISPLAY_DATE_FORMAT @"EEEE yyyy-MM-dd HH:mm:ss"

@implementation Util

+ (NSDate*) dateFromString: (NSString*) dateString
{
    if (nil == dateString) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    if (nil == destDate) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return destDate;
}

+ (NSString*) stringFromDate: (NSDate*) date
{
    if (nil == date) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    if (nil == destDateString) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return destDateString;
}

+ (NSString*) displayStringFromDate: (NSDate*) date
{
    if (nil == date) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DISPLAY_DATE_FORMAT];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    if (nil == destDateString) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return destDateString;
}


@end
