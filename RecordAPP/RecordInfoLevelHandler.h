//
//  RecordInfoLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordActionProtocol.h"
#import "TimerHandler.h"

@interface RecordInfoLevelHandler : NSObject
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) TimerHandler* timerHandler;

+ (RecordInfoLevelHandler*) getInst;

- (BOOL) setAction:(RECORD_ACTION_TYPE) actionType;
- (BOOL) setActionWakupDate;
- (BOOL) setUp;
- (BOOL) setDown;
- (BOOL) submit;

@end
