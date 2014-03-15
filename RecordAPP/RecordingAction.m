//
//  RecordingAction.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordingAction.h"
#import <AVFoundation/AVFoundation.h>
#import "UserSetting.h"
#import "DebugUtil.h"

@interface RecordingAction()
@property (nonatomic, weak) NSURL* urlFilePath;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@end

@implementation RecordingAction
@synthesize urlFilePath = _urlFilePath;
- (BOOL) setFilePath: (NSURL*) fileURL
{
    if (nil == fileURL) {
        CHECK_NOT_ENTER_HERE;
    }
    _urlFilePath = fileURL;
    return TRUE;
}

- (RECORD_ACTION_TYPE) getActionType;
{
    return RECORD_ACTION;
}

- (int) getTotalTime
{
    UserSetting* userSetting = [[UserSetting alloc] init];
    return [userSetting recordPeriod];
}

- (NSString*) getActionName
{
    return [[NSString alloc] initWithFormat:@"Record"];
}

- (BOOL) prepare
{
    if (nil == _urlFilePath) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    _recorder = [[AVAudioRecorder alloc] initWithURL:_urlFilePath settings:recordSetting error:NULL];
    if (nil == _recorder) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    
    return TRUE;
}

- (BOOL) start
{
    if (TRUE == _recorder.recording) {
        CHECK_NOT_ENTER_HERE;
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (nil == session) {
        CHECK_NOT_ENTER_HERE;
    }
    [session setActive:YES error:nil];
        
    // Start recording
    [_recorder record];

    return TRUE;
}

- (BOOL) stop
{
    if (FALSE == _recorder.recording) {
        CHECK_NOT_ENTER_HERE;
    }
    [_recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if (nil == audioSession) {
        CHECK_NOT_ENTER_HERE;
    }
    [audioSession setActive:NO error:nil];
    return TRUE;
}
@end
