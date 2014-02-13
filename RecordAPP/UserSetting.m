//
//  UserSetting.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "UserSetting.h"
#import "DebugUtil.h"
#import "WakeupSettingHandler.h"
#import "EmailSettingHandler.h"
#import "RecordSettingHandler.h"

#pragma mark - UserSetting
@implementation UserSetting
@synthesize eMail = _eMail;
@synthesize wakeupPeriod = _wakeupPeriod;
@synthesize nextWakeupDate = _nextWakeupDate;
@synthesize runwakeup = _runwakeup;
@synthesize recordPeriod = _recordPeriod;

- (id) init
{
    self = [super init];
    if (nil != self) {
        
        _eMail = [[NSString alloc] initWithFormat:@"sfffaaa..."];
        _wakeupPeriod = 10;
        _nextWakeupDate = [[NSDate alloc] initWithTimeIntervalSinceNow:_wakeupPeriod];
        _runwakeup = FALSE;
        
        _recordPeriod = 10;
    }
    return self;
}
@end