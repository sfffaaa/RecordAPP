//
//  RecordInfoTableViewCellProtocol.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/5/4.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RecordInfoProtocol.h"
#import "StatisticTableVC.h"

@protocol RecordInfoTableViewCellProtocol <NSObject>

#pragma mark - TableViewCell related
- (void)tableView:(UITableView *)tableView didSelectRowAtRecordInfo:(id<RecordInfoProtocol>) info VC:(UIViewController*) VC;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtRecordInfo:(id<RecordInfoProtocol>) info;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtRecordInfo:(id<RecordInfoProtocol>) info;

- (BOOL)tableView:(UITableView *)tableView canEditRowAtRecordInfo:(id<RecordInfoProtocol>) info;

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtRecordInfo:(id<RecordInfoProtocol>) info;

@end
