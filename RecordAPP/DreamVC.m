//
//  DreamVC.m
//  RecordAPP
//
//  Created by sfffaaa on 2014/2/8.
//  Copyright (c) 2014年 sfffaaa. All rights reserved.
//

#import "DreamVC.h"
#import "DebugUtil.h"

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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void)viewWillLayoutSubviews{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.view.clipsToBounds = YES;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        self.view.frame =  CGRectMake(0, 20, self.view.frame.size.width,screenHeight - 20);
        self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
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

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *view = [gestureRecognizer view];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGPoint translation = [gestureRecognizer translationInView:self.view];
            //Disable x axis
            translation.x = 0;
            view.center = CGPointMake(gestureRecognizer.view.center.x + translation.x, gestureRecognizer.view.center.y + translation.y);
            [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            break;
        }
        case UIGestureRecognizerStateFailed:{
            break;
        }
        case UIGestureRecognizerStatePossible:{
            break;
        }
        case UIGestureRecognizerStateEnded:{

            CGPoint velocity = [gestureRecognizer velocityInView:self.view];
            //Disable x axis
            velocity.x = 0;
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            
            CGFloat slideMult = magnitude / 600;
            
            float slideFactor = 0.1 * slideMult;
            
            CGPoint finalPoint = CGPointMake(view.center.x + (velocity.x * slideFactor), view.center.y + (velocity.y * slideFactor));

            finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
            //Below point is tunning
            finalPoint.y = MIN(MAX(finalPoint.y, -65), self.view.bounds.size.height + 15);
            
            [UIView animateWithDuration:slideFactor * 2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                view.center = finalPoint;
            } completion:nil];
            
            break;
        }
        default:{
            CHECK_NOT_ENTER_HERE;
            break;
        }
    }
}

@end
