//
//  DreamVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/8.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DreamVC.h"

#define MINIMUM_SCALE 0.5
#define MAXIMUM_SCALE 1.5

#define IMAGE_ALL_WIDTH 320
#define IMAGE_ALL_HEIGHT 1126

#define IMAGE_HALF_WIDTH 160
#define IMAGE_HALF_HEIGHT 563

@interface DreamVC ()

@end

@implementation DreamVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView* dreamImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dream_edit_over2.png"]];
    
    [dreamImageView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    [dreamImageView setUserInteractionEnabled:YES];
    
    [self.view addSubview:dreamImageView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) isAllowPanX:(float) center halfwidth:(float) half totalwidth:(float) total transition:(float) tran
{
    return false;
    if (tran > 0) {
        if (center - half - tran > 0) {
            return true;
        } else {
            return false;
        }
    } else {
        if (center + half - tran < total) {
            return true;
        } else {
            return false;
        }
    }
}

- (BOOL) isAllowPanY:(float) center halfwidth:(float) half totalwidth:(float) total transition:(float) tran
{
    if (tran > 0) {
        if (center + half + tran < total + 10) {
            return true;
        } else {
            return false;
        }
    } else {
        if (center + tran > 0 - 170) {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
#pragma mark (TODO) Fix Y-axis pan recognizer
    UIView* imageView = [self.view.subviews objectAtIndex:0];
    CGPoint translation = [recognizer translationInView:imageView];
    
    if (FALSE == [self isAllowPanX:imageView.center.x halfwidth:IMAGE_HALF_WIDTH totalwidth:IMAGE_ALL_WIDTH transition:translation.x]) {
        translation.x = 0;
    }
    if (FALSE == [self isAllowPanY:imageView.center.y halfwidth:IMAGE_HALF_HEIGHT totalwidth:IMAGE_ALL_HEIGHT transition:translation.y]) {
        translation.y = 0;
    }
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointZero inView:imageView];
}

@end
