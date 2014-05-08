//
//  ComposeStatisticTableVCViewController.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeStatisticTableLevelHandler.h"


@interface ComposeStatisticTableVCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ComposeStatisticTableLevelHandler* levelHandler;
- (void)setInfo:(id<RecordInfoProtocol>)info;

@end
