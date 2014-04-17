//
//  EMailSetupElement.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/17.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupElementProtocol.h"

@interface EMailSetupElement : NSObject <UITextFieldDelegate, SetupElementProtocol>
@property (nonatomic, weak) UITextField* textField;

- (NSString*) getEmail;
@end
