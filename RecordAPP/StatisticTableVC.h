//
//  StatisticTableVC.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/8.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticTableLevelHandler.h"

@interface StatisticTableVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) StatisticTableLevelHandler* levelHandler;

@end
