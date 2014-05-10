//
//  RecordInfo.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfoProtocol.h"
#import "RecordInfoTableViewCell.h"

#define RECORD_SCORE_MAX 5

@interface RecordInfo : NSObject <RecordInfoProtocol>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic) int score;
@property (nonatomic) float length;
@property (nonatomic, strong) DatePeriod* datePeriod;
@property (nonatomic, strong) id<RecordInfoTableViewCellProtocol> tableViewCellImp;
@end
