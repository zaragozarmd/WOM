//
//  EditProfileViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 11/3/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UIAlertViewDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) IBOutlet UIButton *profilePic;

-(IBAction)logout:(id)sender;
-(IBAction)changeProfilePic:(id)sender;

@end
