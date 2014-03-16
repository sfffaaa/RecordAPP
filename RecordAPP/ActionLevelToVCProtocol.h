//
//  ActionLevelToVCProtocol.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/3/6.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActionLevelToVCProtocol <NSObject>

- (int) getPerpareTime;
#pragma mark (TODO) Change the name (not precise)
- (float) getActionTime;

- (BOOL) start;
- (BOOL) stop;

- (BOOL) prepareActions;

- (BOOL) prepareStart;
- (BOOL) prepareStop;

- (BOOL) isPrepare;
- (BOOL) manualStop;

@end
