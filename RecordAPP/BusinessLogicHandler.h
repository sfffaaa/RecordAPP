//
//  BusinessLogicHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _STATE {
    INIT_STATE = 0,
    RECORD_VOICE_STATE,
    RECORD_TEXT_STATE,
    RECORD_FINISH_STATE,
    STATISTIC_ROUGH_STATE,
    STATISTIC_DETAIL_STATE,
    RESTART_STATE,
    SETTING_STATE,
} STATE_TYPE;

@protocol BusinessLogicGoNexter <NSObject>
- (int) goFrom:(STATE_TYPE) nowState to:(STATE_TYPE)nextState;
@end

@protocol BusinessLogicChecker <NSObject>
- (int) checkFrom:(STATE_TYPE) nowState to:(STATE_TYPE)nextState;
@end

//singleton
@interface BusinessLogicHandler : NSObject
@property (nonatomic) STATE_TYPE nowState;
@property (nonatomic) STATE_TYPE oldState;
+(BusinessLogicHandler*) getBusinessLogicHanlder;
-(int) goNextState:(STATE_TYPE) nextState nexter:(id) nexter checker:(id) checker;
@end
