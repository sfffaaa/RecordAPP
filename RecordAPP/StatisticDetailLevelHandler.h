//
//  StatisticDetailLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionLevelToVCProtocol.h"
#import "RecordInfoProtocol.h"

@interface StatisticDetailLevelHandler : NSObject <ActionLevelToVCProtocol>
@property (nonatomic, strong) id<RecordInfoProtocol> info;

+ (StatisticDetailLevelHandler*) getInst;

@end
