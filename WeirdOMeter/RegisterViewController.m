//
//  RegisterViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/21/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "RegisterViewController.h"
#import "API.h"
#import "AppDelegate.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

-(void)dismissKeyboard
{
    [_email resignFirstResponder];
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_retypePassword resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    switch (textField.tag) {
        case 1:
            [_username becomeFirstResponder];
            return YES;
            break;
            
        case 2:
            [_password becomeFirstResponder];
            return YES;
            break;
            
        case 3:
            [_retypePassword becomeFirstResponder];
            return YES;
            break;
        
        case 4:
            [self registerUser:_registerBtn];
            return NO;
            break;
            
        default:
            return NO;
            break;
    }
    
    
}

-(BOOL)checkTextfields
{
    return (_email.text.length>0 &&
            _username.text.length>0 &&
            _password.text.length>0 &&
            _retypePassword.text.length>0);
}

-(void)loadTabBar
{
    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [ad showTabBarController];
    
}





-(IBAction)registerUser:(id)sender
{
    [self dismissKeyboard];
    [_progressView setHidden:NO];
    [_activityInd startAnimating];
    
    if([self checkTextfields])
    {
        if ([_password.text isEqualToString:_retypePassword.text])
        {

            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"register", @"command",
                                           _username.text, @"username",
                                           _password.text, @"password",
                                           _email.text, @"email",
                                           nil];
            
           

            [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
             {
             //result returned
                NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                 NSLog(@"res %@", res);
                if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"userid"] intValue]>0)
                {
                 //success
                    NSUserDefaults *userDefs = [NSUserDefaults standardUserDefaults];
                 
                    [userDefs setObject:_username.text forKey:@"username"];
                    [userDefs setObject:_password.text forKey:@"password"];
                    [userDefs setObject:[res objectForKey:@"userid"] forKey:@"userid"];
                    NSLog(@"success");
                 [self loadTabBar];
                    
                }
                else
                {
                 //error
                    NSLog(@"Error %@", [json objectForKey:@"error"]);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check Username/Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                 
                    _username.text = @"";
                    _password.text = @"";
                    [_username becomeFirstResponder];
                 
                }
            }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        
            _password.text = @"";
            _retypePassword.text = @"";
            [_password becomeFirstResponder];
            [_progressView setHidden:YES];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill up all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [_progressView setHidden:YES];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _email.delegate = self;
    _username.delegate = self;
    _password.delegate = self;
    _retypePassword.delegate = self;
    
    [_email becomeFirstResponder];
    [_progressView setHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
