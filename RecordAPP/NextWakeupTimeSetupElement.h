//
//  NextWakeupTimeSetupElement.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupElementProtocol.h"

@interface NextWakeupTimeSetupElement : NSObject < SetupElementProtocol>
@property (nonatomic, weak) UITextField* textField;

- (NSDate*) getNextWakeupTime;
@end