//
//  ComposeRecordInfo.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecordInfoProtocol.h"

@interface ComposeRecordInfo : NSObject <RecordInfoProtocol>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic) int score;
@property (nonatomic) float length;
@property (nonatomic, strong) id<RecordInfoTableViewCellProtocol> tableViewCellImp;
@end
