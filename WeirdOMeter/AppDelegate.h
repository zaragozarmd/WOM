//
//  AppDelegate.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/17/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UIStoryboard *storyboard;
-(void)showTabBarController;
-(void)showLoginController;

@end
