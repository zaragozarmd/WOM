//
//  EditProfileViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 11/3/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "EditProfileViewController.h"
#import "API.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "UIImage+Resize.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

-(void)loadTabBar
{

    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad showLoginController];
    
}

-(IBAction)logout:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"logout", @"command", nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
     {
         if (![json objectForKey:@"error"]) {
             NSLog(@"logout successful");
             NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
             [user removeObjectForKey:@"username"];
             [user removeObjectForKey:@"password"];
             [user removeObjectForKey:@"userid"];
             
             [self loadTabBar];
         }
         else
         {
             NSLog(@"Logout error: %@", [json objectForKey:@"error"]);
         }
     }];
    
    
}

-(void)setPic:(UIImage*)image
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    UIImage *scaledImage = [image resizedImage: CGSizeMake(100, 100) interpolationQuality:kCGInterpolationHigh];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"uploadProfilePic", @"command",
                                   [user objectForKey:@"userid"], @"userid",
                                   [user objectForKey:@"username"], @"username",
                                   UIImageJPEGRepresentation(scaledImage,70), @"file", nil];
    
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
     {
         if (![json objectForKey:@"error"]) {
             NSLog(@"YEHEY");
             UIImage *profilepic = [scaledImage resizedImage: _profilePic.frame.size interpolationQuality:kCGInterpolationHigh];
             [self.profilePic setImage:profilepic forState:UIControlStateNormal];
         }
         else
         {
             NSLog(@"Uploade error: %@", [json objectForKey:@"error"]);
         }
     }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self setPic:image];
    
    [picker dismissModalViewControllerAnimated:NO];
}



#pragma mark Alert Functions
-(void)removeProfilePic
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"removeProfilePic", @"command",
                                   [user objectForKey:@"userid"], @"userid",
                                   [user objectForKey:@"username"], @"username",nil];
    
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
     {
         if (![json objectForKey:@"error"]) {
             NSLog(@"YEHEY");
             [self.profilePic setImage:[UIImage imageNamed:@"profilepic.png"] forState:UIControlStateNormal];
         }
         else
         {
             NSLog(@"Upload error: %@", [json objectForKey:@"error"]);
         }
     }];
}

-(void)showCamera
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

-(void)showGallery
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
}

-(void)getFromFB
{

}

-(IBAction)changeProfilePic:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Profile Picture" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Remove current picture", @"Camera", @"Gallery", @"Get from Facebook", nil];
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 1:
            NSLog(@"Remove");
            [self removeProfilePic];
            break;
        
        case 2:
            NSLog(@"Camera");
            [self showCamera];
            break;
            
        case 3:
            NSLog(@"Gallery");
            [self showGallery];
            break;
        
        case 4:
            NSLog(@"FB");
            break;
            
        default:
            break;
    }
}


#pragma mark UIViewController Methods
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
