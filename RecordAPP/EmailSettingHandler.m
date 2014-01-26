//
//  EmailSettingHandler.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "EmailSettingHandler.h"
#import "DebugUtil.h"

@implementation EmailSettingHandler
@synthesize eMail = _eMail;

- (id) init
{
#pragma mark (TODO) below should be the singleton
    self = [super init];
    if (nil != self) {
#pragma mark (TODO) now for debug
        _eMail = [[NSString alloc] initWithFormat:DEBUG_EMAIL_EMAIL];
    }
    return self;
}
@end
