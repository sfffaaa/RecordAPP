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
    RECORD_VOICE_START_STATE,
    RECORDING_VOICE_STATE,
    RECORD_TEXT_STATE,
    RECORD_FINISH_STATE,
    LISTEN_VOICE_START_STATE,
    LISTENING_VOICE_STATE,
    STATISTIC_ROUGH_STATE,
    STATISTIC_DETAIL_STATE,
    RESTART_STATE,
    SETTING_STATE,
} STATE_TYPE;

@protocol BusinessLogicProtocol <NSObject>
- (int) getNextState:(STATE_TYPE*) nextState;
- (int) goTo:(STATE_TYPE)nextState levelHandler: (id<BusinessLogicProtocol>*) handler;
- (int) checkTo:(STATE_TYPE)nextState;
@end

//singleton
@interface BusinessLogicHandler : NSObject
@property (nonatomic) STATE_TYPE nowState;
@property (nonatomic) STATE_TYPE oldState;
@property (nonatomic, strong) id<BusinessLogicProtocol> handler;
+(BusinessLogicHandler*) getBusinessLogicHanlder;
+(STATE_TYPE) getNowStat;
+(STATE_TYPE) getOldStat;
-(int) goNext;

@end
