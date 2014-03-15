//
//  RecordActionLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#pragma mark (TODO) Extract a new protocol and let RecordActionLevelHandler and StatisticDetailLevelHandler follow

#import <Foundation/Foundation.h>
#import "RecordActionProtocol.h"
#import "ActionLevelToVCProtocol.h"

@interface RecordActionLevelHandler : NSObject <ActionLevelToVCProtocol>
#pragma mark (TODO) Change the action to array.
@property (nonatomic, strong) id<RecordActionProtocol> action;
@property (nonatomic, strong) id<RecordActionProtocol> prepareAction;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSURL* fileURL;

+ (RecordActionLevelHandler*) getInst;
- (NSString*) getPrepareName;
- (NSString*) getActionName;

@end
