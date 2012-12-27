//
//  CaptureViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/18/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "CaptureViewController.h"
#import "API.h"
#import "UIImage+Resize.h"

@interface CaptureViewController ()

@end

@implementation CaptureViewController
@synthesize captureImage = _captureImage;
@synthesize uploadBtn;

-(void)stopActivityAnimation
{
    self.activityView.hidden = YES;
    [self.activityInd stopAnimating];
}

-(void)startActivityAnimation
{
    self.activityView.hidden = NO;
    [self.activityInd startAnimating];
}

-(void)capture
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pick a source" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Gallery", nil];
    
    [alert show];
}

-(UIImage*)createThumbnail:(UIImage*)image
{
    return [image resizedImage:CGSizeMake(90, 90) interpolationQuality:kCGInterpolationHigh];
}

-(IBAction)uploadPhoto:(id)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSNumber *userid = [user objectForKey:@"userid"];
    
    [self startActivityAnimation];
    
    if (_captureImage.image) {
        UIImage *img = _captureImage.image;
        UIImage *thumb = [self createThumbnail:img];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"upload", @"command",
//                                       userid, @"userid",
                                       UIImageJPEGRepresentation(img,70), @"file",
                                       UIImageJPEGRepresentation(thumb,70), @"thumb",
                                       @"title1", @"title", nil];
        
        [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json){
            if (![json objectForKey:@"error"]) {
                [self stopActivityAnimation];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your photo has been uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                NSString* errorMsg = [json objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self stopActivityAnimation];
            }
        }];
    }
    else
    {
        [self capture];
        [self stopActivityAnimation];
    }
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIImage*)resizePickedImage:(UIImage*)image
{
    CGSize newSize = CGSizeMake(kPicWidth, kPicHeight);
    UIGraphicsBeginImageContextWithOptions(newSize, 1.0f, 0.0f);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Resize the image from the camera
	UIImage *scaledImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(_captureImage.frame.size.width, _captureImage.frame.size.height) interpolationQuality:kCGInterpolationHigh];
    
    // Crop the image to a square (yikes, fancy!)
    UIImage *croppedImage = [scaledImage croppedImage:CGRectMake((scaledImage.size.width -_captureImage.frame.size.width)/2, (scaledImage.size.height -_captureImage.frame.size.height)/2, _captureImage.frame.size.width, _captureImage.frame.size.height)];
    
    // Show the photo on the screen
    _captureImage.image = croppedImage;
    [picker dismissModalViewControllerAnimated:NO];
    
}

-(void)takePhoto {

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
}

-(void)viewDidUnload
{
    _captureImage.image = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Camera"])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        #if TARGET_IPHONE_SIMULATOR
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        #else
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        #endif
            imagePickerController.editing = YES;
            imagePickerController.delegate = (id)self;
        
            [self presentModalViewController:imagePickerController animated:YES];
    }
    else if([title isEqualToString:@"Gallery"])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        imagePickerController.editing = YES;
        imagePickerController.delegate = (id)self;
        
        [self presentModalViewController:imagePickerController animated:YES];
    }
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [self stopActivityAnimation];
    if (!_captureImage.image) {
        [self capture];
    }


}

-(void)viewWillDisappear:(BOOL)animated
{
    _captureImage.image = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
