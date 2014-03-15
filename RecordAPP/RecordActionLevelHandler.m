//
//  RecordActionLevelHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordActionLevelHandler.h"
#import "TimerHandler.h"
#import "UserSetting.h"
#import "AudioFileHandler.h"
#import "DummyAction.h"
#import "DebugUtil.h"

#define PREPARE_TIME 3

@interface RecordActionLevelHandler()
@property (nonatomic, strong) TimerHandler* timerHandler;
@property (nonatomic) RECORD_ACTION_TYPE status;
@end

@implementation RecordActionLevelHandler
@synthesize action = _action;
@synthesize timerHandler = _timerHandler;
@synthesize status = _status;
@synthesize date = _date;

- (void) setDate:(NSDate *)date
{
    _date = date;
    NSURL* fileURL = [AudioFileHandler getFileURLFromDate:date];
    if (FALSE == [_action setFilePath: fileURL]) {
        CHECK_NOT_ENTER_HERE;
    }
    if (FALSE == [_prepareAction setFilePath: fileURL]) {
        CHECK_NOT_ENTER_HERE;
    }
}

+ (RecordActionLevelHandler*) getInst
{
    static RecordActionLevelHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    //[TODO] -> Change to the new handler
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[RecordActionLevelHandler alloc] init];
        });
    }
    return inst;
}

- (id) init
{
    self = [super init];
    if (nil != self) {
        _action = nil;
        _timerHandler = [[TimerHandler alloc] init];
        _prepareAction = [[DummyAction alloc] init];
        _status = NO_ACTION;
    }
    return self;
}

- (int) getPerpareTime
{
    if (nil == _prepareAction) {
        CHECK_NOT_ENTER_HERE
        return 0;
    }
    return [_prepareAction getTotalTime];
}

- (NSString*) getPrepareName
{
    if (nil == _prepareAction) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    return [_prepareAction getActionName];
}

- (float) getActionTime
{
    if (nil == _action) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return [_action getTotalTime];
}

- (NSString*) getActionName
{
    if (nil == _action) {
        CHECK_NOT_ENTER_HERE;
        return 0;
    }
    return [_action getActionName];
}

- (BOOL) actionStart: (id<RecordActionProtocol>) specificAction
{
    BOOL ret = FALSE;
    RECORD_ACTION_TYPE actionStatus = ERROR_ACTION;
    if (nil == specificAction) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (NO_ACTION != _status) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [specificAction prepare]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    //Timer start
    if (FALSE == [_timerHandler timeToStart:[specificAction getTotalTime]]) {
        DLog(@"Cannot start the timer");
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    
    //action start;
    if (FALSE == [specificAction start]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    actionStatus = [specificAction getActionType];
    ret = TRUE;
    
END:
    _status = actionStatus;
    return ret;
}

- (BOOL) actionStop: (id<RecordActionProtocol>) specificAction
{
    BOOL ret = FALSE;
    
    if (NO_ACTION == _status) {
        ret = TRUE;
        goto END;
    }
    if (nil == specificAction) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if ([specificAction getActionType] != _status) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [specificAction stop]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    ret = TRUE;
    
END:
    if (TRUE == ret) {
        _status = NO_ACTION;
    } else {
        _status = ERROR_ACTION;
    }

    return ret;
}

- (BOOL) actionMaunalStop: (id<RecordActionProtocol>) specificAction
{
    BOOL ret = FALSE;
    if (nil == specificAction) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if ([specificAction getActionType] != _status) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [_timerHandler stop: FALSE]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    if (FALSE == [specificAction stop]) {
        CHECK_NOT_ENTER_HERE;
        goto END;
    }
    ret = TRUE;
    
END:
    if (TRUE == ret) {
        _status = NO_ACTION;
    } else {
        _status = ERROR_ACTION;
    }
    
    return ret;
}

- (BOOL) start
{
    if (FALSE == [self actionStart:_action]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) stop
{
    if (FALSE == [self actionStop:_action]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) prepareStart
{
    if (FALSE == [self actionStart:_prepareAction]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

- (BOOL) prepareStop
{
    if (FALSE == [self actionStop:_prepareAction]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    return TRUE;
}

#pragma mark (TODO) Should connect to storyboard "stop".
- (BOOL) manualStop
{
    if (FALSE == [_timerHandler stop: FALSE]) {
        CHECK_NOT_ENTER_HERE;
        return FALSE;
    }
    if (ERROR_ACTION == _status) {
        DLog(@"Error action doesn't need stop");
    } else if (NO_ACTION == _status) {
        // do nothing
    } else if (PREPARE_ACTION == _status) {
        if (FALSE == [self actionMaunalStop:_prepareAction]) {
            CHECK_NOT_ENTER_HERE;
            return FALSE;
        }
    } else {
        if (FALSE == [self actionMaunalStop:_action]) {
            CHECK_NOT_ENTER_HERE;
            return FALSE;
        }
    }
    return TRUE;
}

- (BOOL) isPrepare
{
    return _status == PREPARE_ACTION;
}
@end
