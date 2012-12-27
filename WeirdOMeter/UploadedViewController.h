//
//  UploadedViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/26/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbnailButton.h"

@interface UploadedViewController : UIViewController <ThumbnailButtonDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *streamView;
@property (nonatomic, retain) ThumbnailButton *selectedThumbnail;
@property (nonatomic, retain) IBOutlet UIView *progressView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;
@end
