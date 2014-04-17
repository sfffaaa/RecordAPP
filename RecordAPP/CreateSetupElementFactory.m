//
//  CreateSetupElementFactory.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/5.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "CreateSetupElementFactory.h"
#import "WakeupPeriodSetupElement.h"
#import "RunWakeupSetupElement.h"
#import "RecordPeriodSetupElement.h"
#import "NextWakeupTimeSetupElement.h"
#import "EMailSetupElement.h"
#import "DebugUtil.h"

@implementation CreateSetupElementFactory
- (id<SetupElementProtocol>) createSetupElement: (NSString*) classStr
{
    if (nil == classStr) {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
    if (TRUE == [classStr isEqualToString:NSStringFromClass([WakeupPeriodSetupElement class])]) {
        return [[WakeupPeriodSetupElement alloc] init];
    } else if (TRUE == [classStr isEqualToString:NSStringFromClass([RunWakeupSetupElement class])]) {
        return [[RunWakeupSetupElement alloc] init];
    } else if (TRUE == [classStr isEqualToString:NSStringFromClass([RecordPeriodSetupElement class])]) {
        return [[RecordPeriodSetupElement alloc] init];
    } else if (TRUE == [classStr isEqualToString:NSStringFromClass([NextWakeupTimeSetupElement class])]) {
        return [[NextWakeupTimeSetupElement alloc] init];
    } else if (TRUE == [classStr isEqualToString:NSStringFromClass([EMailSetupElement class])]) {
        return [[EMailSetupElement alloc] init];
    } else {
        CHECK_NOT_ENTER_HERE;
        return nil;
    }
}
@end
