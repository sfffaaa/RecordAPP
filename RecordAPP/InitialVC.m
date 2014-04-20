//
//  InitialVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/7.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "InitialVC.h"
#import "DebugUtil.h"
#import "InitializatorLevelHandler.h"

@interface InitialVC ()
@property (nonatomic, strong) InitializatorLevelHandler* levelHandler;
@end

@implementation InitialVC
@synthesize levelHandler = _levelHandler;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
#pragma mark (TODO) singleton?
        _levelHandler = [[InitializatorLevelHandler alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#pragma mark (TODO) Implement _levelHandler setStatus
    if (FALSE == [_levelHandler setStatus]) {
        CHECK_NOT_ENTER_HERE;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializedOver:) name:INITIAL_EVENT object:nil];
}

- (void) initializedOver:(NSNotification*) notification
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabBarVC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarView"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //Remove notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:INITIAL_EVENT object:nil];
    
    [UIView transitionWithView:window
                      duration:0
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        [window setRootViewController:tabBarVC];
                    }
                    completion:^(BOOL finished) {
                        if (FALSE == [[self levelHandler] wakeup]) {
                            CHECK_NOT_ENTER_HERE;
                        };
                    }
     ];
}

@end
