//
//  CaptureViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/18/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPicWidth 291
#define kPicHeight 237

@interface CaptureViewController : UIViewController <UIAlertViewDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *captureImage;
@property (nonatomic, retain) IBOutlet UIButton *uploadBtn;
@property (nonatomic, retain) IBOutlet UIView *activityView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;

-(IBAction)uploadPhoto:(id)sender;

@end
