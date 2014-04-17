//
//  RecordPeriodSetupElement.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/13.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupElementProtocol.h"

@interface RecordPeriodSetupElement : NSObject <UIPickerViewDataSource, UIPickerViewDelegate, SetupElementProtocol>
@property (nonatomic, weak) UITextField* textField;

- (int) getRecordPeriod;

@end
