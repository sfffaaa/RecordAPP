//
//  RecordAppDelegate.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/20.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "RecordAppDelegate.h"
#import "BusinessLogicHandler.h"
#import "InitializatorLevelHandler.h"
#import "UserSetting.h"
#import "DebugUtil.h"

@implementation RecordAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#pragma mark (TODO) Need one VC for enter a icon page.
    
//  Setup view controller
    [self.window makeKeyAndVisible];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"initialView"];
    
    [self.window.rootViewController presentViewController:mainViewController animated:NO completion:nil];

//  Setup
//    1. setup user default register
    [UserSetting UserDefaultRegister];
//    2. setup wake upder handler
    [WakeupHandler getInst];
//    3.
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification) {
        application.applicationIconBadgeNumber = 0;
    }
/*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RecordTime" bundle:nil];
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"timeToRecord"];
    
    [self.window.rootViewController presentViewController:mainViewController animated:NO completion:nil];
    //    self.window.rootViewController = mainViewController;
*/

    //1. Set and initial init handler
    /*
    InitializatorLevelHandler* initHandler = [[InitializatorLevelHandler alloc] init];
    [initHandler setNowVC:recordingVC];
    [initHandler setStoredNextState:RECORD_VOICE_START_STATE];

    //   2. Set Business logic handler state (Recording)
    [[BusinessLogicHandler getBusinessLogicHanlder] setNowState:INIT_STATE];
    [[BusinessLogicHandler getBusinessLogicHanlder] setHandler:initHandler];
    
    //  3. Set navigation view controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:recordingVC];
    [navigationController setNavigationBarHidden:TRUE];
    [self.window setRootViewController:navigationController];
    [[[self.window rootViewController] navigationController] setNavigationBarHidden:TRUE];
    
    //  4. Start initialization
    if (FALSE == [initHandler startInitialize]) {
        DLog(@"Should not enter here");
        return NO;
    }
    // 5. Goto Next;
    if (0 != [[BusinessLogicHandler getBusinessLogicHanlder] goNext]) {
        DLog(@"BusinessLogicHandler error: cannot go Next");
        return NO;
    }
*/
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [WakeupHandler wakeUp];
/*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RecordTime" bundle:nil];
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"timeToRecord"];

    [self.window.rootViewController presentViewController:mainViewController animated:YES completion:nil];
*/
//    self.window.rootViewController = mainViewController;
//    [self.window makeKeyAndVisible];

/*    BusinessLogicHandler* handler = [BusinessLogicHandler getBusinessLogicHanlder];
    [handler goNext];
 */
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    application.applicationIconBadgeNumber = 0;
    [WakeupHandler wakeUp];
}

@end
