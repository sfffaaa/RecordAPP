//
//  RecordingInfoVC.h
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/1.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordingInfoVC : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)unwindToRecordInfoVC:(UIStoryboardSegue *)unwindSegue;
@end
