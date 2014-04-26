//
//  RecordInfo.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RECORD_SCORE_MAX 5

@interface RecordInfo : NSObject
@property (nonatomic) BOOL isValid;
@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) NSString* recordPath;
//@property (nonatomic, strong) NSString* briefExplain;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic) int score;
@property (nonatomic) float length;

@end
