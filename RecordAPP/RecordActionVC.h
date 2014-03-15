//
//  RecordActionVC.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/22.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordActionLevelHandler.h"

@interface RecordActionVC : UIViewController
@property (nonatomic, weak) RecordActionLevelHandler* levelHandler;

- (void)manualStop;

@end
