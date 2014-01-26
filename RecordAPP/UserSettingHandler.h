//
//  UserSettingHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessLogicHandler.h"

@interface UserSetting : NSObject
//email setting handler
@property (nonatomic, strong) NSString* eMail;
//wakeup setting handler
@property (nonatomic, strong) NSDate* nextWakeupDate;
@property (nonatomic, strong) NSDate* periodDate;
@property (nonatomic) BOOL runwakeup;
//record setting handler
@property (nonatomic) int recordPeriod;

@end

@interface UserSettingHandler : NSObject <BusinessLogicGoNexter, BusinessLogicChecker>
@property (nonatomic, strong) UserSetting* userSetting;
@end
