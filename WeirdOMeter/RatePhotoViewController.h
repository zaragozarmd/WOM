//
//  RatePhotoViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RateMeter.h"

@interface RatePhotoViewController : UIViewController<RateMeterDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet RateMeter *meter;
@property (nonatomic, retain) IBOutlet UIImageView *img;
@property (nonatomic, retain) IBOutlet UILabel *lblScore;
@property (nonatomic, retain) IBOutlet UIView *progressView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;

@property (nonatomic, assign) int photoid;
@property (nonatomic, assign) int userid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, assign) BOOL isRated;

-(IBAction)ratePhoto:(id)sender;

@end
