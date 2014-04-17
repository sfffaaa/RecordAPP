//
//  CreateSetupElementFactory.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/4/5.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupElementProtocol.h"

@interface CreateSetupElementFactory : NSObject
- (id<SetupElementProtocol>) createSetupElement: (NSString*) classStr;
@end
