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
#define DISPLAY_DATE_FORMAT @"yyyy-MM-dd HH:mm"
#define DISPLAY_WEEK_FORMAT @"EEE"


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

+ (NSString*) displayWeekStringFromDate:(NSDate *)date
{
    if (nil == date) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DISPLAY_WEEK_FORMAT];
    NSString *destWeekString = [dateFormatter stringFromDate:date];
    if (nil == destWeekString) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return destWeekString;

}

+ (UIColor*) userClickableButtonColor
{
    return [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0];
}

+ (UIColor*) userDisableButtonColor
{
    return [UIColor grayColor];
}

+ (BOOL) seperateViewStatusBar: (UIView*) view
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        view.clipsToBounds = YES;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        view.frame =  CGRectMake(0, 20, view.frame.size.width,screenHeight - 20);
        view.bounds = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    return TRUE;
}

@end
