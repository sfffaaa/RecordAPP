//
//  StatisticDetailLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionLevelToVCProtocol.h"
#import "RecordInfo.h"

@interface StatisticDetailLevelHandler : NSObject <ActionLevelToVCProtocol>
@property (nonatomic, strong) RecordInfo* info;

+ (StatisticDetailLevelHandler*) getInst;

@end
