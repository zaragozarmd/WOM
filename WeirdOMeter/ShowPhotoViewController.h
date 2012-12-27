//
//  ShowPhotoViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/27/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ShowPhotoViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *lblUsername;
@property (nonatomic, retain) IBOutlet UILabel *lblRate;
@property (nonatomic, retain) IBOutlet UIImageView *needle;
@property (nonatomic, retain) IBOutlet UIView *progressView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;

@property (nonatomic, assign) int photoid;
@property (nonatomic, assign) int userid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, assign) float rate;

@end
