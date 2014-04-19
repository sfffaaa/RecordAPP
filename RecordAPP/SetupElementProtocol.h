//
//  SetupElementProtocol.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/5.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_SETUP_KEY_INDEX 0
#define DEFAULT_SETUP_VALUE_INDEX 1

@protocol SetupElementProtocol <NSObject>

- (void) initInputView;
- (void) exitInputView;
- (void) dismissInputView;
- (void) setInputDelegate: (id) inputView;

- (void) reloadElement;

- (id) getElementValue;
- (void) setElementValue: (id) value;

- (NSArray*) returnDefaultKeyValue;

@end