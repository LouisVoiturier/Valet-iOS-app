//
//  MainViewController.m
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "MainViewController.h"
#import "RecapView.h"
#import "Socket_IO_Client_Swift-Swift.h"
#import "Common.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController ()

@property (nonatomic, strong) UIButton *interactionButton;

/** Label de checkin ou checkout */
@property (nonatomic, strong) UILabel *checkLabel;

/** Label placé à coté du check pour avoir des précision sur l'action à effectuer */
@property (nonatomic, strong) UILabel *infoLabel;

/** View dans laquelle on à toute les information concernant la course */
@property (nonatomic, strong) RecapView *recapView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIButton *validationButton;


@property (nonatomic, strong) SocketIOClient *socket;

@property (nonatomic, strong) NSDictionary *courseDictionary;

/** POUR TEST */
@property (nonatomic, strong) NSString *emailCheckinValet;
@property (nonatomic, strong) NSString *emailCheckoutValet;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor louisBackgroundApp];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    /***************************/
    /***** ChECK LABEL *****/
    /**************************/
    _checkLabel = [[UILabel alloc] init];
    _checkLabel.font = [UIFont louisLabelFont];
    _checkLabel.tintColor = [UIColor louisLabelColor];
    
    [_checkLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_checkLabel];
    
    
    /***************************/
    /***** INFO LABEL *****/
    /**************************/
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = [UIFont louisHeaderFont];
    _infoLabel.tintColor = [UIColor louisTitleAndTextColor];
    
    [_infoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_infoLabel];
    
    
    /***************************/
    /***** RECAP VIEW *****/
    /**************************/
    _recapView = [[RecapView alloc] init];
    [_recapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[[_recapView addressView] itineraryButton] addTarget:self action:@selector(launchItinerary:) forControlEvents:UIControlEventTouchUpInside];
    [[[_recapView userInfoView] callButton] addTarget:self action:@selector(callClient:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_recapView];
    
    
    /***************************/
    /***** LOGO IMAGE VIEW *****/
    /**************************/
    _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CallLogo"]];
    
    [_logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_logoImageView];
    
    
    /***************************/
    /***** VALIDATION BUTTON *****/
    /**************************/
    _validationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _validationButton.titleLabel.font = [UIFont louisBiggestButton];
    _validationButton.tintColor = [UIColor whiteColor];
    _validationButton.backgroundColor = [UIColor louisMainColor];
    _validationButton.layer.cornerRadius = 10.f;
    
    [_validationButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_validationButton];
    
    
    
    /*********************/
    /***** SOCKET.IO *****/
    /*********************/
    self.socket = [[SocketIOClient alloc] initWithSocketURL:@"https://salty-citadel-4114.herokuapp.com:443" options:nil];
    [self.socket connect];
    
    
    
    /***************************/
    /***** TEST *****/
    /**************************/
    _emailCheckinValet = [[NSString alloc] init];
    _emailCheckinValet = @"Harpon";
    _emailCheckoutValet = [[NSString alloc] init];
    _emailCheckoutValet = @"Moreno";
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    /******************************/
    /***** INTERACTION BUTTON *****/
    /******************************/
    _interactionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _interactionButton.hidden = YES;
    
    [_interactionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_interactionButton];
    
    
    [self addHandlers];
    
    [self addInitialConstraints];
}

-(void)addHandlers
{
    [self.socket onAny:^(SocketAnyEvent * _Nonnull event)
    {
        NSLog(@"ANY EVENT : %@", event);
    }];
    
    [self.socket on:[NSString stringWithFormat:@"CheckinPickup%@", _emailCheckinValet]
           callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nullable ack)
     {
         NSLog(@"%@", data);
         _courseDictionary = [data firstObject];
         [self setAdressFromLocation];
         [self setClientName];
         
         [_validationButton setTitle:NSLocalizedString(@"Main-Button-Title-Vehicle-Retrieve", nil) forState:UIControlStateNormal];
         [_validationButton addTarget:self
                               action:@selector(HandleCheckinPickupDone:)
                     forControlEvents:UIControlEventTouchUpInside];
         
         
         _checkLabel.text = [_courseDictionary objectForKey:@"check"];
         _recapView.addressView.placeTitleLabel.hidden = YES;
         _recapView.addressView.placeDescriptionLabel.hidden = YES;
     }];
    
    [self.socket on:[NSString stringWithFormat:@"CheckoutPickup%@", _emailCheckoutValet]
           callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nullable ack)
     {
         NSLog(@"%@", data);
         _courseDictionary = [data firstObject];
         [self setAdressFromLocation];
         [self setClientName];
         
         [_validationButton setTitle:NSLocalizedString(@"Main-Button-Title-Vehicle-Retrieve", nil) forState:UIControlStateNormal];
         [_validationButton addTarget:self
                               action:@selector(HandleCheckoutPickupDone:)
                     forControlEvents:UIControlEventTouchUpInside];
         
         _checkLabel.text = [_courseDictionary objectForKey:@"check"];
         _recapView.addressView.placeTitleLabel.hidden = YES;
         _recapView.addressView.placeDescriptionLabel.hidden = YES;
     }];
    
}


