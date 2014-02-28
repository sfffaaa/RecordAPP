//
//  ListeningAction.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ListeningAction.h"
#import <AVFoundation/AVFoundation.h>
#import "DebugUtil.h"

@interface ListeningAction()
@property (nonatomic, weak) NSURL* urlFilePath;
@property (nonatomic, strong) AVAudioPlayer *player;
@end


@implementation ListeningAction
@synthesize urlFilePath = _urlFilePath;
@synthesize player = _player;

- (BOOL) setFilePath: (NSURL*) fileURL
{
    if (nil == fileURL) {
        CHECK_NOT_ENTER_HERE;
    }
    _urlFilePath = fileURL;
    return TRUE;
}

- (BOOL) prepare
{
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_urlFilePath error:nil];
    if (nil == _player) {
        CHECK_NOT_ENTER_HERE;
    }
    return TRUE;
}

- (BOOL) start
{
    // Start recording
    [_player play];
    
    return TRUE;
}

- (BOOL) stop
{
    [_player stop];
    return TRUE;
}

@end
