//
//  ShowPhotoViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/27/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "ShowPhotoViewController.h"
#import "API.h"

@interface ShowPhotoViewController ()

@end

@implementation ShowPhotoViewController

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
    [_activityInd startAnimating];
    [_progressView setHidden:NO];
    
    API *api = [API sharedInstance];

    _lblUsername.text = _username;
    _lblRate.text = [NSString stringWithFormat:@"%.1f", self.rate];
    
    float angle = ((_rate/10)/0.32) + (-26.7);
    self.needle.layer.anchorPoint = CGPointMake(self.needle.layer.anchorPoint.x, self.needle.layer.anchorPoint.y*2);
    [self.needle setTransform: CGAffineTransformMakeRotation(angle)];

    NSURL *imgURL = [api urlForImageWithId:[NSNumber numberWithInt:_photoid] andUserName:_username isThumb:NO];
    [_image setImageWithURL:imgURL];
    
    if (imgURL != nil) {
        [_activityInd stopAnimating];
        [_progressView setHidden:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
