//
//  RecordInfoHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/3.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfo.h"

@interface RecordInfoHandler : NSObject
@property (nonatomic, strong) RecordInfo* recordInfo;

+(RecordInfoHandler*) getRecordInfoHandler;
@end
