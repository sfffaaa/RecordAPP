//
//  StatisticDetailVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/9.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "StatisticDetailVC.h"
#import "StatisticTableLevelHandler.h"

@interface StatisticDetailVC ()
@property (nonatomic, weak) StatisticTableLevelHandler* levelHandler;
@end

@implementation StatisticDetailVC
@synthesize levelHandler = _levelHandler;
@synthesize infoIndex = _infoIndex;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
#pragma mark (TODO) singleton
        _levelHandler = [[StatisticTableLevelHandler alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
