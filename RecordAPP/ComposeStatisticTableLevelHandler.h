//
//  ComposeStatisticTableLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfoProtocol.h"

@interface ComposeStatisticTableLevelHandler : NSObject

+ (ComposeStatisticTableLevelHandler*) getInst;
- (BOOL) reloadInfoArray;
- (NSInteger) getCount;
- (NSArray*) getInfoArray;
- (BOOL) setInfo:(id<RecordInfoProtocol>) recordInfo;
- (BOOL) remove: (NSInteger) index;

@end
