//
//  LoginViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/21/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;
@property (nonatomic, retain) IBOutlet UIButton *bgBtn;
@property (nonatomic, retain) IBOutlet UIButton *loginBtn;
@property (nonatomic, retain) IBOutlet UIView *progressView;
@property (nonatomic, retain) UIWindow *window;

-(IBAction)loginUser:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;



@end
