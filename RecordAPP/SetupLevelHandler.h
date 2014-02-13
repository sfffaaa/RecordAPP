//
//  SetupLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSetting.h"

@interface SetupLevelHandler : NSObject
@property (nonatomic, strong) UserSetting* userSetting;
- (NSString*) getEMail;
- (void) setEMail: (NSString*) eMail;

- (int) getWakeupPeriod;
- (void) setWakeupPeriod: (int) date;

- (int) getRecordPeiod;
- (void) setRecordPeriod: (int) second;

- (BOOL) getRunWakeup;
- (void) setRunWakeup: (BOOL) flag;

@end
