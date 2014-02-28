//
//  Util.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "Util.h"
#import "DebugUtil.h"

@implementation Util

+ (NSURL*) getFileURLFromInfo: (RecordInfo*) info
{
    if (nil == info && nil == [info date]) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return [Util getFileURLFromDate:[info date]];
}

+ (NSURL*) getFileURLFromDate: (NSDate*) date
{
    if (nil == date) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm"];
    NSString* file = [[NSString alloc] initWithFormat:@"%@.m4a", [dateFormatter stringFromDate:date]];
        
    NSArray *pathComponents = [NSArray arrayWithObjects:
                                [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],                                   file,
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    return outputFileURL;
}

@end
