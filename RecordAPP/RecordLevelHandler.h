//
//  RecordLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessLogicHandler.h"
#import "RecordActionProtocol.h"
#import "BaseLevelHandler.h"

@interface RecordLevelHandler : BaseLevelHandler <RecordActionProtocol, BusinessLogicProtocol>

@end
