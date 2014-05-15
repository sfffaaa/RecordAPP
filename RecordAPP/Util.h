//
//  Util.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_DATE_EQUAL_OR_EARLIER(a, b) \
        (NSOrderedAscending == [(a) compare: (b)] || \
         NSOrderedSame == [(a) compare: (b)])

#define IS_DATE_EARLIER(a, b) \
        (NSOrderedAscending == [(a) compare: (b)])

#define IS_DATE_EQUAL_OR_LATER(a, b) \
        (NSOrderedDescending == [(a) compare: (b)] || \
         NSOrderedSame == [(a) compare: (b)])

#define IS_NOT_CLASS_NAME(a, b) \
        (FALSE == [(a) isEqualToString: NSStringFromClass((b))])

#define SECOND_FORMAT @"%.1f sec"

@interface Util : NSObject
+ (NSDate*) dateFromString: (NSString*) dateString;
+ (NSString*) stringFromDate: (NSDate*) date;
+ (NSString*) displayStringFromDate: (NSDate*) date;
+ (NSString*) displayWeekStringFromDate:(NSDate *)date;

+ (UIColor*) userClickableButtonColor;
+ (UIColor*) userDisableButtonColor;
+ (BOOL) seperateViewStatusBar: (UIView*) view;
@end
