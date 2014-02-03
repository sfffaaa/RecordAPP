//
//  RecordInfoLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/26.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevelHandler.h"
#import "BusinessLogicHandler.h"

@interface RecordInfoLevelHandler : BaseLevelHandler <BusinessLogicProtocol>
- (id) initWithNowVC: (id)VC;
- (BOOL) recordAgain;
- (BOOL) listen;
- (BOOL) submit;


@end