#pragma mark - Outlets handlers

-(IBAction)HandleCheckinPickupDone:(UIButton *)sender
{
    [self.socket emit:@"CheckinPickupDone"
            withItems:@[[self.courseDictionary objectForKey:@"clientEmail"],
                        @{}]];
    
    [_validationButton setTitle:NSLocalizedString(@"Main-Button-Title-Vehicle-Parked", nil) forState:UIControlStateNormal];
    [_validationButton removeTarget:self
                             action:@selector(HandleCheckinPickupDone:)
                   forControlEvents:UIControlEventTouchUpInside];
    [_validationButton addTarget:self
                          action:@selector(HandleCheckinParkedDone:)
                forControlEvents:UIControlEventTouchUpInside];

}

-(IBAction)HandleCheckinParkedDone:(UIButton *)sender
{
    [self.socket emit:@"CheckinParkedDone"
            withItems:@[[self.courseDictionary objectForKey:@"clientEmail"],
                        @{}]];
    
    [_validationButton removeTarget:self
                             action:@selector(HandleCheckinParkedDone:)
                   forControlEvents:UIControlEventTouchUpInside];
}



-(IBAction)HandleCheckoutPickupDone:(UIButton *)sender
{
    [_validationButton setTitle:NSLocalizedString(@"Main-Button-Title-Vehicle-Parked", nil) forState:UIControlStateNormal];
    
    [_validationButton removeTarget:self
                             action:@selector(HandleCheckoutPickupDone:)
                   forControlEvents:UIControlEventTouchUpInside];
    [_validationButton addTarget:self
                          action:@selector(HandleCheckoutDone:)
                forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)HandleCheckoutDone:(UIButton *)sender
{
    [self.socket emit:@"CheckoutDone"
            withItems:@[[self.courseDictionary objectForKey:@"clientEmail"],
                        @{}]];
    
    [_validationButton removeTarget:self
                             action:@selector(HandleCheckoutDone:)
                   forControlEvents:UIControlEventTouchUpInside];
}



- (void)launchItinerary:(id)sender
{
    // Launch itinerary from address in Plans, or Google Maps.
}



- (void)callClient:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", [self.courseDictionary objectForKey:@"clientNumber"]]]];
}



#pragma mark - Localize Methods

-(void)setClientName
{
    _recapView.userInfoView.clientName.text = [NSString stringWithFormat:@"%@ %@", [self.courseDictionary objectForKey:@"clientFirstName"], [self.courseDictionary objectForKey:@"clientLastName"]];
}

-(void)setAdressFromLocation
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[[[self.courseDictionary objectForKey:@"coordinates"] objectForKey:@"latitude"] floatValue]
                                                      longitude:[[[self.courseDictionary objectForKey:@"coordinates"] objectForKey:@"longitude"] floatValue]];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *adress;
             NSString *zipCode;
             if (![placemark subThoroughfare] && ![placemark thoroughfare])
             {
                 adress = @"";
             }
             else
             {
                 adress = [NSString stringWithFormat:@"%@ %@", [placemark subThoroughfare], [placemark thoroughfare]];
                 zipCode = [NSString stringWithFormat:@"%@", [placemark postalCode]];
             }
             adress = [adress stringByReplacingOccurrencesOfString:@"(null)" withString:@""];  // S'il y a une donnée null on ne l'affiche pas
             
             _recapView.addressView.adressLabel.text = adress;
             _recapView.addressView.zipCodeLabel.text = zipCode;
             
         }
         
     }];
    
}

-(void)addInitialConstraints
{
    NSNumber *viewWidth = [NSNumber numberWithFloat:self.view.frame.size.width];
    NSNumber *viewHeight = [NSNumber numberWithFloat:self.view.frame.size.height];
    
    NSNumber *spacing = @15;
    NSNumber *smallSpacing = @6;
    NSNumber *logoToButtonSpacing = @40;
    
    NSNumber *logoSize = @68;
    
    NSNumber *recapHeight = @130;
    NSNumber *buttonHeight = @85;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_checkLabel, _infoLabel, _recapView, _logoImageView, _validationButton);
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(viewWidth, viewHeight, spacing, smallSpacing, logoToButtonSpacing, logoSize, recapHeight, buttonHeight);
    
    // Horizontale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_checkLabel][_infoLabel]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_recapView]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_logoImageView(logoSize)]-logoToButtonSpacing-[_validationButton]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[_checkLabel]-smallSpacing-[_recapView(recapHeight)]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    // Verticale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_infoLabel]-smallSpacing-[_recapView]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    // Verticale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_logoImageView(logoSize)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_validationButton(buttonHeight)]-spacing-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    // Alignements
    NSLayoutConstraint *hTimeHAlign = [NSLayoutConstraint constraintWithItem:_interactionButton
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0
                                                                    constant:0.0];
    
    NSLayoutConstraint *hDescriptionAlign = [NSLayoutConstraint constraintWithItem:_interactionButton
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0];
    
    [self.view addConstraints:@[hTimeHAlign, hDescriptionAlign]];
    
    [_recapView addInitialConstraints];
}

@end
