//
//  AudioFileHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/3/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AudioFileHandler.h"
#import "Util.h"
#import "DebugUtil.h"


@implementation AudioFileHandler

+ (NSURL*) getFileURLFromInfo: (RecordInfo*) info
{
    if (nil == info && nil == [info date]) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return [AudioFileHandler getFileURLFromDate:[info date]];
}

+ (NSURL*) getFileURLFromDate: (NSDate*) date
{
    if (nil == date) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSString* dateStr = [Util stringFromDate:date];
    if (nil == dateStr) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    NSString* file = [[NSString alloc] initWithFormat:@"%@.m4a", dateStr];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],                                   file,
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    return outputFileURL;
}

+ (float) getAudioLengthFromInfo: (RecordInfo*) info
{
    if (nil == info && nil == [info date]) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return [AudioFileHandler getAudioLengthFromDate:[info date]];
}

+ (float) getAudioLengthFromDate: (NSDate*) date
{
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[AudioFileHandler getFileURLFromDate:date] options:nil];
    CMTime audioDuration = audioAsset.duration;
    return CMTimeGetSeconds(audioDuration);
}


+ (BOOL) removeAudioFile: (RecordInfo*) info
{
    if (nil == info) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    NSURL* fileURL = [AudioFileHandler getFileURLFromInfo:info];
    if (nil == fileURL) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //Check file exist or not
    if (NO == [fileManager fileExistsAtPath:[fileURL path]]) {
        return TRUE;
    }
    
    NSError* err = nil;
    if (NO == [fileManager removeItemAtPath:[fileURL path] error:&err]) {
        DLog(@"Error: cannot remove file [%@]: [%@]", [fileURL path], [err localizedDescription]);
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    
    return TRUE;
}

@end
