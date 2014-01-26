//
//  RecordLevelHandler.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/1/25.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordLevelHandler : NSObject

- (int) getRemainRecordTime;
- (NSString*) getRecordingPath;
- (BOOL) startRecording:(NSString*) filePath;
@end
