//
//  BaseLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/29.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessLogicHandler.h"
#import <UIKit/UIKit.h>

@interface BaseLevelHandler : NSObject
@property (nonatomic) STATE_TYPE storedNextState;
@property (nonatomic, weak) UIViewController* nowVC;
@property (nonatomic, weak) UIViewController* nextVC;

@end
