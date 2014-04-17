//
//  RunWakeupSetupElement.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/10.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupElementProtocol.h"

@interface RunWakeupSetupElement : NSObject <SetupElementProtocol>
@property (nonatomic, weak) UISwitch* switchView;

- (BOOL) getWakeupValue;
@end
