//
//  GeolocForbiddenViewController.m
//  Louis-Voiturier
//
//  Created by Giang Christian on 13/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "GeolocForbiddenViewController.h"
#import "Common.h"
#import "MainViewController.h"

@interface GeolocForbiddenViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITextView *myUITextView;
@property (strong, nonatomic) IBOutlet UIButton *settingButton;

@end

@implementation GeolocForbiddenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    // configure et cache le button d'accès aux réglages
    [self configureSettingButtonAndUITextView];
    
    // demande de push
    [self askForNotification];
    
    // Demande à l'utilisateur d'accepter la géolocalisation
    [self askUserToEnableGeoloc];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [GAI sendScreenViewWithName:@"Geoloc Forbidden"];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // faire apparaitre la navigation barre pour la fenetre suivante (ie : la Home)
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}



-(void) configureSettingButtonAndUITextView
{
    //----------------------------------
    //---------- UITextView ---------
    //----------------------------------
    [_myUITextView setHidden:YES];
    [_myUITextView setTextColor:[UIColor whiteColor]];
    self.myUITextView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.myUITextView.layer.shadowOpacity = 0.5;
    self.myUITextView.layer.shadowRadius = 1.0f;
    self.myUITextView.layer.shadowOffset = CGSizeMake(0, 1);
    //    [_myUITextView setTintColor:[UIColor whiteColor]];
    [_myUITextView setBackgroundColor:[UIColor grayColor]];
    
    //----------------------------------
    //---------- button de réglages ---------
    //----------------------------------
    [_settingButton setHidden:YES];
    [_settingButton setTitle:NSLocalizedString(@"Geoloc-Setting-Button", nil) forState:UIControlStateNormal];
    [_settingButton setTintColor:[UIColor whiteColor]];
    //    [_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_settingButton setBackgroundColor:[UIColor louisMainColor]];
    [[_settingButton layer] setCornerRadius:5];
    [[_settingButton titleLabel] setFont:[UIFont boldSystemFontOfSize:20]];
}


// Détermine l'origine de l'appel. On vient du SignUpProfileTableViewController ou bien du SignInTableViewController
- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}


-(void) askForNotification
{
    dispatch_async(dispatch_get_main_queue(),^
        {
                       
           UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                                | UIUserNotificationTypeBadge
                                                                                                | UIUserNotificationTypeSound) categories:nil];
           [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
            // affichage du message alerte push en asynchrone
           [[UIApplication sharedApplication] registerForRemoteNotifications];
    
        });
}


-(void) askUserToEnableGeoloc
{
    // si le services de géolocalisation est activé
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
    }
    
}


// Accès à la home
- (void)gotoHome
{
    NSLog(@"go to MainViewController");
    MainViewController *viewController = [[MainViewController alloc] init];
    [viewController setTitle:@"ViewController"];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


// Tells the delegate that the authorization status for the application changed.
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"didChangeAuthorizationStatus");
    
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        {
            // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                // Demande à l'utilisateur l'autorisation de le géolocaliser
                [self.locationManager requestWhenInUseAuthorization];
                
                //on accède à Home dans la méthode didChangeAuthorizationStatus car la demande d'autorisation est asynchrone
            }
            break;
        }
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {    // ce cas et possible si l'utilisateur recrée un 2nd compte
            [self gotoHome];
            break;
        }
            
        case kCLAuthorizationStatusAuthorizedAlways:
        {    // ce cas et possible si l'utilisateur recrée un 2nd compte
            [self gotoHome];
            break;
        }
        case kCLAuthorizationStatusDenied:
            // show button reglages
            [self.settingButton setHidden:NO];
            [self.myUITextView setHidden:NO];
            break;
        case kCLAuthorizationStatusRestricted:
            // show button reglages
            [self.settingButton setHidden:NO];
            [self.myUITextView setHidden:NO];
            break;
    }
}






- (IBAction)settingButtonTouch:(UIButton *)sender
{
    
    // Accès aux réglages de l'iphone spécifique à notre app
    [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
