//
//  RecordActionLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordActionProtocol.h"

@interface RecordActionLevelHandler : NSObject
@property (nonatomic, strong) id<RecordActionProtocol> action;
@property (nonatomic, weak) NSDate* wakeupTime;

+ (RecordActionLevelHandler*) getInst;
- (int) getPerpareTime;
- (float) getRecordTime;
- (BOOL) start;
- (BOOL) stop;

- (BOOL) prepareStart;
- (BOOL) prepareStop;

- (BOOL) isPrepare;

@end
