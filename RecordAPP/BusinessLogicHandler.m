//
//  BusinessLogicHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DebugUtil.h"
#import "BusinessLogicHandler.h"

@implementation BusinessLogicHandler

@synthesize nowState = _nowState;
@synthesize oldState = _oldState;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _oldState = INIT_STATE;
        _nowState = INIT_STATE;
    }
    return self;
}


#pragma mark - should change page when recording!
+(BusinessLogicHandler*) getBusinessLogicHanlder
{
    static BusinessLogicHandler* inst = nil;
    static dispatch_once_t onceToken = 0;
    if (nil == inst) {
        dispatch_once(&onceToken, ^{
            inst = [[BusinessLogicHandler alloc] init];
        });
    }
    return inst;
}

+(STATE_TYPE) getNowStat
{
    BusinessLogicHandler* handler = [BusinessLogicHandler getBusinessLogicHanlder];
    CHECK_NIL(handler);
    return [handler nowState];
}

// -1: error occurs
//  0: success
// >0: callback depend
-(int) goNextState:(STATE_TYPE) nextState nexter:(id) nexter checker:(id) checker
{
    int ret = -1;
    if (FALSE == [nexter conformsToProtocol:@protocol(BusinessLogicProtocol)]) {
        DLog(@"input class doens't has BusinessLogicGoNexter protocol");
        goto END;
    }
    if (FALSE == [checker conformsToProtocol:@protocol(BusinessLogicProtocol)]) {
        DLog(@"input class doens't has BusinessLogicGoNexter protocol");
        goto END;
    }
    
    if (0 > [checker checkFrom:[self nowState] to:nextState]) {
        DLog(@"checker(%@) doesn't pass", NSStringFromClass([checker class]));
        goto END;
    }
    if (0 > (ret = [nexter goFrom:[self nowState] to:nextState])) {
        DLog(@"nexter(%@) failed", NSStringFromClass([nexter class]));
        goto END;
    }
    [self setOldState:[self nowState]];
    [self setNowState:nextState];
    
    ret = 0;
END:
    return ret;
}

@end
