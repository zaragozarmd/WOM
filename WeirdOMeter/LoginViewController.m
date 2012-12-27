//
//  LoginViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/21/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "LoginViewController.h"
#import "API.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)loadTabBar
{

    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad showTabBarController];

}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    
    switch (textField.tag) {
        case 1:
            [_password becomeFirstResponder];
            return YES;
            break;
        
        case 2:
            [self loginUser:_loginBtn];
            return NO;
            break;
            
        default:
            return NO;
            break;
    }
    
    
}


-(IBAction)dismissKeyboard:(id)sender
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}

-(IBAction)loginUser:(id)sender
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_activityInd startAnimating];
    
    self.activityInd.hidden = NO;
    self.progressView.hidden = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"login", @"command",
                                   _username.text, @"username",
                                   _password.text, @"password",
                                   nil];

    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
     {
         //result returned
         NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
        
         if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"userid"] intValue]>0) {
             //success
             NSUserDefaults *userDefs = [NSUserDefaults standardUserDefaults];
             
             [userDefs setObject:_username.text forKey:@"username"];
             [userDefs setObject:_password.text forKey:@"password"];
             [userDefs setObject:[res objectForKey:@"userid"] forKey:@"userid"];
             
             [self loadTabBar];
             
         } else {
             //error
             NSLog(@"Error %@", [json objectForKey:@"error"]);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[json objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];
             
             _username.text = @"";
             _password.text = @"";
             [_username becomeFirstResponder];
             
         }
         
        [_activityInd stopAnimating];
         
        self.activityInd.hidden = YES;
        self.progressView.hidden = YES;
     }];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.activityInd.hidden = YES;
    self.progressView.hidden = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _username.delegate = self;
    _password.delegate = self;
    
    [_username becomeFirstResponder];
    _bgBtn.showsTouchWhenHighlighted = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
