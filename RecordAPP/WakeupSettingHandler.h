//
//  WakeupSettingHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WakeupSettingHandler : NSObject
@property (nonatomic, copy) NSDate* periodDate;
@property (nonatomic, copy) NSDate* nextWakeupDate;
@property (nonatomic) BOOL runWakeUp;
@end
