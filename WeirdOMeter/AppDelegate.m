//
//  AppDelegate.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/17/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

NSString *const FBSessionStateChangedNotification =
@"com.rhomhazar.weirdometer:FBSessionStateChangedNotification";



@implementation AppDelegate

-(void)showLoginController
{
    UIViewController *tabVC = [_storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.window setRootViewController:tabVC];
}

-(void)showTabBarController
{
    UIViewController *tabVC = [_storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    [self.window setRootViewController:tabVC];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"username"];
//    [user removeObjectForKey:@"userid"];
//    [user removeObjectForKey:@"password"];
    [user setObject:@"asdf" forKey:@"username"];
    [user setObject:@"asdf" forKey:@"password"];
    [user setObject:[NSNumber numberWithInt:17] forKey:@"userid"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        CGFloat scale = [UIScreen mainScreen].scale;
        result = CGSizeMake(result.width*scale, result.height*scale);
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        if (result.height == 1136) {
            self.storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone5" bundle:nil];
        }
        else
        { 
            self.storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        }
        
        NSLog(@"username: %@", [user objectForKey:@"username"]);
        if ([user objectForKey:@"username"] == nil) {
            [self showLoginController];
        }
        else{
            [self showTabBarController];
        }
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
   
}


@end
