//
//  Util.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/28.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfo.h"

@interface Util : NSObject
+ (NSDate*) dateFromString: (NSString*) dateString;
+ (NSString*) stringFromDate: (NSDate*) date;
+ (NSString*) displayStringFromDate: (NSDate*) date;
@end
