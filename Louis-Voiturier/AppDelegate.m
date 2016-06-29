//
//  AppDelegate.m
//  Louis-Voiturier
//
//  Created by Thibault Le Cornec on 31/10/15.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "Common.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "SignInTableViewController.h"

static NSString *const kGATrackingID = @"YOUR_GOOGLE_ANALYTICS_ID_HERE";



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    [[GAI sharedInstance] trackerWithTrackingId:kGATrackingID];
    [[GAI sharedInstance] setTrackUncaughtExceptions:YES];
     [GAI sendScreenViewWithName:@"LaunchScreen"];
    
    return YES;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BOOL hasLogin = [[NSUserDefaults standardUserDefaults] boolForKey:(@"hasLoginKey")];
    
    // S'il y a auto Login
    if (hasLogin)
    {
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        
        UITableViewController *tVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        [tVC setTitle:@"TableView"];
        UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:tVC];
        
        MainViewController *viewController = [[MainViewController alloc] init];
        [viewController setTitle:@"ViewController"];
        UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        [tabBarController setViewControllers:@[navController1, navController2]];
        [self.window setRootViewController:viewController];
    }
    else
    {
        [self gotoSignInTableViewController];
    }
    

    return YES;
}



-(void)gotoSignInTableViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //    GeolocForbiddenViewController *geolocForbiddenVC  = [sb instantiateViewControllerWithIdentifier:@"GeolocForbiddenVC"];
    //    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:geolocForbiddenVC];
    
    SignInTableViewController *signInTVC  = [sb instantiateViewControllerWithIdentifier:@"signInTVC"];
    [signInTVC setTitle:@"CONNEXION"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:signInTVC];
    
    [self.window setRootViewController:navController];
    
}


//===============================================
#pragma mark - Notification
//===============================================

//
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
//{
//    NSLog(@"handleActionWithIdentifier");
//    //handle the actions
//    if ([identifier isEqualToString:@"declineAction"]){
//    }
//    else if ([identifier isEqualToString:@"answerAction"]){
//    }
//}
//
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
//}
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    NSLog(@"didFailToRegisterForRemoteNotificationsWithError");
//    NSLog(@"Error %@", error);
//    
//}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
