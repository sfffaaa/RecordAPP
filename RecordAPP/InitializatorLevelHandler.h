//
//  InitializatorLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/29.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevelHandler.h"
#import "BusinessLogicHandler.h"

#define INITIAL_EVENT @"InitialEvent"

@interface InitializatorLevelHandler : NSObject
- (BOOL) setStatus;
- (BOOL) wakeup;

@end
