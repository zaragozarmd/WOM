//
//  UploadedViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/26/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "UploadedViewController.h"
#import "API.h"
#import "ThumbnailButton.h"
#import "ShowPhotoViewController.h"


@interface UploadedViewController ()

@end

@implementation UploadedViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshStream];
}

-(void)viewDidDisappear:(BOOL)animated
{
    for(UIView *view in _streamView.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showStream:(NSArray *)stream
{
    for(UIView *view in _streamView.subviews)
    {
        [view removeFromSuperview];
    }
    
    for(int i=0; i<[stream count]; i++)
    {
        NSDictionary *thumb = [stream objectAtIndex:i];
        float rate = [[thumb objectForKey:@"avgRate"] floatValue];
        
        ThumbnailButton *thumbnail = [[ThumbnailButton alloc] initWithIndex:i andData:thumb];
        thumbnail.rate = rate;
        thumbnail.delegate = self;
        [_streamView addSubview:thumbnail];
    }
    
    int listHeight = ([stream count]/3 +1)*(kThumbSide+kPadding);
    [_streamView setContentSize:CGSizeMake(320, listHeight)];
    [_streamView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

-(void)refreshStream
{
    [_activityInd startAnimating];
    [_progressView setHidden:NO];
    
    NSNumber *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"getUploaded", @"command", userid, @"userid", nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json){
        [self showStream:[json objectForKey:@"result"]];
        [_activityInd stopAnimating];
        [_progressView setHidden:YES];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowPic"]) {
        ShowPhotoViewController *showphotoVC = [segue destinationViewController];
        showphotoVC.photoid = _selectedThumbnail.tag;
        showphotoVC.userid = _selectedThumbnail.userid;
        showphotoVC.username = _selectedThumbnail.username;
        showphotoVC.rate = _selectedThumbnail.rate;
    }
}

-(void)didSelectThumbnail:(ThumbnailButton*)sender
{
    _selectedThumbnail = sender;

    
    [self performSegueWithIdentifier:@"ShowPic" sender:nil];
    
}

@end
