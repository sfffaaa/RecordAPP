//
//  ListenLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/4.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessLogicHandler.h"
#import "RecordActionProtocol.h"
#import "BaseLevelHandler.h"

@interface ListenLevelHandler : BaseLevelHandler <RecordActionProtocol, BusinessLogicProtocol>
- (id) initWithNowVC: (id)VC;
@end
