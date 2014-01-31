//
//  BaseVC.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/30.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLevelHandler.h"

@interface BaseVC : UIViewController
@property (nonatomic, strong) id<BusinessLogicProtocol> baseLevelHandler;

@end
