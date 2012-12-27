//
//  RatePhotoViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "RatePhotoViewController.h"
#import "API.h"

@interface RatePhotoViewController ()

@end

@implementation RatePhotoViewController


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
    
    if (self.isRated) {
        [_activityInd stopAnimating];
        [_progressView setHidden:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have already rated this photo. Do you want to update your rate?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles: @"NO", nil];
        alert.tag = 0;
        [alert show];
    }
    
    
    API *api = [API sharedInstance];
    
    NSURL *imgURL = [api urlForImageWithId:[NSNumber numberWithInt:_photoid] andUserName:_username isThumb:NO];
    
    [_imageView setImageWithURL:imgURL];
//
//    if (_imageView.image != nil) {
        [_activityInd stopAnimating];
        [_progressView setHidden:YES];
//    }
    
    _img.layer.anchorPoint = CGPointMake(_img.layer.anchorPoint.x, _img.layer.anchorPoint.y*2);
    [self.img setTransform: CGAffineTransformMakeRotation((M_PI / 180) *-90)];
    self.meter.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if (alertView.tag == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if(alertView.tag == 0)
            {
                NSLog(@"Update");
            }
            
            break;
        case 1:
            if (alertView.tag == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
            
        default:
            
            break;
    }
    
}

-(IBAction)ratePhoto:(id)sender
{
    [_activityInd startAnimating];
    [_progressView setHidden:NO];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"rate", @"command",
                                   [NSNumber numberWithInt:_photoid], @"photoid",
                                   [NSNumber numberWithInt:_userid], @"userid",
                                   [NSNumber numberWithBool:_isRated], @"update",
                                   _lblScore.text, @"rate",
                                   nil];
 
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
     {
         if (![json objectForKey:@"error"]) {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Rate successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             alert.tag = 1;
             [alert show];
         }
         else
         {
             NSLog(@"Error: %@", [json objectForKey:@"error"]);
             
         }
         
         [_activityInd stopAnimating];
         [_progressView setHidden:YES];
     }];
}


-(void)rotateNeedle:(float)angle
{
    angle = angle - 20;
    
    if (angle < -26.7) {
        angle = -26.7;
    }
    else if (angle > -23.55)
    {
        angle = -23.55;
    }

    [self.img setTransform: CGAffineTransformMakeRotation(angle)];
    
    float score = angle - (-26.7);
    score = (score*0.32)*10;
    
    
    if (score > 10.0) {
        score = 10.0;
    }
    else if (score < 0.0)
    {
        score = 0.0;
    }
    
    self.lblScore.text = [NSString stringWithFormat:@"%.1f", score];
}

@end
