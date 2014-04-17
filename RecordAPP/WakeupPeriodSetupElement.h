//
//  WakeupPeriodSetupElement.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/5.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupElementProtocol.h"

@interface WakeupPeriodSetupElement : NSObject <UIPickerViewDataSource, UIPickerViewDelegate, SetupElementProtocol>
@property (nonatomic, weak) UITextField* textField;

- (int) getWakeupPeriod;
@end
