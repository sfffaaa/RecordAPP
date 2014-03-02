//
//  AudioFileHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/3/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfo.h"

@interface AudioFileHandler : NSObject
+ (float) getAudioLengthFromInfo: (RecordInfo*) info;
+ (float) getAudioLengthFromDate: (NSDate*) date;
+ (BOOL) removeAudioFile: (RecordInfo*) info;
+ (NSURL*) getFileURLFromInfo: (RecordInfo*) info;
+ (NSURL*) getFileURLFromDate: (NSDate*) date;
@end
