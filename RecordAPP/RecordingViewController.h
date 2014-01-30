//
//  RecordingViewController.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/27.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordLevelHandler.h"

@interface RecordingViewController : UIViewController
@property (nonatomic, strong) id<RecordActionProtocol, BusinessLogicProtocol> recordAction;
@end
