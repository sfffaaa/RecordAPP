//
//  BusinessLogicHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DebugUtil.h"
#import "BusinessLogicHandler.h"
#import "BaseLevelHandler.h"
#import "InitializatorLevelHandler.h"

@implementation BusinessLogicHandler

@synthesize nowState = _nowState;
@synthesize oldState = _oldState;
@synthesize handler = _handler;

- (id) init
{
    self = [super init];
    if (nil != self) {
        _oldState = INIT_STATE;
        _nowState = INIT_STATE;
        _handler = Nil;
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

+(STATE_TYPE) getOldStat
{
    BusinessLogicHandler* handler = [BusinessLogicHandler getBusinessLogicHanlder];
    CHECK_NIL(handler);
    return [handler oldState];
}

// -1: error occurs
//  0: success
// >0: callback depend
-(int) goNext
{
    int ret = -1;
    STATE_TYPE nextState;
    id nower = [self handler];
    id<BusinessLogicProtocol> nexter;

    if (FALSE == [nower conformsToProtocol:@protocol(BusinessLogicProtocol)]) {
        DLog(@"input class doens't has BusinessLogicGoNexter protocol");
        goto END;
    }
    if (0 > [nower getNextState:&nextState]) {
        DLog(@"nexter(%@) getNextState error", NSStringFromClass([nower class]));
        goto END;
    }
    if (0 > [nower checkTo:nextState]) {
        DLog(@"nexter(%@) doesn't pass", NSStringFromClass([nower class]));
        goto END;
    }
#pragma mark (TODO) need to check nower is kind of BaseLevelHandler
    if (nil == [nower nowVC]) {
        DLog(@"There is no nowVC");
        goto END;
    }
    if (0 != [nower goTo:nextState levelHandler:&nexter]) {
        DLog(@"nexter(%@) failed", NSStringFromClass([nower class]));
        goto END;
    }
    [self setHandler:nexter];
    [self setOldState:[self nowState]];
    [self setNowState:nextState];
    
    ret = 0;
END:
    return ret;
}

@end
