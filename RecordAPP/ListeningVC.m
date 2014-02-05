//
//  ListeningVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/2.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "ListeningVC.h"
#import "ListenLevelHandler.h"
#import "DebugUtil.h"


@interface ListeningVC ()

@end

@implementation ListeningVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    CHECK_NOT_ENTER_HERE;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        [self setBaseLevelHandler:[[ListenLevelHandler alloc]initWithNowVC:self]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setBaseLevelHandler:[[ListenLevelHandler alloc]initWithNowVC:self]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)actionStart:(UIButton *)sender
{
    CHECK_NOT_ENTER_HERE;
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    if (FALSE == [[self baseLevelHandler] conformsToProtocol:@protocol(RecordActionProtocol)]) {
        DLog(@"baselevelhandler doesn't has RecordActionProtocol (%@)", NSStringFromClass([[self baseLevelHandler] class]));
        CHECK_NOT_ENTER_HERE;
    }
    id<RecordActionProtocol> recordAction = (id<RecordActionProtocol>)[self baseLevelHandler];
    if (FALSE == [recordAction start]) {
        DLog(@"Class() record cannot start");
        CHECK_NOT_ENTER_HERE;
    }
}

- (IBAction)actionStop:(UIButton *)sender
{
    CHECK_NOT_ENTER_HERE;
    if (nil == [self baseLevelHandler]) {
        CHECK_NOT_ENTER_HERE;
    }
    if (FALSE == [[self baseLevelHandler] conformsToProtocol:@protocol(RecordActionProtocol)]) {
        DLog(@"baselevelhandler doesn't has RecordActionProtocol (%@)", NSStringFromClass([[self baseLevelHandler] class]));
        CHECK_NOT_ENTER_HERE;
    }
    id<RecordActionProtocol> recordAction = (id<RecordActionProtocol>)[self baseLevelHandler];
    if (FALSE == [recordAction stop]) {
        DLog(@"Class() record cannot start");
        CHECK_NOT_ENTER_HERE;
    }
}

@end
