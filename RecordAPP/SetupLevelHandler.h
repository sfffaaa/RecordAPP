//
//  SetupLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WakeupPeriodSetupElement.h"
#import "RunWakeupSetupElement.h"
#import "RecordPeriodSetupElement.h"
#import "NextWakeupTimeSetupElement.h"

@interface SetupLevelHandler : NSObject
@property (nonatomic, strong) id<SetupElementProtocol> wakeupPeriodElement;
@property (nonatomic, strong) id<SetupElementProtocol> runWakeupElement;
@property (nonatomic, strong) id<SetupElementProtocol> recordPeriodElement;
@property (nonatomic, strong) id<SetupElementProtocol> nextWakeupPeriodElement;
@property (nonatomic, strong) id<SetupElementProtocol> emailElement;

- (BOOL) initAllInputView;
- (BOOL) setupDefaultUserSetting;
@end
