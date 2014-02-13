//
//  UserSetting.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSetting : NSObject
//email setting handler
@property (nonatomic, strong) NSString* eMail;
//wakeup setting handler
@property (nonatomic, strong) NSDate* nextWakeupDate;
@property (nonatomic) BOOL runwakeup;
//record setting handler
@property (nonatomic) int recordPeriod;
@property (nonatomic) int wakeupPeriod;
@end
