//
//  RateViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "RateViewController.h"
#import "API.h"
#import "RatePhotoViewController.h"


@interface RateViewController ()

@property (nonatomic, assign) BOOL isRated;
@property (nonatomic, assign) BOOL didSelect;

@end

@implementation RateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
    }
    return self;
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
        
        ThumbnailButton *thumbnail = [[ThumbnailButton alloc] initWithIndex:i andData:thumb];
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

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"getRateStream", @"command", nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json){
        [self showStream:[json objectForKey:@"result"]];
        [_activityInd stopAnimating];
        [_progressView setHidden:YES];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.isRated = NO;
    self.didSelect = NO;
    self.navigationItem.hidesBackButton = YES;
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"RatePhoto"]) {
        RatePhotoViewController *ratephotoVC = [segue destinationViewController];
        ratephotoVC.photoid = _selectedThumbnail.tag;
        ratephotoVC.userid = _selectedThumbnail.userid;
        ratephotoVC.username = _selectedThumbnail.username;
        ratephotoVC.isRated = _isRated;
    }
}

-(void)didSelectThumbnail:(ThumbnailButton*)sender
{
    if (!self.didSelect) {
        [_activityInd startAnimating];
        [_progressView setHidden:NO];
        self.didSelect = YES;
        _selectedThumbnail = sender;
        NSLog(@"didSelectThumbnail");
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"checkIfRated", @"command",
                                       [NSNumber numberWithInt:_selectedThumbnail.tag], @"photoid",
                                       [NSNumber numberWithInt:_selectedThumbnail.userid], @"userid",
                                       nil];
        
        [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
         {
             int count = 0;
             if (![json objectForKey:@"error"]) {
                 count = [[json objectForKey:@"result"] count];
                 if (count > 0) {
                     self.isRated = YES;
                 }
             }
             else
             {
                 NSLog(@"Error: %@", [json objectForKey:@"error"]);
             }
             [self performSegueWithIdentifier:@"RatePhoto" sender:nil];
             [_activityInd stopAnimating];
             [_progressView setHidden:YES];
         }];
    }
    
}




@end
