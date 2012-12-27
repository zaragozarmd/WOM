//
//  RegisterViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/21/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *retypePassword;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;
@property (nonatomic, retain) IBOutlet UIView *progressView;
@property (nonatomic, retain) IBOutlet UIButton *registerBtn;

-(IBAction)registerUser:(id)sender;

@end
