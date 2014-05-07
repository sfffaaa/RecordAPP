//
//  AudioFileHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/3/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfoProtocol.h"

@interface AudioFileHandler : NSObject
+ (float) getAudioLengthFromInfo: (id<RecordInfoProtocol>) info;
+ (float) getAudioLengthFromDate: (NSDate*) date;
+ (float) getAudioLengthFromURL: (NSURL*) dateURL;

+ (BOOL) removeAudioFile: (id<RecordInfoProtocol>) info;
+ (NSURL*) getFileURLFromInfo: (id<RecordInfoProtocol>) info;
+ (NSURL*) getFileURLFromDate: (NSDate*) date;
@end
