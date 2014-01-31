//
//  BaseLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/29.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BusinessLogicHandler.h"
#import "BaseVC.h"

@class BaseVC;

@interface BaseLevelHandler : NSObject
@property (nonatomic) STATE_TYPE storedNextState;
#pragma  mark - (TODO) Just create a class (check later)
@property (nonatomic, weak) BaseVC* nowVC;
@property (nonatomic, weak) BaseVC* nextVC;

@end
